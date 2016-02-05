From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] one ugly test to verify basic functionality
Date: Fri,  5 Feb 2016 15:57:57 +0700
Message-ID: <1454662677-15137-9-git-send-email-pclouds@gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:59:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcEG-0007p8-Hr
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbcBEI64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:56 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34621 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbcBEI6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:55 -0500
Received: by mail-pf0-f170.google.com with SMTP id o185so65527875pfb.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XgCjHbaznIh8w5afBnDKWQPp6mGWYtyT+IsDxiTjmd4=;
        b=Xlg83ri66cQrRc42PYDAP11k+M7mWtA+dDM3G1BQ0Zo3sBpuFr69BN1ETNB6N/wIzi
         ryesWVEk+a2wCLVh5Tf1diVAF92kTk/oo6feqMgI+zQv0dslWAbliNClC4hvx7Nqu7AN
         9o4NhhIrfwJIN2VWrTjTOjIrwEYsYrGyBuhNjvvzuD8IiNUMinX6ceKv7Yc0QniHt4cr
         eVhaVYCUXocMnH2KxDnc2x2iLW2bhy2Xo06JOSuFOByEPgCeSXOi3Doha6EX9qybM8eE
         DH+g43fIirsnxi2chCzVm10wRr2xXsmiTAdsPBBysREj2Ddbf2U26aNyhiVq9qxBEDY8
         ZzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XgCjHbaznIh8w5afBnDKWQPp6mGWYtyT+IsDxiTjmd4=;
        b=ObmHqEyGY1Gy604hhOeNdBaxuINbzL6qiPQ7uXKYBnMezxOa1x12jkSVIB+9GwJO00
         p150c9QaQsfY55zc8vJk1lowfXV+c7vJnK1tEK9yqEDHH711YOFilJvtOixqbLtbKu4j
         g9GE25cCj3sx+dJc6QPrGliELXynWgf3pipCGJ6fDG09MxJr+PVwC4Fqqq1wLHq7wRF+
         xu1S+HgTuvgbHv+E/vlV5y6jff+5k8GwHsrLBug9u1l28kNmtCg6hVur1vmKe8peRDyq
         7L80KacLcEDsctvj5HW/hqaaJfgEkn/fFgnMqjKAVBG6BsSTbJ79I+lDaHgjz/nWLEwb
         2QXQ==
X-Gm-Message-State: AG10YOSLVXLAxu66ishime3O40Y3Q7XjpLAYyRGqZz5B2mnIStg/l9yIRhRImOwrLVpjLw==
X-Received: by 10.98.71.15 with SMTP id u15mr18343672pfa.161.1454662735474;
        Fri, 05 Feb 2016 00:58:55 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id y26sm22642798pfi.88.2016.02.05.00.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:59:08 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285563>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5544-fetch-resume.sh (new +x) | 42 ++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 t/t5544-fetch-resume.sh

diff --git a/t/t5544-fetch-resume.sh b/t/t5544-fetch-resume.sh
new file mode 100755
index 0000000..dfa033d
--- /dev/null
+++ b/t/t5544-fetch-resume.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description=3D'what'
+
+. ./test-lib.sh
+
+test_expect_success 'what' '
+	test_commit one &&
+	git clone --no-local .git abc &&
+	(
+	cd abc &&
+	mv `ls .git/objects/pack/*.pack` pack &&
+	git unpack-objects < pack &&
+	rm pack &&
+	git fsck
+	) &&
+	test_commit two &&
+	test_commit three &&
+	(
+	cd abc &&
+	git fetch --resume-pack=3Dfoo origin HEAD &&
+	git log --format=3D%s origin/master >actual &&
+	echo one >expected &&
+	test_cmp expected actual &&
+	rm .git/FETCH_HEAD &&
+	mv `ls .git/objects/pack/*.pack` pack &&
+	head -c 123 pack >tmp &&
+	git fetch --resume-pack=3Dtmp origin &&
+	test_path_is_missing tmp &&
+	cmp pack .git/objects/pack/*.pack &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat >expected <<EOF &&
+three
+two
+one
+EOF
+	test_cmp expected actual
+	)
+'
+
+test_done
--=20
2.7.0.377.g4cd97dd
