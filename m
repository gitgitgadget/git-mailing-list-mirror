From: Ben Clifford <benc@hawaga.org.uk>
Subject: [PATCH] Add missing '--summary' to cg-log usage.
Date: Wed, 16 Nov 2005 13:13:27 +1000
Message-ID: <73E454C2-B3C1-44C6-B5FC-28CBAAD7513A@hawaga.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: multipart/mixed; boundary=Apple-Mail-1--815214712
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 04:20:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcDpS-0001aZ-8S
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbVKPDTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 22:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbVKPDTS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:19:18 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:19473 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S965202AbVKPDTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 22:19:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jAG3HrZ7006824;
	Wed, 16 Nov 2005 03:18:27 GMT
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11999>


--Apple-Mail-1--815214712
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Cannot get my mailer (Apple Mail on OS X) to insert this pretty  
trivial patch in a nice way -- included it as an attachment as well.

----- cut ------

Add missing '--summary' to cg-log usage.

Signed-off-by: Ben Clifford

---

cg-log |    2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-log b/cg-log
index 710ce7b..49c3cc0 100755
--- a/cg-log
+++ b/cg-log
@@ -98,7 +98,7 @@
# things more comfortable to SVN users). See cogito(7) for more details
# about revision specification.
-USAGE="cg-log [-c] [-f] [-m] [-M] [-s] [-uUSERNAME] [-d DATE] [-r  
FROM_ID[..TO_ID]] FILE..."
+USAGE="cg-log [-c] [-f] [-m] [-M] [-s] [-uUSERNAME] [-d DATE] [-r  
FROM_ID[..TO_ID]] [--summary] FILE..."
. ${COGITO_LIB}cg-Xlib || exit 1
# Try to fix the annoying "Broken pipe" output. May not help, but  
apparently







--Apple-Mail-1--815214712
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="cogito-log-summary.patch"
Content-Disposition: attachment;
	filename=cogito-log-summary.patch

Add missing '--summary' to cg-log usage.

Signed-off-by: Ben Clifford

---
commit a21b69e87d13a210df78a7eb952ed400109c0438
tree 0ab82b9a97ffaa71e0342e3aa153196ef8e0ac77
parent c51a232e8115ade2f5d61f4ea9dd1246bd7f7db0
author Ben Clifford <benc@hawaga.org.uk> Wed, 16 Nov 2005 09:29:57 +1000
committer Ben Clifford <benc@piva.hawaga.org.uk> Wed, 16 Nov 2005 09:29:57 +1000

 cg-log |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-log b/cg-log
index 710ce7b..49c3cc0 100755
--- a/cg-log
+++ b/cg-log
@@ -98,7 +98,7 @@
 # things more comfortable to SVN users). See cogito(7) for more details
 # about revision specification.
 
-USAGE="cg-log [-c] [-f] [-m] [-M] [-s] [-uUSERNAME] [-d DATE] [-r FROM_ID[..TO_ID]] FILE..."
+USAGE="cg-log [-c] [-f] [-m] [-M] [-s] [-uUSERNAME] [-d DATE] [-r FROM_ID[..TO_ID]] [--summary] FILE..."
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 # Try to fix the annoying "Broken pipe" output. May not help, but apparently

--Apple-Mail-1--815214712
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-1--815214712--
