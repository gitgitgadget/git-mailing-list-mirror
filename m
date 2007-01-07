From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 2/2] Run regression on the current version
Date: Sat,  6 Jan 2007 23:04:52 -0300
Message-ID: <11681354952305-git-send-email-vonbrand@inf.utfsm.cl>
References: <11681354924120-git-send-email-vonbrand@inf.utfsm.cl> <11681354942365-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sun Jan 07 03:05:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NPQ-0004JF-Q5
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 03:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbXAGCFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 21:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbXAGCFH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 21:05:07 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60712 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932323AbXAGCFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 21:05:03 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0724vJl005594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Jan 2007 23:05:00 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0724u12024005;
	Sat, 6 Jan 2007 23:04:56 -0300
Received: (from vonbrand@localhost)
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8/Submit) id l0724tol024004;
	Sat, 6 Jan 2007 23:04:55 -0300
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.5.0.rc0.g244a7
In-Reply-To: <11681354942365-git-send-email-vonbrand@inf.utfsm.cl>
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 06 Jan 2007 23:05:00 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36119>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 regression/scaffold |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/regression/scaffold b/regression/scaffold
index f8c813f..ee23d4d 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -3,6 +3,7 @@
 set -e
 
 export REPODIR=/tmp/$RANDOM
+export PATH=$PWD/..:$PATH
 
 function empty_repo
 {
-- 
1.5.0.rc0.g244a7
