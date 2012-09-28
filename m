From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 02/21] git p4: remove unused imports
Date: Fri, 28 Sep 2012 08:04:06 -0400
Message-ID: <1348833865-6093-3-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:05:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZJp-0001DO-4f
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2I1MFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:05:09 -0400
Received: from honk.padd.com ([74.3.171.149]:34954 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab2I1MFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:05:09 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 91B665AF2;
	Fri, 28 Sep 2012 05:05:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1BA5331413; Fri, 28 Sep 2012 08:05:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206559>

Found by "pyflakes" checker tool.
Modules shelve, getopt were unused.
Module os.path is exported by os.
Reformat one-per-line as is PEP008 suggested style.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1e7a22a..97699ef 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -7,10 +7,16 @@
 #            2007 Trolltech ASA
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
-
-import optparse, sys, os, marshal, subprocess, shelve
-import tempfile, getopt, os.path, time, platform
-import re, shutil
+import sys
+import os
+import optparse
+import marshal
+import subprocess
+import tempfile
+import time
+import platform
+import re
+import shutil
 
 verbose = False
 
-- 
1.7.12.1.403.g28165e1
