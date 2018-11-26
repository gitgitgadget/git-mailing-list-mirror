Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109141F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 17:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeK0E1n (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 23:27:43 -0500
Received: from mout.web.de ([212.227.15.4]:33757 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0E1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 23:27:43 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgO9u-1g4rei25x8-00Ngay; Mon, 26
 Nov 2018 18:32:54 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, svnpenn@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Mon, 26 Nov 2018 18:32:52 +0100
Message-Id: <20181126173252.1558-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V5+QvHfvWW6a+yOYqs04s4ln0nohnNRl6GoKNlJfxRPFNsVbp5w
 a2RqqC0ammfCtKoOY1TnmuGAKIixGpRGj3EMnQ7rHbVG8nTk4SdXbJBBYo1PgKqu2QXeR2W
 HFQuBT3TDZlZwuTUk6xZ37izT73XslRiq9cOQ0qm09teiEeRVQETkUTpHhTIAf7or3uKTh2
 xLP68FhpkTMwu5kc36E4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h3w+pMjaR1w=:5PPZ+MBHkbyRh3AZ813oTi
 gviHn6MbHeBV2wmBKlc7hSB2amFAgiMKAwaTMXNVe74t2oaUB0jQNEGKGQzaV0+V7o98LLwi+
 LeHAjgl5cDiMufaMkBdVZjuWOmvENy7dqbTiazRBkzNXPQYSAD/P9hT+H0dDz6WWkKJ1xdHa4
 CHvKzanOmh2YWG5sFOmePyM+RGOlHhWXHc//9qumKIa4W6rnGVe1L9BbBkHB6B+wSSnzQJIMD
 dkYyu9km6WtRNQ9/F9X2yRMZK70eu9R/TwWcUReatPkZDYpLwl0+a5Ax4RW627PRBBCfHqKyp
 xImRFj7cuBvMo0JG/msHYLqo4M7fblRaJp6F/IjoW8lSzSPN/O/+zUt3xA+XpRsCEiUdE74h1
 8YORhpyi4U3A0W1xJfopeUqM1xc3VA6jxIwDi0g10yAPLcmcFzBSiGFsCsXxPRXpAYJt3nqC9
 X1LBVT7LGC7e4HVnaKf/BN+Qd3Z/2/VR6wtepK9L8rWdPvzlijRAoE/9tFCJKeZ+D6tMFUJj+
 +HVvl9fimlrgwvHtp/j2v+io/J+1IH3BS68ds1k09hJFRH9WRDR8iawz7khKuwKNgBH0AGIYt
 DPzwbqKcqH6FiAtmAuKf/kHtSwF3HBnJ1kaXbeokbhW17D46p4kbwON/dusR0Bk5yE3E1rlYq
 ydf8Vi+MrUBo9E00SuAsVyWEoPUo9kD2nSZbRSL09wIwxKDPjVNhGUka6qLVjttNZgSyQ4qRM
 Juv6OpS3Q0QZnmos4fjng1nqppXJRYthrpMymzznGbgEeTUTgq4LONs2rf4DLSiE2A02KWxr0
 qUyPam0yL33sZiK3IYhcf7PFVcyxqbWfavTfednotbonjUqpuu1UGNc+4cdd/cDnAhQ3go2+g
 dKOgJqqCfffQV3VrMpYFiH1b3vplJNqNoTOo8eNoDMXHx281X7wo03xTJLTW+c
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

Reported-By: Steven Penny <svnpenn@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

This is the first vesion of a patch.
Is there a chance that you test it ?

abspath.c       |  2 +-
 compat/cygwin.c | 18 ++++++++++++++----
 compat/cygwin.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/abspath.c b/abspath.c
index 9857985329..77a281f789 100644
--- a/abspath.c
+++ b/abspath.c
@@ -55,7 +55,7 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 
 	strbuf_reset(resolved);
 	strbuf_add(resolved, remaining->buf, offset);
-#ifdef GIT_WINDOWS_NATIVE
+#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 	convert_slashes(resolved->buf);
 #endif
 	strbuf_remove(remaining, 0, offset);
diff --git a/compat/cygwin.c b/compat/cygwin.c
index b9862d606d..c4a10cb5a1 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,19 +1,29 @@
 #include "../git-compat-util.h"
 #include "../cache.h"
 
+int cygwin_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+
 int cygwin_offset_1st_component(const char *path)
 {
-	const char *pos = path;
+	char *pos = (char *)path;
+
 	/* unc paths */
-	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
+	if (!skip_dos_drive_prefix(&pos) &&
+			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
 		/* skip server name */
-		pos = strchr(pos + 2, '/');
+		pos = strpbrk(pos + 2, "\\/");
 		if (!pos)
 			return 0; /* Error: malformed unc path */
 
 		do {
 			pos++;
-		} while (*pos && pos[0] != '/');
+		} while (*pos && !is_dir_sep(*pos));
 	}
+
 	return pos + is_dir_sep(*pos) - path;
 }
diff --git a/compat/cygwin.h b/compat/cygwin.h
index 8e52de4644..46f29c0a90 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -1,2 +1,34 @@
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
+
+
+int cygwin_offset_1st_component(const char *path);
+#define offset_1st_component cygwin_offset_1st_component
+
+
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
+int cygwin_skip_dos_drive_prefix(char **path);
+#define skip_dos_drive_prefix cygwin_skip_dos_drive_prefix
+static inline int cygwin_is_dir_sep(int c)
+{
+	return c == '/' || c == '\\';
+}
+#define is_dir_sep cygwin_is_dir_sep
+static inline char *cygwin_find_last_dir_sep(const char *path)
+{
+	char *ret = NULL;
+	for (; *path; ++path)
+		if (is_dir_sep(*path))
+			ret = (char *)path;
+	return ret;
+}
+static inline void convert_slashes(char *path)
+{
+	for (; *path; path++)
+		if (*path == '\\')
+			*path = '/';
+}
+#define find_last_dir_sep cygwin_find_last_dir_sep
 int cygwin_offset_1st_component(const char *path);
 #define offset_1st_component cygwin_offset_1st_component
-- 
2.19.0.271.gfe8321ec05

