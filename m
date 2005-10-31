From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 11:24:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-2124481105-1130754251=:2916"
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 11:25:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWWpv-00081P-BP
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 11:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVJaKYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 05:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVJaKYP
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 05:24:15 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42888 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932428AbVJaKYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 05:24:14 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0C4A313F164; Mon, 31 Oct 2005 11:24:13 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E1881B4F25; Mon, 31 Oct 2005 11:24:12 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B280B59505; Mon, 31 Oct 2005 11:24:12 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E085613F164; Mon, 31 Oct 2005 11:24:11 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10857>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-2124481105-1130754251=:2916
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 30 Oct 2005, Linus Torvalds wrote:

> It's really not very easy to explain why CVS sucks. After all, sometime=
s=20
> people who have used it for decades have a hard time understanding the=20
> suckiness.
>
> [...]

How about adding the whole explanation as

	git/Documentation/howto/tell-why-cvs-sucks.txt

(maybe with some more polite name)?

Also, I=B4d like to add that CVS branching/merging is no good:

<tryingtoputonalbertsshoes>

Sometimes a developer gets an idea, or the need, to implement a certain=20
feature to a piece of free software. Now, this idea might seem good, but=20
it might take a while to

	- implement it,
	- flesh the bugs out, and
	- maybe realize the idea was not all that good.

All the while, the project is prospering, and you have to keep up-to-date=
.=20
With CVS, you would do "cvs update" every once in a while, and clean up=20
the merge conflicts. In effect, you would track the history of the=20
upstream project.

Often, however, you would like to track *your* changes, too. This is not=20
possible in CVS. You just can=B4t track two different histories in the sa=
me=20
working directory.

Now, if you are working on two or more different ideas, which you want to=
=20
test separately *and* together, you need to merge your local branches=20
every once in a while. If it weren=B4t for "every once in a while", but=20
"once", you still could do it in CVS. If you want to merge several times=20
(keeping the separate development branches), you can=B4t.

</tryingtoputonalbertsshoesfailingmiserably>

Ciao,
Dscho

---1148973799-2124481105-1130754251=:2916--
