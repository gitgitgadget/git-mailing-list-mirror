From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 11/14] Add MinGW header files to build git with MSVC
Date: Fri, 21 Aug 2009 15:30:43 +0200
Message-ID: <ba4e68ae32784d8e0c706fa665fbdbbfe67ce673.1250860247.git.mstormo@gmail.com>
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
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE7-00012X-7k
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbZHUNbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbZHUNba
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:61045 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbZHUNbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:16 -0400
Received: by ey-out-2122.google.com with SMTP id 22so190407eye.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=oHxMDnQofPwu9aEtlindojGxpkF0/Tm2VNsritmcGoI=;
        b=nK99nVyjxuKhmg7EIvchcjpLWAj5W62ZNs3zuCp8nf7j79vrqHyEBl/LbhhfhGYlhe
         rF4WAoJm0J8mCvp8CHsDDr1NQGPhgrs+1ZMTx+dBSVKAAn81DSE9QXTINdDGaWDe370l
         3GCJa3/M2hjkSDtM4ZLLNBC9rf9MPWBaA2F7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H0Sk6KGPXUFhT10CLZsL7Hf6cTONWx15J5OdSu/DyGQWZ2qiw96c4Rg8FmwLJmv+B7
         eCwWaHlrpVGdw9njssj8MIGl9vC7LOcymfbXktN0fhnMLxqCE+armRboOhTI2l2MfyNY
         8/LIrC2bo7gxs+P/LHJjZTOXIy6LV8kyIiQ/U=
Received: by 10.210.133.17 with SMTP id g17mr1171858ebd.93.1250861477048;
        Fri, 21 Aug 2009 06:31:17 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <4b8b550914cfc4e638ff905d9b9aa416e45913f4.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126716>

From: Frank Li <lznuaa@gmail.com>

Added the header files dirent.h, unistd.h and utime.h

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/vcbuild/include/dirent.h    |  128 ++++++++++++++++++++++++++++++++++++
 compat/vcbuild/include/sys/utime.h |   34 ++++++++++
 compat/vcbuild/include/unistd.h    |   92 ++++++++++++++++++++++++++
 compat/vcbuild/include/utime.h     |    1 +
 4 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/vcbuild/include/sys/utime.h
 create mode 100644 compat/vcbuild/include/unistd.h
 create mode 100644 compat/vcbuild/include/utime.h

