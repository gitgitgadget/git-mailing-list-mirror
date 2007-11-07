From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 9/9] gitk i18n: Recode gitk from latin1 to utf8 so that the (c) copyright character is valid utf8.
Date: Wed, 7 Nov 2007 18:47:04 +0100
Message-ID: <200711071847.04454.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071845.40236.stimming@tuhh.de> <200711071846.14097.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoYZ-00047O-1Y
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbXKGRSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 12:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756153AbXKGRSw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:18:52 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46198 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338AbXKGRSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 12:18:52 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HIS33019411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:18:28 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HIQNt007796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:18:27 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071846.14097.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63842>

When using translations, the target language must be encoded in utf-8
because almost all target languages will contain non-ascii characters.
=46or that reason, the non-translated strings should be in utf-8 as wel=
l
so that there isn't any encoding mixup inside the program.
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index b861f8d..684e614 100755
--- a/gitk
+++ b/gitk
@@ -1281,7 +1281,7 @@ proc about {} {
     message $w.m -text [mc "
 Gitk - a commit viewer for git
=20
-Copyright =A9 2005-2006 Paul Mackerras
+Copyright =C2=A9 2005-2006 Paul Mackerras
=20
 Use and redistribute under the terms of the GNU General Public License=
"] \
 	    -justify center -aspect 400 -border 2 -bg white -relief groove
--=20
1.5.3.4.206.g58ba4
