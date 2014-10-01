From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 33/38] Rename LOCK_NODEREF to LOCK_NO_DEREF
Date: Wed,  1 Oct 2014 12:28:37 +0200
Message-ID: <1412159322-2622-34-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAg-0002vs-5B
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbaJAK3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 06:29:48 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42567 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548AbaJAK3q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:46 -0400
X-AuditID: 12074414-f79446d000001f1d-a4-542bd799cd72
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A9.61.07965.997DB245; Wed,  1 Oct 2014 06:29:46 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6W026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:44 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0gTYRzGe+9u7qaenefK11laCxWymdEPDgoTtFj/SJAVSKSnu9xwO+Vu
	EycSq0nkUlJJwllLnJGoqQwVpaRYRSiaplKWP0Iwg0UliCKY1p3DH/897/N8vu/Dy/fFUWpQ
	psINnJnlOcaoDgjEKHnqQY3zc3x6omMNox3j9xDaVjGO0nOPp1H615dGQE82PUHpldJylF6v
	LKHL7i6BZFy79mcB0fY6p+Xaeo9FO+tzyLXzFS+B9uPoIe2iJ0o7Od+NXcQzgs5kM+bCS4Zc
	7mhSVpDe98gmL1gNK3LP/pbZwMJuB1DgkDwB17/5EL/eC0dm2gMcIBCnyDEAW9rdwH94j8CV
	pXcBEhVAamBDuX1jQknGwqo7XkyCUNKNwEqvZwMKI5Ngles7kDRGxkBbW59c0gSZCj0PvgJ/
	XRTsePFvQytE/9mYHZM0RabAnqklxM+Hwv7aOdHHxYI42O6iJBslo6G9qw6tBKRzB+Xcppw7
	qHqANoMoxmgxaUyMwSiwORohh+E4ltfQCSaDOYHVWTzAvw1lD3jbH+UFJA7UwcSBrPh0SsYU
	ClaTF0TgiHoP0TAqWiHZ+TqrnhH0mbzFyApeAHFUrSTyXosZoWOsxSyfvxlF4pg6nFh2x6VR
	ZC5jZvNYtoDlN9N9OK6GxK5P4mAoz+ayRTcMRvN2jOAK6fJAlVJgOR3LMxazPlNaaqYgblWK
	gsXeFGmcEAoYk+j6RweABm8rW76PUBiXz7GqcMIgQaQE6S3cVsXmJ/SBcPHFYcRViQoWv+jW
	TT6xBBFLclo3SszMdqSygWhFiO52zRMFUT9s74j/e6qq5lZnIs5Fj4Qe6WktHXw4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257720>

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
index aa7d822..a3cb69b 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -110,11 +110,11 @@ Flags
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
index 414e93c..7ea4e81 100644
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
index 598f4eb..c10eaff 100644
--- a/refs.c
+++ b/refs.c
@@ -2192,7 +2192,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
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