diff --git a/compat/vcbuild/include/dirent.h b/compat/vcbuild/include/dirent.h
new file mode 100644
index 0000000..440618d
--- /dev/null
+++ b/compat/vcbuild/include/dirent.h
@@ -0,0 +1,128 @@
+/*
+ * DIRENT.H (formerly DIRLIB.H)
+ * This file has no copyright assigned and is placed in the Public Domain.
+ * This file is a part of the mingw-runtime package.
+ *
+ * The mingw-runtime package and its code is distributed in the hope that it
+ * will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR
+ * IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to
+ * warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You are free to use this package and its code without limitation.
+ */
+#ifndef _DIRENT_H_
+#define _DIRENT_H_
+#include <io.h>
+
+#define PATH_MAX 512
+
+#define __MINGW_NOTHROW
+
+#ifndef RC_INVOKED
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct dirent
+{
+	long		d_ino;		/* Always zero. */
+	unsigned short	d_reclen;	/* Always zero. */
+	unsigned short	d_namlen;	/* Length of name in d_name. */
+	char		d_name[FILENAME_MAX]; /* File name. */
+};
+
+/*
+ * This is an internal data structure. Good programmers will not use it
+ * except as an argument to one of the functions below.
+ * dd_stat field is now int (was short in older versions).
+ */
+typedef struct
+{
+	/* disk transfer area for this dir */
+	struct _finddata_t	dd_dta;
+
+	/* dirent struct to return from dir (NOTE: this makes this thread
+	 * safe as long as only one thread uses a particular DIR struct at
+	 * a time) */
+	struct dirent		dd_dir;
+
+	/* _findnext handle */
+	long			dd_handle;
+
+	/*
+	 * Status of search:
+	 *   0 = not started yet (next entry to read is first entry)
+	 *  -1 = off the end
+	 *   positive = 0 based index of next entry
+	 */
+	int			dd_stat;
+
+	/* given path for dir with search pattern (struct is extended) */
+	char			dd_name[PATH_MAX+3];
+} DIR;
+
+DIR* __cdecl __MINGW_NOTHROW opendir (const char*);
+struct dirent* __cdecl __MINGW_NOTHROW readdir (DIR*);
+int __cdecl __MINGW_NOTHROW closedir (DIR*);
+void __cdecl __MINGW_NOTHROW rewinddir (DIR*);
+long __cdecl __MINGW_NOTHROW telldir (DIR*);
+void __cdecl __MINGW_NOTHROW seekdir (DIR*, long);
+
+
+/* wide char versions */
+
+struct _wdirent
+{
+	long		d_ino;		/* Always zero. */
+	unsigned short	d_reclen;	/* Always zero. */
+	unsigned short	d_namlen;	/* Length of name in d_name. */
+	wchar_t		d_name[FILENAME_MAX]; /* File name. */
+};
+
+/*
+ * This is an internal data structure. Good programmers will not use it
+ * except as an argument to one of the functions below.
+ */
+typedef struct
+{
+	/* disk transfer area for this dir */
+	//struct _wfinddata_t	dd_dta;
+
+	/* dirent struct to return from dir (NOTE: this makes this thread
+	 * safe as long as only one thread uses a particular DIR struct at
+	 * a time) */
+	struct _wdirent		dd_dir;
+
+	/* _findnext handle */
+	long			dd_handle;
+
+	/*
+	 * Status of search:
+	 *   0 = not started yet (next entry to read is first entry)
+	 *  -1 = off the end
+	 *   positive = 0 based index of next entry
+	 */
+	int			dd_stat;
+
+	/* given path for dir with search pattern (struct is extended) */
+	wchar_t			dd_name[1];
+} _WDIR;
+
+
+
+_WDIR* __cdecl __MINGW_NOTHROW _wopendir (const wchar_t*);
+struct _wdirent*  __cdecl __MINGW_NOTHROW _wreaddir (_WDIR*);
+int __cdecl __MINGW_NOTHROW _wclosedir (_WDIR*);
+void __cdecl __MINGW_NOTHROW _wrewinddir (_WDIR*);
+long __cdecl __MINGW_NOTHROW _wtelldir (_WDIR*);
+void __cdecl __MINGW_NOTHROW _wseekdir (_WDIR*, long);
+
+
+#ifdef	__cplusplus
+}
+#endif
+
+#endif	/* Not RC_INVOKED */
+
+#endif	/* Not _DIRENT_H_ */
diff --git a/compat/vcbuild/include/sys/utime.h b/compat/vcbuild/include/sys/utime.h
new file mode 100644
index 0000000..582589c
--- /dev/null
+++ b/compat/vcbuild/include/sys/utime.h
@@ -0,0 +1,34 @@
+#ifndef	_UTIME_H_
+#define	_UTIME_H_
+/*
+ * UTIME.H
+ * This file has no copyright assigned and is placed in the Public Domain.
+ * This file is a part of the mingw-runtime package.
+ *
+ * The mingw-runtime package and its code is distributed in the hope that it
+ * will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR
+ * IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to
+ * warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You are free to use this package and its code without limitation.
+ */
+
+/*
+ * Structure used by _utime function.
+ */
+struct _utimbuf
+{
+	time_t	actime;		/* Access time */
+	time_t	modtime;	/* Modification time */
+};
+
+#ifndef	_NO_OLDNAMES
+/* NOTE: Must be the same as _utimbuf above. */
+struct utimbuf
+{
+	time_t	actime;
+	time_t	modtime;
+};
+#endif	/* Not _NO_OLDNAMES */
+
+#endif
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
new file mode 100644
index 0000000..2a4f276
--- /dev/null
+++ b/compat/vcbuild/include/unistd.h
@@ -0,0 +1,92 @@
+#ifndef _UNISTD_
+#define _UNISTD_
+
+/* Win32 define for porting git*/
+
+#ifndef _MODE_T_
+#define	_MODE_T_
+typedef unsigned short _mode_t;
+
+#ifndef	_NO_OLDNAMES
+typedef _mode_t	mode_t;
+#endif
+#endif	/* Not _MODE_T_ */
+
+#ifndef _SSIZE_T_
+#define _SSIZE_T_
+typedef long _ssize_t;
+
+#ifndef	_OFF_T_
+#define	_OFF_T_
+typedef long _off_t;
+
+#ifndef	_NO_OLDNAMES
+typedef _off_t	off_t;
+#endif
+#endif	/* Not _OFF_T_ */
+
+
+#ifndef	_NO_OLDNAMES
+typedef _ssize_t ssize_t;
+#endif
+#endif /* Not _SSIZE_T_ */
+
+typedef signed char int8_t;
+typedef unsigned char   uint8_t;
+typedef short  int16_t;
+typedef unsigned short  uint16_t;
+typedef int  int32_t;
+typedef unsigned   uint32_t;
+typedef long long  int64_t;
+typedef unsigned long long   uint64_t;
+
+typedef long long  intmax_t;
+typedef unsigned long long uintmax_t;
+
+typedef int64_t off64_t;
+
+#define STDOUT_FILENO 1
+#define STDERR_FILENO 2
+
+/* Some defines for _access nAccessMode (MS doesn't define them, but
+ * it doesn't seem to hurt to add them). */
+#define	F_OK	0	/* Check for file existence */
+/* Well maybe it does hurt.  On newer versions of MSVCRT, an access mode
+   of 1 causes invalid parameter error. */
+#define	X_OK	0	/* MS access() doesn't check for execute permission. */
+#define	W_OK	2	/* Check for write permission */
+#define	R_OK	4	/* Check for read permission */
+
+#define	_S_IFIFO	0x1000	/* FIFO */
+#define	_S_IFCHR	0x2000	/* Character */
+#define	_S_IFBLK	0x3000	/* Block: Is this ever set under w32? */
+#define	_S_IFDIR	0x4000	/* Directory */
+#define	_S_IFREG	0x8000	/* Regular */
+
+#define	_S_IFMT		0xF000	/* File type mask */
+
+#define	_S_IXUSR	_S_IEXEC
+#define	_S_IWUSR	_S_IWRITE
+#define	_S_IRUSR	_S_IREAD
+#define	_S_ISDIR(m)	(((m) & _S_IFMT) == _S_IFDIR)
+
+#define	S_IFIFO		_S_IFIFO
+#define	S_IFCHR		_S_IFCHR
+#define	S_IFBLK		_S_IFBLK
+#define	S_IFDIR		_S_IFDIR
+#define	S_IFREG		_S_IFREG
+#define	S_IFMT		_S_IFMT
+#define	S_IEXEC		_S_IEXEC
+#define	S_IWRITE	_S_IWRITE
+#define	S_IREAD		_S_IREAD
+#define	S_IRWXU		_S_IRWXU
+#define	S_IXUSR		_S_IXUSR
+#define	S_IWUSR		_S_IWUSR
+#define	S_IRUSR		_S_IRUSR
+
+
+#define	S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
+#define	S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
+#define	S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
+
+#endif
diff --git a/compat/vcbuild/include/utime.h b/compat/vcbuild/include/utime.h
new file mode 100644
index 0000000..8285f38
--- /dev/null
+++ b/compat/vcbuild/include/utime.h
@@ -0,0 +1 @@
+#include <sys/utime.h>
-- 
1.6.3.msysgit.0.18.gef407
