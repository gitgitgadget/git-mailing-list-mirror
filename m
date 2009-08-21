From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 12/14] Add platform files for MSVC porting
Date: Fri, 21 Aug 2009 15:30:44 +0200
Message-ID: <6dd71f163e5410e401fc66088405736d1978ec55.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
 <4b8b550914cfc4e638ff905d9b9aa416e45913f4.1250860247.git.mstormo@gmail.com>
 <ba4e68ae32784d8e0c706fa665fbdbbfe67ce673.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE7-00012X-Vz
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbZHUNbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbZHUNb2
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:28 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:45095 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbZHUNbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:16 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so637069ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=XUmAcSYr0GqkL9D0MtB4llctpu7E+bMbvsNN9bu6F+M=;
        b=p+dSeK7G3lDjzhQHcCB5IqFtQoxAoegeYL9XmexS6K2aK09m1qDyOgZYdcHWleAq6G
         uKIC4xLsDzZRw7O7iLnf1IPbZQNytr2aFDA/q1RCIw4Grf/UsnpqY0Mvfcl2noPyHVBM
         EXSP3y8U1DYeDl5Rvs3hBu2gsomBqCBmdVDwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FCuxjqV+Vj/nVN/9D0ilAonxsxbk83Wr0jH2k+kyI778QhZjNw7XiX+zaZTwQ2aTEy
         rCxZ50ftv2JZngmZKyq+CpFCwsDzEnkQyOguIf65bqYF4vBi1eEMLmEbvODGD0aYjblr
         c4vY0b+kZjTWbvLsHfcL0voFy3w0JPVqv6NeQ=
Received: by 10.210.112.1 with SMTP id k1mr1532089ebc.5.1250861478090;
        Fri, 21 Aug 2009 06:31:18 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <ba4e68ae32784d8e0c706fa665fbdbbfe67ce673.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126718>

From: Frank Li <lznuaa@gmail.com>

Add msvc.c and msvc.h to build git under MSVC

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/msvc.c     |   35 ++++++++++++++++++
 compat/msvc.h     |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    3 ++
 3 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h

diff --git a/compat/msvc.c b/compat/msvc.c
new file mode 100644
index 0000000..ac04a4c
--- /dev/null
+++ b/compat/msvc.c
@@ -0,0 +1,35 @@
+#include "../git-compat-util.h"
+#include "win32.h"
+#include <conio.h>
+#include "../strbuf.h"
+
+DIR *opendir(const char *name)
+{
+	int len;
+	DIR *p;
+	p = (DIR*)malloc(sizeof(DIR));
+	memset(p, 0, sizeof(DIR));
+	strncpy(p->dd_name, name, PATH_MAX);
+	len = strlen(p->dd_name);
+	p->dd_name[len] = '/';
+	p->dd_name[len+1] = '*';
+
+	if (p == NULL)
+		return NULL;
+
+	p->dd_handle = _findfirst(p->dd_name, &p->dd_dta);
+
+	if (p->dd_handle == -1) {
+		free(p);
+		return NULL;
+	}
+	return p;
+}
+int closedir(DIR *dir)
+{
+	_findclose(dir->dd_handle);
+	free(dir);
+	return 0;
+}
+
+#include "mingw.c"
diff --git a/compat/msvc.h b/compat/msvc.h
new file mode 100644
index 0000000..3e22186
--- /dev/null
+++ b/compat/msvc.h
@@ -0,0 +1,102 @@
+#ifndef __MSVC__HEAD
+#define __MSVC__HEAD
+
+/* Define minimize windows version */
+#define WINVER 0x0500
+#define _WIN32_WINNT 0x0500
+#define _WIN32_WINDOWS 0x0410
+#define _WIN32_IE 0x0700
+#define NTDDI_VERSION NTDDI_WIN2KSP1
+#include <winsock2.h>
+#include <direct.h>
+#include <process.h>
+
+/* Configuration */
+#define NO_PREAD
+#define NO_OPENSSL
+#define NO_LIBGEN_H
+#define NO_SYMLINK_HEAD
+#define NO_IPV6
+#define NO_SETENV
+#define NO_UNSETENV
+#define NO_STRCASESTR
+#define NO_STRLCPY
+#define NO_MEMMEM
+#define NO_C99_FORMAT
+#define NO_STRTOUMAX
+#define NO_MKDTEMP
+#define NO_MKSTEMPS
+#define NO_ST_BLOCKS_IN_STRUCT_STAT
+#define NO_NSEC
+#define NO_REGEX
+#define NO_SYS_SELECT_H
+#define NO_PTHEADS
+#define NO_ICONV
+#define NO_PTHREADS
+#define NO_CURL
+#define NO_STRTOUMAX
+#define NO_STRLCPY
+#define NO_UNSETENV
+#define NO_SETENV
+
+#define USE_WIN32_MMAP
+#define USE_NED_ALLOCATOR
+#define HAVE_STRING_H 1
+#define STDC_HEADERS
+#define SNPRINTF_RETURNS_BOGUS
+#define RUNTIME_PREFIX
+#define REGEX_MALLOC
+
+/* Git runtime infomation */
+#define ETC_GITCONFIG "%HOME%"
+#define SHA1_HEADER "block-sha1\\sha1.h"
+#define GIT_EXEC_PATH "bin"
+#define GIT_VERSION "1.6"
+#define BINDIR "bin"
+#define PREFIX "."
+#define GIT_MAN_PATH "man"
+#define GIT_INFO_PATH "info"
+#define GIT_HTML_PATH "html"
+#define DEFAULT_GIT_TEMPLATE_DIR "templates"
+
+/* porting function */
+#define inline __inline
+#define __inline__ __inline
+#define __attribute__(x)
+#define va_copy(dst, src)     ((dst) = (src))
+
+static __inline int strcasecmp (const char *s1, const char *s2)
+{
+	int size1 = strlen(s1);
+	int sisz2 = strlen(s2);
+	return _strnicmp(s1, s2, sisz2 > size1 ? sisz2 : size1);
+}
+
+#undef ERROR
+#undef stat
+#undef _stati64
+#include "compat/mingw.h"
+#undef stat
+#define stat _stati64
+#define _stat64(x,y) mingw_lstat(x,y)
+
+/*
+   Even though _stati64 is normally just defined at _stat64
+   on Windows, we specify it here as a proper struct to avoid
+   compiler warnings about macro redefinition due to magic in
+   mingw.h. Struct taken from ReactOS (GNU GPL license).
+*/
+struct _stati64 {
+	_dev_t  st_dev;
+	_ino_t  st_ino;
+	unsigned short st_mode;
+	short   st_nlink;
+	short   st_uid;
+	short   st_gid;
+	_dev_t  st_rdev;
+	__int64 st_size;
+	time_t  st_atime;
+	time_t  st_mtime;
+	time_t  st_ctime;
+};
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e5e9f39..8ea444f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,6 +113,9 @@
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
 #endif	/* __MINGW32__ */
+#ifdef _MSC_VER
+#include "compat/msvc.h"
+#endif
 
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
-- 
1.6.3.msysgit.0.18.gef407
