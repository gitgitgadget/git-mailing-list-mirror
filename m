From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 01/35] unable_to_lock_die(): rename function from unable_to_lock_index_die()
Date: Tue, 16 Sep 2014 21:33:22 +0200
Message-ID: <1410896036-12750-2-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTycu-0003GN-90
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbaIPTlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:19 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57580 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754708AbaIPTlS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:18 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2014 15:41:18 EDT
X-AuditID: 12074411-f79d86d000006a97-ea-541890b8510b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.66.27287.8B098145; Tue, 16 Sep 2014 15:34:16 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBc5001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:14 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqLtjgkSIweGTIhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdcWXCB6aCNeIV6x//ZWpgfC/UxcjJISFgIrGx6T8b
	hC0mceHeeiCbi0NI4DKjxJKW6ewQzgkmiXU7JrCCVLEJ6Eos6mlmAkmICLQxSuy6uJkVxGEW
	6GaUeH/iNFCGg0NYIF5i8fFIkAYWAVWJT///MYOEeQVcJOb/l4bYJiexYfd/RpAwp4CrxNd9
	BSCmEFDFwbt+Exh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQICTrB
	HYwzTsodYhTgYFTi4fV4JB4ixJpYVlyZe4hRkoNJSZT3X7dEiBBfUn5KZUZicUZ8UWlOavEh
	RgkOZiUR3h++QDnelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeHkgQvHzC6
	hASLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBcRFfDIwMkBQP0F5tkHbe4oLEXKAo
	ROspRl2OdZ3f+pmEWPLy81KlxHlt+oGKBECKMkrz4FbAUswrRnGgj4UhRvEA0xPcpFdAS5iA
	lpztEQNZUpKIkJJqYLSU8Lj0uoKTr+lSdWXPVw3Gj3M3TEk962U4ZYZ8wq7A9+VKur06nBcm
	RTtt65jaJ9/WF6T5aUVF28Jc6UcNvsy7UyYd+HJn8tnepP7tFuWlj34f8NigpnZ8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257160>

This function is used for other things besides the index, so rename it
accordingly.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-index.c | 2 +-
 cache.h                | 2 +-
 lockfile.c             | 6 +++---
 refs.c                 | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e8c7fd4..6c95988 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -942,7 +942,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-			unable_to_lock_index_die(get_index_file(), lock_error);
+			unable_to_lock_die(get_index_file(), lock_error);
 		}
 		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
diff --git a/cache.h b/cache.h
index dfa1a56..73ba5d0 100644
--- a/cache.h
+++ b/cache.h
@@ -582,7 +582,7 @@ struct lock_file {
 extern int unable_to_lock_error(const char *path, int err);
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
-extern NORETURN void unable_to_lock_index_die(const char *path, int err);
+extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 2a800ce..f1ce154 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -185,7 +185,7 @@ int unable_to_lock_error(const char *path, int err)
 	return -1;
 }
 
-NORETURN void unable_to_lock_index_die(const char *path, int err)
+NORETURN void unable_to_lock_die(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -198,7 +198,7 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		unable_to_lock_index_die(path, errno);
+		unable_to_lock_die(path, errno);
 	return fd;
 }
 
@@ -209,7 +209,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_index_die(path, errno);
+			unable_to_lock_die(path, errno);
 		return fd;
 	}
 
diff --git a/refs.c b/refs.c
index 2ce5d69..8cb3539 100644
--- a/refs.c
+++ b/refs.c
@@ -2167,7 +2167,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			unable_to_lock_die(ref_file, errno);
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.1.0
