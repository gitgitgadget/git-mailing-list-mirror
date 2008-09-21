From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Problems with git over http
Date: Sun, 21 Sep 2008 18:25:44 +0200
Message-ID: <vpqskrto48n.fsf@bauges.imag.fr>
References: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sean Davis" <sdavis2@mail.nih.gov>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:29:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRo2-0001w8-7k
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbYIUQ16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbYIUQ16
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:27:58 -0400
Received: from imag.imag.fr ([129.88.30.1]:60577 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYIUQ15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:27:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8LGPojc016921
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 21 Sep 2008 18:25:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KhRkm-0008HV-94; Sun, 21 Sep 2008 18:25:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KhRkm-0008Nm-5W; Sun, 21 Sep 2008 18:25:44 +0200
In-Reply-To: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com> (Sean Davis's message of "Sat\, 20 Sep 2008 13\:13\:53 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 21 Sep 2008 18:25:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96407>

"Sean Davis" <sdavis2@mail.nih.gov> writes:

> I am new to git and trying to set up a remote repository over http.  I
> have configured apache2 and the bare, empty repository.  Using curl, I
> can get the file HEAD without a password (seems .netrc is correct?).
> However, when I try to push to the repository, I get the following:
>
> sdavis@lestrade:/tmp/testing> git push
> http://sdavis@watson.nci.nih.gov/git/sean_git.git/ master
> fatal: exec http-push failed.

Do you have git-http-push somewhere? What does "git http-push" say?

Probably you have a version of Git compiled with a too old libcurl
(IIRC, it could have "worked", but a bug in the old libcurl could
cause repository corruption, and therefore, git refuses to build
http-push with such version of libcurl).

-- 
Matthieu
