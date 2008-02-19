From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] push: indicate partialness of error message
Date: Tue, 19 Feb 2008 13:34:40 -0800
Message-ID: <7vablwiqa7.fsf@gitster.siamese.dyndns.org>
References: <20080219162501.GA30451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Garber <jgarber@ionzoft.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRa84-0005fP-Jm
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbYBSVfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbYBSVfW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:35:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbYBSVfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:35:20 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4BF7CDF;
	Tue, 19 Feb 2008 16:35:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 206717CDA; Tue, 19 Feb 2008 16:35:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74458>

Jeff King <peff@peff.net> writes:

> This patch series is meant to address some user issues encountered in
> the recent thread "git push [rejected] question". It's entirely
> message and documentation updates.

Thanks; I think all of them are fine 'maint' material.

Distinguishing between [rejected] and [stale] would belong in
1.5.5 if it is really needed.  Together with the "git checkout
notices forks" enhancement on Daniel's git-checkout rewritten in
C, I think it would solve the issue in the "push [rejected]
question".
