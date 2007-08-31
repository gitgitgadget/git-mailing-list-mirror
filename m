From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 09:09:33 -0700
Message-ID: <7vfy1z1y9u.fsf@gitster.siamese.dyndns.org>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	<7vveav21uv.fsf@gitster.siamese.dyndns.org>
	<20070831152153.GA30745@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:09:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR948-0006YW-Jq
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451AbXHaQJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757278AbXHaQJi
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:09:38 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbXHaQJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:09:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A48312BD61;
	Fri, 31 Aug 2007 12:09:56 -0400 (EDT)
In-Reply-To: <20070831152153.GA30745@muzzle> (Eric Wong's message of "Fri, 31
	Aug 2007 08:21:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57179>

Eric Wong <normalperson@yhbt.net> writes:

> This could be a sign of a bigger problem.
>
> Does git-log read .git/config and that could potentially change
> its default output format?  A quick scan of the docs say "no".

"diff.color = always" could break it I would imagine...
