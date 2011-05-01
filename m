From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sun, 01 May 2011 23:21:43 +0200
Message-ID: <vpqsjsy15i0.fsf@bauges.imag.fr>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
	<7vfwp1yqnq.fsf@alter.siamese.dyndns.org>
	<1304238652.9638.1446946253@webmail.messagingengine.com>
	<7vfwoys20u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 01 23:25:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGe8q-0001aF-68
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 23:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab1EAVZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 17:25:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:64145 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab1EAVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 17:25:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p41LLiYN011012
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 1 May 2011 23:21:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QGe5I-0004qz-2O; Sun, 01 May 2011 23:21:44 +0200
In-Reply-To: <7vfwoys20u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 01 May 2011 11:34:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 01 May 2011 23:21:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172546>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael J Gruber" <git@drmicha.warpmail.net> writes:
>
>> I meant "rebase -i", sorry. And in fact I mostly mean those cases where
>> I want to "amend" a commit which is not the top most one.
>
> I also see myself getting tempted to say "rebase -i -2" every once in a
> while; it seems to go well with "log -2" especially when the history is
> linear.

I like that. As easy to type (or more, depending on the keyboard) as ~2,
but no nasty interaction with the shell. OTOH, that would be a
special-case for rebase only (i.e. doesn't make "git show HEAD~2" easier
to type), but that's the most common case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
