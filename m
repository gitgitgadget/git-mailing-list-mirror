From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A case for tailor
Date: Thu, 17 Nov 2005 13:02:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171300350.2104@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511151931001.1157@wbgn013.biozentrum.uni-wuerzburg.de>
 <pan.2005.11.16.23.40.20.119887@smurf.noris.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-989546038-1132228974=:2104"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 13:06:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EciTm-0000Vy-Dk
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 13:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKQMC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 07:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVKQMC5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 07:02:57 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13500 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750769AbVKQMC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 07:02:56 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6325113FB3B; Thu, 17 Nov 2005 13:02:55 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 429AF9F337; Thu, 17 Nov 2005 13:02:55 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0BBAA9F332; Thu, 17 Nov 2005 13:02:55 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EA5FA13FB3B; Thu, 17 Nov 2005 13:02:54 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.11.16.23.40.20.119887@smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12107>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-989546038-1132228974=:2104
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 17 Nov 2005, Matthias Urlichs wrote:

> Hi, Johannes Schindelin wrote:
>=20
> > Possible explanation: at some early stage, the trunk was named "trunk=
",=20
> > but somehow (don=B4t ask me how, I am a fan of git, not svn) renamed =
to=20
> > "head".
>=20
> Well, you *could* use "-T trunk" to import the first part, ^C when it
> starts complaining about 'head', duplicate the last line of .git/svn2gi=
t
> (incrementing the SVN change number), and continue with "-T head".
>=20
> That hackery sortof depends on Upstream not changing anything *else* wh=
ile
> renaming 'trunk' to 'head' ...
>=20
> Of course, the second possibility is to allow patterns as prefixes, dro=
p
> the distinction of "trunk" and "branch", and store the refs as full
> paths under .git/refs/heads/**. You're welcome to submit a patch; pleas=
e
> don't forget backwards compatibility for those poor souls who need to d=
o
> incremental imports. ;-)

;-), too.

It is not *that* important for me, as that particular project is linear.=20
It is not even important to convert it to git, but I like to pickaxe the=20
source (why not let the machine do the work for you?).

So I will probably not work on svn->git end any more...

Ciao,
Dscho

---1148973799-989546038-1132228974=:2104--
