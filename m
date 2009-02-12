From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bugfix: GIT_EXTERNAL_DIFF with more than one changed
 files
Date: Thu, 12 Feb 2009 12:43:42 -0800
Message-ID: <7vskmjl729.fsf@gitster.siamese.dyndns.org>
References: <20090212133614.GA12746@bigbear>
 <20090212140740.GB3057@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:45:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiR2-0001Cf-UJ
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758755AbZBLUn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758595AbZBLUn5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:43:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758320AbZBLUn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:43:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7B1599D17;
	Thu, 12 Feb 2009 15:43:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 72BC499D13; Thu,
 12 Feb 2009 15:43:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC6E8EDA-F945-11DD-BFEF-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109646>

Jeff King <peff@peff.net> writes:

> So this bug should trigger only in the face of reusing worktree files. I
> checked your test; it constructs a diff between the worktree and the
> index, so it correctly finds the problem.
>
> Acked-by: Jeff King <peff@peff.net>

Thanks, both.

Jeff, according to your analysis, this shouldn't trigger when
core.autocrlf is set, should it?
