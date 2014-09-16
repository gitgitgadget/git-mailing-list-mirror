From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 33/35] Rename LOCK_NODEREF to LOCK_NO_DEREF
Date: Tue, 16 Sep 2014 21:33:54 +0200
Message-ID: <1410896036-12750-34-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWz-0000We-A6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbaIPTfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2014 15:35:08 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43317 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754978AbaIPTfH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:35:07 -0400
X-AuditID: 1207440e-f79da6d0000002fc-21-541890ea7cc4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DD.49.00764.AE098145; Tue, 16 Sep 2014 15:35:06 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcb001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:35:05 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqPtqgkSIwd97qhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8Cd0bpYrWCZWMXn3tdsDYy7BbsYOTkkBEwkDk98zgxh
	i0lcuLeerYuRi0NI4DKjxMtrk1lBEkICJ5gk/t9JArHZBHQlFvU0M4EUiQi0MUrsuriZFcRh
	FuhmlHh/4jRQhoNDWMBO4kuDNUgDi4CqxJP7vxlBbF4BV4nemZ8YIbbJSWzY/Z8RpJwTKP51
	XwGIKSTgInHwrh9EtaDEyZlPWEDCzALqEuvnCYGEmQXkJZq3zmaewCgwC0nVLISqWUiqFjAy
	r2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdbLzSzRS00p3cQICX++HYzt62UOMQpwMCrx8Ho8
	Eg8RYk0sK67MPcQoycGkJMr7r1siRIgvKT+lMiOxOCO+qDQntfgQowQHs5II7w9foBxvSmJl
	VWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJ3Xj9Qo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoQuOLgTEKkuIB2rsZpJ23uCAxFygK0XqK0Zhj0sb3vUwc6zq/
	9TMJseTl56VKifPagJQKgJRmlObBLYIlvleM4kB/C/NuAaniASZNuHmvgFYxAa062yMGsqok
	ESEl1cA4c7v3p2rT2wE7JOqOHFjG+tYt5VZVysGzJx7+uPhK/EKraorcE3czc/6j 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257157>

This makes it harder to misread the name as LOCK_NODE_REF.

Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 4 ++--
 cache.h                                  | 2 +-
 lockfile.c                               | 4 ++--
 refs.c                                   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/t=
echnical/api-lockfile.txt
index 3ee4299..40cd524 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -31,11 +31,11 @@ hold_lock_file_for_update::
 	to the file.  The flags parameter is a combination of
 +
 --
-LOCK_NODEREF::
+LOCK_NO_DEREF::
=20
 	Usually symbolic links in path are resolved in path and the
 	lockfile is created by adding ".lock" to the resolved path;
-	however, if `LOCK_NODEREF` is set, then the lockfile is
+	however, if `LOCK_NO_DEREF` is set, then the lockfile is
 	created by adding ".lock" to the path argument itself.
=20
 LOCK_DIE_ON_ERROR::
diff --git a/cache.h b/cache.h
index 45688d5..d610fab 100644
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
index 480c2ba..432d624 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -17,7 +17,7 @@
  *
  *    Usually, if $FILENAME is a symlink, then it is resolved, and the
  *    file ultimately pointed to is the one that is locked and later
- *    replaced.  However, if LOCK_NODEREF is used, then $FILENAME
+ *    replaced.  However, if LOCK_NO_DEREF is used, then $FILENAME
  *    itself is locked and later replaced, even if it is a symlink.
  *
  * 2. Write the new file contents to the lockfile.
@@ -186,7 +186,7 @@ static int lock_file(struct lock_file *lk, const ch=
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
