Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E330620A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 04:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbeLOEdj (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 23:33:39 -0500
Received: from mout.web.de ([212.227.17.12]:46547 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbeLOEdi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 23:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1544848416;
        bh=fOmSBUZTPIQJLVp9EJm491DOxmIwMwR5fZPVL2h6LyA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JjBNl6HosFGc+XSO8uO3TM8/yGkCQOHfpObOA5LK4v1rlnLmu9Z1RYYvVVSQUl713
         fVJH72+tq82eKKrg3npbw3+b5ncjNU4LjcjcmWEsSJ2BMHLVKYWXbBcdrVnql2+Wv0
         wrR4rHr5zzjYgwIugetZNe5jQe7AicmPFF/3GW44=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1oGM-1hRVyP3kTa-00tkJE; Sat, 15
 Dec 2018 05:33:35 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, svnpenn@gmail.com, johannes.schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 1/1] git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Sat, 15 Dec 2018 05:33:30 +0100
Message-Id: <20181215043330.20162-1-tboegi@web.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qrv7wYAl4O0oOs6fJSYphxklM2LJH5T4MddZiEKNNjVKcnlaise
 gpBda15M3qMgVbS+eaQT3Qzb8AbCImau8f6lxMLUhPR1zEAcXfZdS+F9BI16yqOMZACsrqb
 vDpI0SUvQKEL6IKwwcFXLKO0p0DYMbigrWyRViMLt2znZiW/3L/rR3t8hqgoVI8JjmXqDuQ
 D69nCSXaMhbGy0e7S+YXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dHL5QCH3te4=:TxNMiz+z/nMw3tQMv6/uVg
 sYcxX+vgGYaY4gVmc5bwv468xXDpK16z07ZxmTS3U53jVejpXu39I9knhDsjbVob11qvbtUB1
 U4gbeKFNIWIalMdDPxn2F9EGVDDoXcWi9F+KTZHPjrvHQjkn8hq7r07g3i0LSzbz811DdLy+4
 Z5IAYqOPff5d7xObXmBhfH7mZ/i/3SGcWOl6UsmtqATqlIBQbuV6H0k0qDEINExa6nU/vQ1f3
 jbYTRkVH00xfwx9jz4dTpq5hlN0QU0VWts4C+TerqYX0i8K+kN70BfllHu5pqFlBO0Iml1+g1
 ar6oSs8Dh3CZpO7mOBHaZ06G4YA/OAN0WE2G+Sto2+A3h05uWcfi+vxPDLz0x1cS7SvQgTyoJ
 0+JYp9fDI9WZIQHE6Ku4iWDR9KvXcddwvq86RHH54I7BxTmaO5EV7z0aMlMR1eRA0JgmKstLO
 x5PgOcNLlstvoxgi2I4TLYXjfBT8OKWYTNJJmux7Zz37ZGxc8XmbBT8PGFt7UN/TfK3e0u4qu
 eRclP4QjXBerr1YC9IK0EWyyHMH4qivhxvDdTU6wO43geqUhwKBg4uDYcuCeeECEc3IQiLtA8
 8P3WWYqlFcJtm+hVIUesgcI0yycaPyiRirc383Yjqjbi1px4rde8VxruMLFeTDlsu8dMlQ5m0
 pj1wzs1c8j+izxobcUtpz0BRQQvltnukCcP4oN+hoCiW+b8CD7NzcK5BYw6aapXzxy4o5g7Um
 POFYxWmI7qAtx6ugNwrbKdKPoZl/634Hjhn5MdZDEsTH1Z1iIIbl8NshggLPHSra0rC3hew/+
 lup7UwSpKxdvXBKCUwTglUkUTy/4d8oEbnb8ZfBp+yx6oQIc1yOXxzHbpTS9nrWQDDOIhIaZr
 Rf1FSYFbZVP8b4nkZ/KlsZKHrpKnZ/YR8coWyxfs1U9FZrZrsOGCPokJYZC/mK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

A regression for cygwin users was introduced with commit 05b458c,
 "real_path: resolve symlinks by hand".

In the the commit message we read:
  The current implementation of real_path uses chdir() in order to resolve
    symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
      process as a whole...

The old (and non-thread-save) OS calls chdir()/pwd() had been
replaced by a string operation.
The cygwin layer "knows" that "C:\cygwin" is an absolute path,
but the new string operation does not.

"git clone <url> C:\cygwin\home\USER\repo" fails like this:
fatal: Invalid path '/home/USER/repo/C:\cygwin\home\USER\repo'

The solution is to implement has_dos_drive_prefix(), skip_dos_drive_prefix()
is_dir_sep(), offset_1st_component() and convert_slashes() for cygwin
in the same way as it is done in 'Git for Windows' in compat/mingw.[ch]

Extract the needed code into compat/win32/path-utils.[ch] and use it
for cygwin as well.

Reported-by: Steven Penny <svnpenn@gmail.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>

Changes since v3:
  Rename e.g. mingw_skip_dos_drive_prefix() into
              win32_skip_dos_drive_prefix()
       as suggested by Dscho, thanls for that.
  Add a tweak in t5601 for cygwin.

The test suite passes now on cygwin.
The "Git for Windows" build was tested was tested on
the gfw/master, with this commit cherry-picked on top.


---
 compat/cygwin.c           | 19 -------------------
 compat/cygwin.h           |  2 --
 compat/mingw.c            | 29 +----------------------------
 compat/mingw.h            | 20 --------------------
 compat/win32/path-utils.c | 28 ++++++++++++++++++++++++++++
 compat/win32/path-utils.h | 20 ++++++++++++++++++++
 config.mak.uname          |  3 ++-
 git-compat-util.h         |  3 ++-
 t/t5601-clone.sh          |  2 +-
 9 files changed, 54 insertions(+), 72 deletions(-)
 delete mode 100644 compat/cygwin.c
 delete mode 100644 compat/cygwin.h
 create mode 100644 compat/win32/path-utils.c
 create mode 100644 compat/win32/path-utils.h

diff --git a/compat/cygwin.c b/compat/cygwin.c
deleted file mode 100644
index b9862d606d..0000000000
--- a/compat/cygwin.c
+++ /dev/null
@@ -1,19 +0,0 @@
-#include "../git-compat-util.h"
-#include "../cache.h"
-
-int cygwin_offset_1st_component(const char *path)
-{
-	const char *pos = path;
-	/* unc paths */
-	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
-		/* skip server name */
-		pos = strchr(pos + 2, '/');
-		if (!pos)
-			return 0; /* Error: malformed unc path */
-
-		do {
-			pos++;
-		} while (*pos && pos[0] != '/');
-	}
-	return pos + is_dir_sep(*pos) - path;
-}
diff --git a/compat/cygwin.h b/compat/cygwin.h
deleted file mode 100644
index 8e52de4644..0000000000
--- a/compat/cygwin.h
+++ /dev/null
@@ -1,2 +0,0 @@
-int cygwin_offset_1st_component(const char *path);
-#define offset_1st_component cygwin_offset_1st_component
diff --git a/compat/mingw.c b/compat/mingw.c
index 34b3880b29..b459e1a291 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -350,7 +350,7 @@ static inline int needs_hiding(const char *path)
 		return 0;
 
 	/* We cannot use basename(), as it would remove trailing slashes */
