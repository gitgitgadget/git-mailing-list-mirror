From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 12/16] contrib/fast-import/import-zips.py: use spaces instead of tabs
Date: Sat, 23 Feb 2013 16:20:50 -0800
Message-ID: <1361665254-42866-13-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
 <1361665254-42866-9-git-send-email-davvid@gmail.com>
 <1361665254-42866-10-git-send-email-davvid@gmail.com>
 <1361665254-42866-11-git-send-email-davvid@gmail.com>
 <1361665254-42866-12-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLp-000269-69
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759370Ab3BXAV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:28 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:61624 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759364Ab3BXAVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:25 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj3so1127620pad.20
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uSeqk9lKrI/TE/ugHi7RHuc4vXDOzyp62TxcgrUtieU=;
        b=JWAwAukZhiaVgNCAS+nqyIm2zgezOi/OmXkzkNUsAS8lVj5FfVGUmYGsASw0Kr+hAw
         iQ/DEMzwYb/38KO6c3fDFoMkLtXkpHWtvOShiIC+UVXMWd7w2oEB7pMWPdTxHcdHvEjS
         mVt3Y/Ueq9nEwtJNZFw+cDnTjceuUMjlb6qBZq7eWBKqFRc6cBcR2LpAiO34l60ecD9n
         HK75hs7KoTv03FaRIO38jcn1hZQ338IiaY/8JLV8TjDkjgzUEDGQmF4ng1wpkYN/JlUh
         hfGQHd++qjhvPfaFVKk3YhepZbMvm5aZAcq5E0zu4vQovwlY6qVXFMgbZ/1PfpGKhLzb
         QyAg==
X-Received: by 10.68.197.70 with SMTP id is6mr10646036pbc.79.1361665284910;
        Sat, 23 Feb 2013 16:21:24 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:24 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-12-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216946>

Follow the conventional Python style by using 4-space indents
instead of hard tabs.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/fast-import/import-zips.py | 98 +++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index b528798..d12c296 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -14,13 +14,13 @@ from time import mktime
 from zipfile import ZipFile
 
 if hexversion < 0x01060000:
-	# The limiter is the zipfile module
-	stderr.write("import-zips.py: requires Python 1.6.0 or later.\n")
-	exit(1)
+    # The limiter is the zipfile module
+    stderr.write("import-zips.py: requires Python 1.6.0 or later.\n")
+    exit(1)
 
 if len(argv) < 2:
-	print 'usage:', argv[0], '<zipfile>...'
-	exit(1)
+    print 'usage:', argv[0], '<zipfile>...'
+    exit(1)
 
 branch_ref = 'refs/heads/import-zips'
 committer_name = 'Z Ip Creator'
@@ -28,51 +28,51 @@ committer_email = 'zip@example.com'
 
 fast_import = popen('git fast-import --quiet', 'w')
 def printlines(list):
-	for str in list:
-		fast_import.write(str + "\n")
+    for str in list:
+        fast_import.write(str + "\n")
 
 for zipfile in argv[1:]:
-	commit_time = 0
-	next_mark = 1
-	common_prefix = None
-	mark = dict()
-
-	zip = ZipFile(zipfile, 'r')
-	for name in zip.namelist():
-		if name.endswith('/'):
-			continue
-		info = zip.getinfo(name)
-
-		if commit_time < info.date_time:
-			commit_time = info.date_time
-		if common_prefix == None:
-			common_prefix = name[:name.rfind('/') + 1]
-		else:
-			while not name.startswith(common_prefix):
-				last_slash = common_prefix[:-1].rfind('/') + 1
-				common_prefix = common_prefix[:last_slash]
-
-		mark[name] = ':' + str(next_mark)
-		next_mark += 1
-
-		printlines(('blob', 'mark ' + mark[name], \
-					'data ' + str(info.file_size)))
-		fast_import.write(zip.read(name) + "\n")
-
-	committer = committer_name + ' <' + committer_email + '> %d +0000' % \
-		mktime(commit_time + (0, 0, 0))
-
-	printlines(('commit ' + branch_ref, 'committer ' + committer, \
-		'data <<EOM', 'Imported from ' + zipfile + '.', 'EOM', \
-		'', 'deleteall'))
-
-	for name in mark.keys():
-		fast_import.write('M 100644 ' + mark[name] + ' ' +
-			name[len(common_prefix):] + "\n")
-
-	printlines(('',  'tag ' + path.basename(zipfile), \
-		'from ' + branch_ref, 'tagger ' + committer, \
-		'data <<EOM', 'Package ' + zipfile, 'EOM', ''))
+    commit_time = 0
+    next_mark = 1
+    common_prefix = None
+    mark = dict()
+
+    zip = ZipFile(zipfile, 'r')
+    for name in zip.namelist():
+        if name.endswith('/'):
+            continue
+        info = zip.getinfo(name)
+
+        if commit_time < info.date_time:
+            commit_time = info.date_time
+        if common_prefix == None:
+            common_prefix = name[:name.rfind('/') + 1]
+        else:
+            while not name.startswith(common_prefix):
+                last_slash = common_prefix[:-1].rfind('/') + 1
+                common_prefix = common_prefix[:last_slash]
+
+        mark[name] = ':' + str(next_mark)
+        next_mark += 1
+
+        printlines(('blob', 'mark ' + mark[name], \
+                    'data ' + str(info.file_size)))
+        fast_import.write(zip.read(name) + "\n")
+
+    committer = committer_name + ' <' + committer_email + '> %d +0000' % \
+        mktime(commit_time + (0, 0, 0))
+
+    printlines(('commit ' + branch_ref, 'committer ' + committer, \
+        'data <<EOM', 'Imported from ' + zipfile + '.', 'EOM', \
+        '', 'deleteall'))
+
+    for name in mark.keys():
+        fast_import.write('M 100644 ' + mark[name] + ' ' +
+            name[len(common_prefix):] + "\n")
+
+    printlines(('',  'tag ' + path.basename(zipfile), \
+        'from ' + branch_ref, 'tagger ' + committer, \
+        'data <<EOM', 'Package ' + zipfile, 'EOM', ''))
 
 if fast_import.close():
-	exit(1)
+    exit(1)
-- 
1.8.2.rc0.247.g811e0c0
