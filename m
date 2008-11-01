From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sun, 02 Nov 2008 00:01:29 +0100
Message-ID: <vpqr65voxti.fsf@bauges.imag.fr>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org>
	<20081031165003.GA5355@steel.home>
	<alpine.DEB.1.00.0811010012320.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<7vej1w73nr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 00:06:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwPWm-00047h-OG
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 00:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYKAXDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 19:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYKAXDy
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 19:03:54 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:36353 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbYKAXDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 19:03:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id mA1N1aaE000469;
	Sun, 2 Nov 2008 00:01:37 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KwPTF-0004mH-Ss; Sun, 02 Nov 2008 00:01:29 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KwPTF-0004hY-P2; Sun, 02 Nov 2008 00:01:29 +0100
In-Reply-To: <7vej1w73nr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 31 Oct 2008 16\:20\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Sun, 02 Nov 2008 00:01:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99787>

Junio C Hamano <gitster@pobox.com> writes:

> The current state of affairs is that there is no remedy if teachers find
> "git checkout -- path" or "git revert HEAD~24" is confusing to new people.
> By introducing "git unstage path" or "git cherry-pick -r HEAD~24",
> teachers can choose to teach what they feel less confusing, and they do
> not have to teach "git checkout -- path" or "git revert HEAD~24".  We
> should stop there.

I think you should go half a step further: officially deprecate
"revert", but keep it supported forever. The reason is just to help
documentation to be homogeneous (I foresee questions of users having
read here about "cherry-pick -R" and there about "revert" and asking
"should I use one or the other"). At least, the man page for "revert"
should state explicitly "this is a convenience alias for ...".

But I agree that removing support for "revert" is probably useless and
somehow harmfull.

(my 2 cents ...)

-- 
Matthieu
