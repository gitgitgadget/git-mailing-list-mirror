From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 02/35] api-lockfile: expand the documentation
Date: Tue, 16 Sep 2014 21:33:23 +0200
Message-ID: <1410896036-12750-3-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyd1-0003In-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbaIPTlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:22 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60007 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754887AbaIPTlT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:19 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2014 15:41:19 EDT
X-AuditID: 1207440d-f797f6d000000a4a-13-541890b943ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F7.81.02634.9B098145; Tue, 16 Sep 2014 15:34:17 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBc6001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:16 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLtzgkSIQf9eE4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOmDdpLmNBg0DF7653rA2M03i7GDk4JARMJF5sku1i
	5AQyxSQu3FvPBmILCVxmlHjT59vFyAVkn2CSuHf/BBNIgk1AV2JRTzMTSEJEoI1RYtfFzawg
	DrNAN6PE+xOnwaqEBRwkrvRfYQXZwCKgKjH7piqIySvgIvFjPjvEMjmJDbv/M4KEOQVcJb7u
	KwAxhYAqDt71m8DIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSMDx
	7mD8v07mEKMAB6MSD6/HI/EQIdbEsuLK3EOMkhxMSqK8/7olQoT4kvJTKjMSizPii0pzUosP
	MUpwMCuJ8P7wBcrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4+YCR
	JSRYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPion4YmBUgKR4gPZ+7AfZW1yQmAsU
	hWg9xajLsa7zWz+TEEtefl6qlDivDUiRAEhRRmke3ApYennFKA70sTDvO5AqHmBqgpv0CmgJ
	E9CSsz1iIEtKEhFSUg2Mdpz2pT5bq9t3T/l9aL+2QnL41dh3rXa9Nquqt8WZxG4yiYo9Hnb/
	/q9Lf/b6Wz6W//FSI+/H8uKdj4LXuC2/Jb+1+VPK0XX+jy/0mUS2Ci056/Z/62X5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257162>

Document a couple more functions and the flags argument as used by
hold_lock_file_for_update() and hold_lock_file_for_append().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 36 +++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index dd89404..b53e300 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -28,9 +28,39 @@ hold_lock_file_for_update::
 	the final destination (e.g. `$GIT_DIR/index`) and a flag
 	`die_on_error`.  Attempt to create a lockfile for the
 	destination and return the file descriptor for writing
-	to the file.  If `die_on_error` flag is true, it dies if
-	a lock is already taken for the file; otherwise it
-	returns a negative integer to the caller on failure.
+	to the file.  The flags parameter is a combination of
++
+--
+LOCK_NODEREF::
+
+	Usually symbolic links in path are resolved in path and the
+	lockfile is created by adding ".lock" to the resolved path;
+	however, if `LOCK_NODEREF` is set, then the lockfile is
+	created by adding ".lock" to the path argument itself.
+
+LOCK_DIE_ON_ERROR::
+
+	If a lock is already taken for the file, `die()` with an error
+	message.  If this option is not specified, return a negative
+	integer to the caller on failure.
+--
+
+hold_lock_file_for_append::
+
+	Like `hold_lock_file_for_update()`, except that additionally
+	the existing contents of the file (if any) are copied to the
+	lockfile and its write pointer is positioned at the end of the
+	file before returning.
+
+unable_to_lock_error::
+
+	Emit an error describing that there was an error locking the
+	specified path.  The err parameter should be the errno of the
+	problem that caused the failure.
+
+unable_to_lock_die::
+
+	Like `unable_to_lock_error()`, but also `die()`.
 
 commit_lock_file::
 
-- 
2.1.0
