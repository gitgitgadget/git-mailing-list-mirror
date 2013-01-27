From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 02/21] git p4: remove unused imports
Date: Sat, 26 Jan 2013 22:11:05 -0500
Message-ID: <1359256284-5660-3-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIfZ-0004Ua-0q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab3A0DMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:12:09 -0500
Received: from honk.padd.com ([74.3.171.149]:58688 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:12:08 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 72C842F3F;
	Sat, 26 Jan 2013 19:12:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2CBB922838; Sat, 26 Jan 2013 22:12:04 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214652>

Found by "pyflakes" checker tool.
Modules shelve, getopt were unused.
Module os.path is exported by os.
Reformat one-per-line as is PEP008 suggested style.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fb77c56..47d092d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -7,16 +7,20 @@
 #            2007 Trolltech ASA
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
-
 import sys
 if sys.hexversion < 0x02040000:
     # The limiter is the subprocess module
     sys.stderr.write("git-p4: requires Python 2.4 or later.\n")
     sys.exit(1)
-
-import optparse, os, marshal, subprocess, shelve
-import tempfile, getopt, os.path, time, platform
-import re, shutil
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
1.8.1.1.460.g6fa8886
