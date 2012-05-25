From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: behaviour of .gitignore
Date: Fri, 25 May 2012 19:31:36 +0200
Message-ID: <vpqr4u8rwuf.fsf@bauges.imag.fr>
References: <4FBFB42D.3090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 19:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyMa-0008DQ-R1
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab2EYRbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 13:31:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38649 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194Ab2EYRbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 13:31:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4PHNYEX012487
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 19:23:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXyMT-0004Ru-CO; Fri, 25 May 2012 19:31:37 +0200
In-Reply-To: <4FBFB42D.3090303@gmail.com> (J. V.'s message of "Fri, 25 May
	2012 10:32:45 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 May 2012 19:23:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PHNYEX012487
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338571415.24774@8+T8vVwVrN8UZ2vcuJTrHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198488>

"J.V." <jvsrvcs@gmail.com> writes:

> On my local machine, I create a /bin/ directory added some bash
> scripts, comitted and then pushed them to the repository.

Can you check that "git show --stat" on the commit you did actually
shows the files as added?

> Now today I do a git pull and they are gone but cannot see that anyone
> deleted them in the git log / history, but there is a /bin/ entry in
> the .gitignore file.

What does "git log -- bin" say?

What does "git status" say?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
