From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] untrue statement about git wrapper
Date: Thu, 25 Jan 2007 06:57:50 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070125055750.GA20545@cepheus>
References: <20070125042721.GA6168@cepheus> <20070125045730.GA20345@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 06:58:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9xcZ-0006iQ-Mq
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 06:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbXAYF5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 25 Jan 2007 00:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbXAYF5y
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 00:57:54 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43336 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965364AbXAYF5y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jan 2007 00:57:54 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9xcP-0002Aj-4P; Thu, 25 Jan 2007 06:57:53 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0P5voF7002519;
	Thu, 25 Jan 2007 06:57:50 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0P5voP6002518;
	Thu, 25 Jan 2007 06:57:50 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070125045730.GA20345@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37709>

Hi Shawn
Shawn O. Pearce wrote:
> Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de> wrote:
> > I wonder if there is a simpler way to test changes to git than
> > installing it.  My problem is that even if I run=20
>=20
> Look at the INSTALL file:
>=20
> 	GIT_EXEC_PATH=3D`pwd`
> 	PATH=3D`pwd`:$PATH
> 	GITPERLLIB=3D`pwd`/perl/blib/lib
> 	export GIT_EXEC_PATH PATH GITPERLLIB
>=20
Thanks, that's what I searched for.

While reading INSTALL, I noticed the following

-- >8 --
Delete the now untrue statement that the git wrapper isn't used by the =
core

Some time ago most (if not all) calls use the wrapper to allow moving s=
ome
commands from PATH to execdir.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 INSTALL |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/INSTALL b/INSTALL
index 361c65b..66f64a6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -27,16 +27,13 @@ Issues of note:
  - git normally installs a helper script wrapper called "git", which
    conflicts with a similarly named "GNU interactive tools" program.
=20
-   Tough.  Either don't use the wrapper script, or delete the old GNU
-   interactive tools.  None of the core git stuff needs the wrapper,
-   it's just a convenient shorthand and while it is documented in some
-   places, you can always replace "git commit" with "git-commit"
-   instead.=20
+   Tough. =20
=20
    But let's face it, most of us don't have GNU interactive tools, and
    even if we had it, we wouldn't know what it does.  I don't think it
    has been actively developed since 1997, and people have moved over =
to
-   graphical file managers.
+   graphical file managers.  So I suggest to remove it from your syste=
m
+   if you have it.
=20
  - You can use git after building but without installing if you
    wanted to.  Various git commands need to find other git
--=20
1.5.0.rc2.gd1af2d

--=20
Uwe Kleine-K=F6nig

$ dc -e "5735816763073014741799356604682P"
