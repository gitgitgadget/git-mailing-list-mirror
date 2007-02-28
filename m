From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] Include config.mak in doc/Makefile
Date: Wed, 28 Feb 2007 21:57:42 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070228205742.GA19489@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 21:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMVrw-0004r0-KU
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 21:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbXB1U5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Feb 2007 15:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXB1U5r
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 15:57:47 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63750 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751891AbXB1U5q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Feb 2007 15:57:46 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HMVrt-0005R9-HJ
	for git@vger.kernel.org; Wed, 28 Feb 2007 21:57:45 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l1SKvgSi027258
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 21:57:42 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l1SKvgHw027257
	for git@vger.kernel.org; Wed, 28 Feb 2007 21:57:42 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41005>

config.mak.autogen is already there.  Without this change it is not
possible to override mandir in config.mak.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 Documentation/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9e7f2a7..b6d1d88 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -37,6 +37,7 @@ INSTALL?=3Dinstall
 DOC_REF =3D origin/man
=20
 -include ../config.mak.autogen
+-include ../config.mak
=20
 #
 # Please note that there is a minor bug in asciidoc.
--=20
1.5.0.rc2.gb4df


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D72+PS+point+in+inch
