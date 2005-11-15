From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 15:24:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511151518210.23020@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1132034390.22207.18.camel@dv> <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
 <1132042427.3512.50.camel@dv> <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051115121854.GV30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1445958752-1132064698=:23020"
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 15:28:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec1kI-00055t-4B
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 15:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVKOOZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 09:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKOOZE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 09:25:04 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7329 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750960AbVKOOZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 09:25:02 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8000213F788; Tue, 15 Nov 2005 15:24:59 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 623119F2ED; Tue, 15 Nov 2005 15:24:59 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 45B2D9F2EB; Tue, 15 Nov 2005 15:24:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C8A7813F785; Tue, 15 Nov 2005 15:24:58 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051115121854.GV30496@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11904>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1445958752-1132064698=:23020
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 15 Nov 2005, Petr Baudis wrote:

> Dear diary, on Tue, Nov 15, 2005 at 12:09:42PM CET, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > I think Junio is right: we should not force everybody not to use=20
> > symlinks, only because there happens to be VFAT-, SMB- or HTTP-shared=
=20
> > repositories. As Junio says, if there are people experiencing problem=
s=20
> > because they lack symbolic links, they should fix it.
>=20
> I'm ambivalent here. I would like to have just a single behaviour here,=
=20
> since the symbolic ref otherwise really does not get much testing. But =
I=20
> can also understand that we are breaking tools here.
>=20
> Still, for the reason above, I think we should aim at the symbolic refs
> being the canonical format in the next major release after 1.0, giving
> users time to fix their tools. I can see no advantage in symlinks excep=
t
> the backwards compatibility - speed argument was presented, but I don't
> buy that until I see hard data supporting that.

<yousortofaskedforit>
Well, I can see no good reason for symrefs, except for backwards=20
compatibility! Modern systems do support symlinks, you know?

Let=B4s face it. The main target for git is not Windows users. If we real=
ly=20
want to support all idiocies of all possible ones, how about this one:

If I clone a repository to a USB stick on cygwin, and try to access it=20
from my iBook, it does not work, because for *backward compatibility*=20
reasons, files fitting the 8.3 format are stored in UPPER CASE.

So, I would like to have support for UPPER CASE files in .git, please? An=
d=20
since I cannot do my own testing, please could you force everybody=B4s gi=
t=20
to write OBJECTS and MASTER in UPPER CASE?
</yousortofaskedforit>

Ciao,
Dscho

---1148973799-1445958752-1132064698=:23020--
