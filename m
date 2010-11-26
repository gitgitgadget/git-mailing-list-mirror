From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] cache.h: remove surrounding brackes and realign CE_* constants
Date: Sat, 27 Nov 2010 01:17:43 +0700
Message-ID: <1290795467-7570-2-git-send-email-pclouds@gmail.com>
References: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>, tfransosi@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 26 19:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM2tA-0003DD-Vc
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab0KZSTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 13:19:10 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:36343 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZSTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:19:09 -0500
Received: by pwj5 with SMTP id 5so492729pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9Hv3CL96AJ9y+UiVJvNFiGFKioCVMKyJFMFbhjqpmDo=;
        b=pgfMtT/E0ICQt42GoZrHDlEENI6w0za4vY2rYgOYVHt3az38UnVSU89LGbKWakcuRK
         2tMJCLf5AIo9OHW7s/dEIUGufDLLNEUMl3gAWamcaL88ntAiAGgWQZshFFJqBArm2NAG
         3vduIQgaP8gUjQNz3OvrYrjvrHfInG2kQn3wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MHlS9m+qTjxI8rzw6kfpmVpAx5Na3D3szObS3beSn15ZCSzA/gsKIDRpuI3tUY1s4P
         sIeYoczDJmjvm6lTF/O3INdjH9+hflfzgcF2G9tDFkMh/xhhLj0iOFX+Kx17UpnBE/MN
         PE6F4x9I/qyS7bhtbCzIPGCD8laoq9jNY30QQ=
Received: by 10.142.224.11 with SMTP id w11mr2740651wfg.126.1290795549066;
        Fri, 26 Nov 2010 10:19:09 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w42sm2858639wfh.15.2010.11.26.10.19.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 10:19:08 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Nov 2010 01:18:06 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162266>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..4819cf5 100644
--- a/cache.h
+++ b/cache.h
@@ -170,26 +170,25 @@ struct cache_entry {
  *
  * In-memory only flags
  */
-#define CE_UPDATE    (0x10000)
-#define CE_REMOVE    (0x20000)
-#define CE_UPTODATE  (0x40000)
-#define CE_ADDED     (0x80000)
+#define CE_UPDATE              0x10000
+#define CE_REMOVE              0x20000
+#define CE_UPTODATE            0x40000
+#define CE_ADDED               0x80000
=20
-#define CE_HASHED    (0x100000)
-#define CE_UNHASHED  (0x200000)
-#define CE_CONFLICTED (0x800000)
+#define CE_HASHED             0x100000
+#define CE_UNHASHED           0x200000
+#define CE_WT_REMOVE          0x400000 /* remove in work directory */
+#define CE_CONFLICTED         0x800000
=20
-#define CE_WT_REMOVE (0x400000) /* remove in work directory */
-
-#define CE_UNPACKED  (0x1000000)
+#define CE_UNPACKED          0x1000000
=20
 /*
  * Extended on-disk flags
  */
-#define CE_INTENT_TO_ADD 0x20000000
-#define CE_SKIP_WORKTREE 0x40000000
+#define CE_INTENT_TO_ADD    0x20000000
+#define CE_SKIP_WORKTREE    0x40000000
 /* CE_EXTENDED2 is for future extension */
-#define CE_EXTENDED2 0x80000000
+#define CE_EXTENDED2        0x80000000
=20
 #define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
=20
--=20
1.7.3.2.316.gda8b3
