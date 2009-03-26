From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Mark forgotten string for translation
Date: Thu, 26 Mar 2009 21:13:45 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200903262113.45310.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 22:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmwtr-0007gv-Qi
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbZCZVMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbZCZVMh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:12:37 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:34691 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbZCZVMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 17:12:36 -0400
X-Greylist: delayed 2699 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2009 17:12:36 EDT
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id n2QKR7C5005799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 26 Mar 2009 21:27:08 +0100
Received: from [192.168.0.101] (e176212167.adsl.alicedsl.de [85.176.212.167])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id n2QKR67b010520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Mar 2009 21:27:07 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114821>

---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index a7294a1..9047cc8 100755
--- a/gitk
+++ b/gitk
@@ -6527,7 +6527,7 @@ proc appendrefs {pos ids var} {
 	}
     }
     if {[llength $tags] > $maxrefs} {
-	$ctext insert $pos "many ([llength $tags])"
+	$ctext insert $pos "[mc "many"] ([llength $tags])"
     } else {
 	set tags [lsort -index 0 -decreasing $tags]
 	set sep {}
-- 
1.6.1.rc3.51.g5832d
