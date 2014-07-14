From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 1/3] dir.c: coding style fix
Date: Mon, 14 Jul 2014 11:47:11 +0200
Message-ID: <53C3A71F.1020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6cqu-0007lA-Rg
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 11:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbaGNJrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 05:47:17 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:55703 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbaGNJrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 05:47:16 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so3009463wgh.26
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=iFNX3tC4aQ6ySXb8pYkJE9wcDw9SRpJX3lTC67uKq+k=;
        b=t2kYmuMP+cyWkdG6j1WtAujiMEOFS1hwuR2ZqGthCrLir0wC350PahLL8293GcPO/E
         lS1TRpygfVlb2d47h2kWV/02eqaKP1MWiPun7OmGMEfgxvIuA/fdjtL1/okd3QDeNTzF
         nxhQX6xAg9UP0QO7T40Xsu2QBJ3Q5ufMLSI0OjQI6I6leiuzhGFaCChZpf22GePUNdTA
         zQyxopQOf1bwXp90OrVj/AuLahq44hzvNxx+tW/RcUSrCsGKeN6HxyJBFzGYsN13mZXt
         5QLhAEhtQhoJZ+VaADm3rW+OIQlJHJdWGLw2MVKFaoNsmOQWlBa3Y7HNeL6F/7Kj+7lh
         1cPQ==
X-Received: by 10.180.198.116 with SMTP id jb20mr22694391wic.59.1405331233123;
        Mon, 14 Jul 2014 02:47:13 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ev9sm29137435wic.24.2014.07.14.02.47.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 02:47:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253480>

=46rom: =3D?UTF-8?q?Nguy=3DE1=3DBB=3D85n=3D20Th=3DC3=3DA1i=3D20Ng=3DE1=3D=
BB=3D8Dc=3D20Duy?=3D
 <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index e65888d..3068ca8 100644
--- a/dir.c
+++ b/dir.c
@@ -557,8 +557,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 			buf =3D xrealloc(buf, size+1);
 			buf[size++] =3D '\n';
 		}
-	}
-	else {
+	} else {
 		size =3D xsize_t(st.st_size);
 		if (size =3D=3D 0) {
 			close(fd);
@@ -793,9 +792,11 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
=20
 	group =3D &dir->exclude_list_group[EXC_DIRS];
=20
-	/* Pop the exclude lists from the EXCL_DIRS exclude_list_group
+	/*
+	 * Pop the exclude lists from the EXCL_DIRS exclude_list_group
 	 * which originate from directories not in the prefix of the
-	 * path being checked. */
+	 * path being checked.
+	 */
 	while ((stk =3D dir->exclude_stack) !=3D NULL) {
 		if (stk->baselen <=3D baselen &&
 		    !strncmp(dir->basebuf, base, stk->baselen))
@@ -822,8 +823,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 		if (current < 0) {
 			cp =3D base;
 			current =3D 0;
-		}
-		else {
+		} else {
 			cp =3D strchr(base + current + 1, '/');
 			if (!cp)
 				die("oops in prep_exclude");
--=20
2.0.0.9646.g840d1f9.dirty