-	mingw_skip_dos_drive_prefix((char **)&path);
+	win32_skip_dos_drive_prefix((char **)&path);
 	if (!*path)
 		return 0;
 
@@ -2275,33 +2275,6 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return -1;
 }
 
-int mingw_skip_dos_drive_prefix(char **path)
-{
-	int ret = has_dos_drive_prefix(*path);
-	*path += ret;
-	return ret;
-}
-
-int mingw_offset_1st_component(const char *path)
-{
-	char *pos = (char *)path;
-
-	/* unc paths */
-	if (!skip_dos_drive_prefix(&pos) &&
-			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
-		/* skip server name */
-		pos = strpbrk(pos + 2, "\\/");
-		if (!pos)
-			return 0; /* Error: malformed unc path */
-
-		do {
-			pos++;
-		} while (*pos && !is_dir_sep(*pos));
-	}
-
-	return pos + is_dir_sep(*pos) - path;
-}
-
 int xutftowcsn(wchar_t *wcs, const char *utfs, size_t wcslen, int utflen)
 {
 	int upos = 0, wpos = 0;
diff --git a/compat/mingw.h b/compat/mingw.h
index 8c24ddaa3e..30d9fb3e36 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -443,32 +443,12 @@ HANDLE winansi_get_osfhandle(int fd);
  * git specific compatibility
  */
 
-#define has_dos_drive_prefix(path) \
-	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
-int mingw_skip_dos_drive_prefix(char **path);
-#define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
-static inline int mingw_is_dir_sep(int c)
-{
-	return c == '/' || c == '\\';
-}
-#define is_dir_sep mingw_is_dir_sep
-static inline char *mingw_find_last_dir_sep(const char *path)
-{
-	char *ret = NULL;
-	for (; *path; ++path)
-		if (is_dir_sep(*path))
-			ret = (char *)path;
-	return ret;
-}
 static inline void convert_slashes(char *path)
 {
 	for (; *path; path++)
 		if (*path == '\\')
 			*path = '/';
 }
-#define find_last_dir_sep mingw_find_last_dir_sep
-int mingw_offset_1st_component(const char *path);
-#define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
 extern char *mingw_query_user_email(void);
 #define query_user_email mingw_query_user_email
diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
new file mode 100644
index 0000000000..d9d3641de8
--- /dev/null
+++ b/compat/win32/path-utils.c
@@ -0,0 +1,28 @@
+#include "../../git-compat-util.h"
+
+int win32_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+
+int win32_offset_1st_component(const char *path)
+{
+	char *pos = (char *)path;
+
+	/* unc paths */
+	if (!skip_dos_drive_prefix(&pos) &&
+			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
+		/* skip server name */
+		pos = strpbrk(pos + 2, "\\/");
+		if (!pos)
+			return 0; /* Error: malformed unc path */
+
+		do {
+			pos++;
+		} while (*pos && !is_dir_sep(*pos));
+	}
+
+	return pos + is_dir_sep(*pos) - path;
+}
diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
new file mode 100644
index 0000000000..0f70d43920
--- /dev/null
+++ b/compat/win32/path-utils.h
@@ -0,0 +1,20 @@
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
+int win32_skip_dos_drive_prefix(char **path);
+#define skip_dos_drive_prefix win32_skip_dos_drive_prefix
+static inline int win32_is_dir_sep(int c)
+{
+	return c == '/' || c == '\\';
+}
+#define is_dir_sep win32_is_dir_sep
+static inline char *win32_find_last_dir_sep(const char *path)
+{
+	char *ret = NULL;
+	for (; *path; ++path)
+		if (is_dir_sep(*path))
+			ret = (char *)path;
+	return ret;
+}
+#define find_last_dir_sep win32_find_last_dir_sep
+int win32_offset_1st_component(const char *path);
+#define offset_1st_component win32_offset_1st_component
diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..60876e26f4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -187,7 +187,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
-	COMPAT_OBJS += compat/cygwin.o
+	COMPAT_OBJS += compat/win32/path-utils.o
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),FreeBSD)
@@ -527,6 +527,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
+		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
 	BASIC_CFLAGS += -DWIN32 -DPROTECT_NTFS_DEFAULT=1
diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102cae..5702556c89 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -193,10 +193,11 @@
 #endif
 
 #if defined(__CYGWIN__)
-#include "compat/cygwin.h"
+#include "compat/win32/path-utils.h"
 #endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
+#include "compat/win32/path-utils.h"
 #include "compat/mingw.h"
 #elif defined(_MSC_VER)
 #include "compat/msvc.h"
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8bbc7068ac..d6948cbdab 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -487,7 +487,7 @@ test_clone_url () {
 	expect_ssh "$@"
 }
 
-test_expect_success !MINGW 'clone c:temp is ssl' '
+test_expect_success !MINGW,!CYGWIN 'clone c:temp is ssl' '
 	test_clone_url c:temp c temp
 '
 
-- 
2.20.0

