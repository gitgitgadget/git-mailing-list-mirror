From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 10/32] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Sat,  6 Sep 2014 09:50:24 +0200
Message-ID: <1409989846-22401-11-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAu8-00055l-U0
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbaIFH70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:26 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59873 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751164AbaIFH7U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:20 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:59:19 EDT
X-AuditID: 1207440f-f79156d000006a5c-32-540abd2b1cbd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.1B.27228.B2DBA045; Sat,  6 Sep 2014 03:52:11 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH9006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:10 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqKu9lyvE4Nk7G4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujEULjrMVbJaseDnNooFxnkgXIyeHhICJxNWnKxkhbDGJC/fWs3Ux
	cnEICVxmlFj9fx0ThHOMSaLp0yV2kCo2AV2JRT3NYAkRgTZGiV0XN7OCJJgFUiQ6nneDjRIW
	CJaYveAMmM0ioCrxdvYNFhCbV8BV4trsY8wQ6+QkNuz+D1bDCRSf3tQJZgsJuEi0n+xnmsDI
	u4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSKDx72DsWi9ziFGAg1GJ
	h7fAgStEiDWxrLgy9xCjJAeTkihv3nKgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHejslAOd6U
	xMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBO+N3UCNgkWp6akVaZk5JQhp
	Jg5OkOFcUiLFqXkpqUWJpSUZ8aDYiC8GRgdIigdo71mQdt7igsRcoChE6ylGXY51nd/6mYRY
	8vLzUqXEeZn2ABUJgBRllObBrYCllVeM4kAfC/PeBxnFA0xJcJNeAS1hAlpins4JsqQkESEl
	1cCY8z2PqfjC2aVOp0r3yaiy1q9h9N99vDAr9PDz88o8a1pb53J/lll/bKXt46WaD1pvc31t
	fNMV+i3T/+LuFdee8Jy7aBUktPlZg0ntC9mIBMYOhqyUlIfZawMUNp/fJZ4+c86q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256569>

There are a few places that use these values, so define constants for
them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    |  4 ++++
 lockfile.c | 11 ++++++-----
 refs.c     |  7 ++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index da77094..41d829b 100644
--- a/cache.h
+++ b/cache.h
@@ -569,6 +569,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 
+/* String appended to a filename to derive the lockfile name: */
+#define LOCK_SUFFIX ".lock"
+#define LOCK_SUFFIX_LEN 5
+
 struct lock_file {
 	struct lock_file *next;
 	int fd;
diff --git a/lockfile.c b/lockfile.c
index 964b3fc..bfea333 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -176,10 +176,11 @@ static char *resolve_symlink(char *p, size_t s)
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
-	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
+	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
+	 * room for adding ".lock" for the lock file name:
 	 */
-	static const size_t max_path_len = sizeof(lk->filename) - 5;
+	static const size_t max_path_len = sizeof(lk->filename) -
+					   LOCK_SUFFIX_LEN;
 
 	if (!lock_file_list) {
 		/* One-time initialization */
@@ -204,7 +205,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, ".lock");
+	strcat(lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		lk->owner = getpid();
@@ -314,7 +315,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - 5; /* .lock */
+	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
 	result_file[i] = 0;
 	if (rename(lk->filename, result_file))
 		return -1;
diff --git a/refs.c b/refs.c
index 5ae8e69..828522d 100644
--- a/refs.c
+++ b/refs.c
@@ -74,7 +74,8 @@ out:
 		if (refname[1] == '\0')
 			return -1; /* Component equals ".". */
 	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+	if (cp - refname >= LOCK_SUFFIX_LEN &&
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
 }
@@ -2545,11 +2546,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
 
 		lock->lk->filename[i] = 0;
 		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = '.';
+		lock->lk->filename[i] = LOCK_SUFFIX[0];
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
2.1.0
