From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH] Documentation: git-svn: fix trunk/fetch svn-remote key typo
Date: Wed, 1 Apr 2009 15:02:30 -0600
Organization: icecavern.net
Message-ID: <200904011502.31465.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nZ90Je1jzU8b2vR"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 23:15:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp7m7-0008PE-9s
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 23:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759575AbZDAVNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 17:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758463AbZDAVNe
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 17:13:34 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:55600 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756808AbZDAVNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 17:13:33 -0400
X-Greylist: delayed 648 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Apr 2009 17:13:33 EDT
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id DC14436548;
	Wed,  1 Apr 2009 15:02:40 -0600 (MDT)
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)=?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()=?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@=?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115416>

--Boundary-00=_nZ90Je1jzU8b2vR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Fix the git-svn documentation svn-remote example section talking about
tags and branches by using the proper key "fetch" instead of "trunk".
Using "trunk" actually might be nice, but it doesn't currently work.

The fetch line for the trunk was also reordered to be at the top of the
list, since most people think about the trunk/tags/branches trio in that
logical order.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


--Boundary-00=_nZ90Je1jzU8b2vR
Content-Type: text/x-patch;
  charset="utf-8";
  name="fa96799d745c94a691cb71a3768afc328718416c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fa96799d745c94a691cb71a3768afc328718416c.diff"

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index cda3389..64f1c55 100644
=2D-- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -672,9 +672,9 @@ listed below are allowed:
 ------------------------------------------------------------------------
 [svn-remote "project-a"]
 	url =3D http://server.org/svn
+	fetch =3D trunk/project-a:refs/remotes/project-a/trunk
 	branches =3D branches/*/project-a:refs/remotes/project-a/branches/*
 	tags =3D tags/*/project-a:refs/remotes/project-a/tags/*
=2D	trunk =3D trunk/project-a:refs/remotes/project-a/trunk
 ------------------------------------------------------------------------
=20
 Keep in mind that the '*' (asterisk) wildcard of the local ref

--Boundary-00=_nZ90Je1jzU8b2vR--
