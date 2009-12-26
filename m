From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Set the repository as it was on an earlier commit
Date: Sat, 26 Dec 2009 15:28:00 +0100
Message-ID: <vpqiqbt95e7.fsf@bauges.imag.fr>
References: <8c6f7f450912251509i67da4665t78be0bb79f2c40d6@mail.gmail.com>
	<adf1fd3d0912251536kbf25272ob0ab8ee90e53861d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergio Belkin <sebelk@gmail.com>, git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Dec 26 15:31:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOXg2-0001uY-C4
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 15:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbZLZOaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2009 09:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbZLZOaw
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 09:30:52 -0500
Received: from imag.imag.fr ([129.88.30.1]:45776 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbZLZOav (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 09:30:51 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nBQES19M029089
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 26 Dec 2009 15:28:01 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NOXcf-0001rk-BN; Sat, 26 Dec 2009 15:28:01 +0100
In-Reply-To: <adf1fd3d0912251536kbf25272ob0ab8ee90e53861d@mail.gmail.com>
 ("Santi =?iso-8859-1?Q?B=E9jar=22's?= message of "Sat\, 26 Dec 2009
 00\:36\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 26 Dec 2009 15:28:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135688>

Santi B=E9jar <santi@agolina.net> writes:

> I don't know if it is possible with porcelain commands, but with
> plumbing you can:
>
> # begin with a clean working dir
> git read-tree B
> git commit
> git reset --hard

I guess

(at the root of the repo)

git checkout B -- .
# git status if you want to check.
git commit

does this. The "-- ." part of "git checkout" asks Git to checkout the
files, but the path limiter prevents it from updating HEAD, so the
HEAD still points to the tip of the branch.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
