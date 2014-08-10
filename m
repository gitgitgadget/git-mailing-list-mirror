From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 8/8] mv: no SP between function name and the first opening parenthese
Date: Sun, 10 Aug 2014 09:29:36 +0700
Message-ID: <1407637776-19794-9-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGIu0-000491-Dd
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbaHJCaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:30:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45283 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJCaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:30:23 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so9238672pad.37
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=r1MtYSX0QjKjrUBUXqgc5WI3FJpn+93wLj+5Xut8Ol0=;
        b=frYVypv2MIKU3+M3sdswCVKGPubK5dld/0GnoEQW4l72N5Vf3aDZHvDBVmesI1qN5O
         6egDClJN9lB/SjqCOv7suVEk0RQ6SXPNiLxTMxBZ5vWuUl9J5/g82o1l3141HdVh2uCY
         EQCB3zZ8HHAhoCr3C6RI/ytuC26Zyn8GqKAtfSf+LbNC8vWteAP7ag01PuDnjd8ZFZQL
         uyDpxXwxvBmCwBrj2mgURxYnqQAgpNGCct3Edzz0/m3CBBx2DdkJW1Xa7KhTJKT+ZCwK
         F/0dNYoWMSMBna+6W3i/dzCpMNAMW77B5QH9VAinDKWOu4FiZUbYmgczKmCPghDedc2H
         f1rA==
X-Received: by 10.70.136.229 with SMTP id qd5mr33251590pdb.105.1407637823141;
        Sat, 09 Aug 2014 19:30:23 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id ni5sm11037561pdb.35.2014.08.09.19.30.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:30:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:30:26 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255084>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index cbe220f..bf513e0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -230,7 +230,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 		if (!bad)
 			continue;
 		if (!ignore_errors)
-			die (_("%s, source=3D%s, destination=3D%s"),
+			die(_("%s, source=3D%s, destination=3D%s"),
 			     bad, src, dst);
 		if (--argc > 0) {
 			int n =3D argc - i;
@@ -254,7 +254,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (!show_only && mode !=3D INDEX) {
 			if (rename(src, dst) < 0 && !ignore_errors)
-				die_errno (_("renaming '%s' failed"), src);
+				die_errno(_("renaming '%s' failed"), src);
 			if (submodule_gitfile[i]) {
 				if (submodule_gitfile[i] !=3D SUBMODULE_WITH_GITDIR)
 					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
--=20
2.1.0.rc0.78.gc0d8480
