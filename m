From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 17:53:35 +0200
Message-ID: <vpqzk6uo2dc.fsf@bauges.imag.fr>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:53:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFWW-0008TS-TD
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab2GTPxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:53:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60626 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab2GTPxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:53:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6KFpm30029270
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2012 17:51:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SsFWJ-0000lb-PE; Fri, 20 Jul 2012 17:53:35 +0200
In-Reply-To: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
	(Thiago Farina's message of "Fri, 20 Jul 2012 12:26:09 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Jul 2012 17:51:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6KFpm30029270
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343404312.02378@lHilFnjaFvBV6y+DGe5q1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201783>

Thiago Farina <tfransosi@gmail.com> writes:

> $ git push origin master # here I expected it would working pushing my
> commits to a feature-work branch in github. Or if I omit master it
> gives me a [rejected] error.
> Everything up-to-date.

If your workflow is to push one branch at a time, and you have the same
naming locally and remotely (i.e. your local branch feature-work should
be pushed as feature-work on github), then you probably want to set the
variable 'push.default' to either 'current', 'upstream' or 'simple' if
you use the last version of Git. Read about it there:

  http://git-scm.com/docs/git-config

(search push.default)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
