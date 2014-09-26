From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 34/39] Rename LOCK_NODEREF to LOCK_NO_DEREF
Date: Fri, 26 Sep 2014 12:08:34 +0200
Message-ID: <1411726119-31598-35-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSat-0003aa-Rn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbaIZKRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2014 06:17:20 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47273 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756539AbaIZKRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:17:16 -0400
X-AuditID: 1207440d-f797f6d000000a4a-f2-54253b69ba29
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 12.6E.02634.96B35245; Fri, 26 Sep 2014 06:09:45 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMJ013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:44 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsUixO6iqJtprRpiMKdPx6LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oxjG++yF/wRrni8+iRbA+NH/i5G
	Tg4JAROJF4vuskPYYhIX7q1n62Lk4hASuMwo8eXkfyYIZxOTxJqJG1hBqtgEdCUW9TQzgdgi
	AmoSE9sOsYAUMQssZpKYcGgTG0hCWMBO4s/sd2BFLAKqEnt2vANbwSvgKtE2ewkLxDo5iQ27
	/zOC2JxA8cbt18BsIQEXiZb1k1kg6gUlTs58AmRzAC1Ql1g/TwgkzCwgL9G8dTbzBEaBWUiq
	ZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSGzw7mD8v07m
	EKMAB6MSD++NdSohQqyJZcWVuYcYJTmYlER5v1iohgjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS
	4b1jBJTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwWlkBNQoWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIjW+GBirICkeoL0eIO28xQWJuUBRiNZTjLoc
	6zq/9TMJseTl56VKifMesQQqEgApyijNg1sBS4SvGMWBPhbmFQEZxQNMonCTXgEtYQJaonRE
	GWRJSSJCSqqB0UvD8KOpYibbStFox+vLfzpnlZ0V8Xr/YaF9YpY3w2QO79VyU7yT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257543>

This makes it harder to misread the name as LOCK_NODE_REF.

Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 4 ++--
 cache.h                                  | 2 +-
 lockfile.c                               | 2 +-
 refs.c                                   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/t=
echnical/api-lockfile.txt
index 0b8db64..64b250f 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -109,11 +109,11 @@ Flags
 The following flags can be passed to `hold_lock_file_for_update` or
 `hold_lock_file_for_append`:
=20
-LOCK_NODEREF::
+LOCK_NO_DEREF::
=20
 	Usually symbolic links in the destination path are resolved
 	and the lockfile is created by adding ".lock" to the resolved
-	path. If `LOCK_NODEREF` is set, then the lockfile is created
+	path. If `LOCK_NO_DEREF` is set, then the lockfile is created
 	by adding ".lock" to the path argument itself. This option is
 	used, for example, when locking a symbolic reference, which
 	for backwards-compatibility reasons can be a symbolic link
diff --git a/cache.h b/cache.h
index 30883b3..ca64a42 100644
--- a/cache.h
+++ b/cache.h
@@ -583,7 +583,7 @@ struct lock_file {
 	struct strbuf filename;
 };
 #define LOCK_DIE_ON_ERROR 1
-#define LOCK_NODEREF 2
+#define LOCK_NO_DEREF 2
 extern int unable_to_lock_error(const char *path, int err);
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
diff --git a/lockfile.c b/lockfile.c
index cf7f4d0..a1cc08a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -169,7 +169,7 @@ static int lock_file(struct lock_file *lk, const ch=
ar *path, int flags)
 	}
=20
 	strbuf_add(&lk->filename, path, pathlen);
-	if (!(flags & LOCK_NODEREF))
+	if (!(flags & LOCK_NO_DEREF))
 		resolve_symlink(&lk->filename);
 	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
 	lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
diff --git a/refs.c b/refs.c
index c6e15f9a..525ce4b 100644
--- a/refs.c
+++ b/refs.c
@@ -2134,7 +2134,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *refname,
 	lflags =3D 0;
 	if (flags & REF_NODEREF) {
 		refname =3D orig_refname;
-		lflags |=3D LOCK_NODEREF;
+		lflags |=3D LOCK_NO_DEREF;
 	}
 	lock->ref_name =3D xstrdup(refname);
 	lock->orig_ref_name =3D xstrdup(orig_refname);
--=20
2.1.0
