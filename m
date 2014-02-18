From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/25] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Tue, 18 Feb 2014 20:39:58 +0700
Message-ID: <1392730814-19656-10-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvD-00071h-AX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654AbaBRNlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:10 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:37807 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650AbaBRNlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:08 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so15871940pdb.38
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MBFMo8888iKMSej1pbl46nMNqR4spgmKpftS8JmW3+M=;
        b=OAjPC62V/aBFKiCEKM/Jri2Z77Me/z47SWmcohdl+ypGhHXG0b4i2FrFv8LMJiNYbH
         W2/a47p6M/GxONcgr46VLpvxxfvgBmS+orR4CUmSYZqfEJ2hckP/ZH2lx19VatsSRehT
         pyLw/p5+Q71lJUbrfk0JF+VklvTWl5odbeRYuaixK3fKxOR4uTeSbaai+vbm2aQ3uwRg
         G1C8JAFho57pAQTuECv3q96eIPatCWDZ5gfbdFoEnBk6hq2Pdq1eU6H7HqpKfofgbSVw
         dbi8iPYYSMLgx0dKhK8US6vF7zkS5zwyWN5pkCTTqJtyNS3b/gLtveNMsWC6bMBpqY52
         wfuw==
X-Received: by 10.68.98.3 with SMTP id ee3mr33320397pbb.31.1392730867807;
        Tue, 18 Feb 2014 05:41:07 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id oa3sm56105799pbb.15.2014.02.18.05.41.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:21 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242306>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..ee3ac10 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -155,7 +155,7 @@ static void determine_whence(struct wt_status *s)
 		whence =3D FROM_MERGE;
 	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		whence =3D FROM_CHERRY_PICK;
-		if (file_exists(git_path("sequencer")))
+		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use =3D 1;
 	}
 	else
--=20
1.8.5.2.240.g8478abd
