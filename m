Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0546C1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfFMSxm (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:53:42 -0400
Received: from sonic316-23.consmr.mail.ne1.yahoo.com ([66.163.187.149]:44445
        "EHLO sonic316-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729302AbfFMSxc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jun 2019 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1560452011; bh=jfyMViH3NRTnm7Y89GqcIV1sHDnBxnVZXTjVbbt0VHU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mCopczMT+Cl4xWNQYdkPV16nlznIFX9enNb6jqGLBc/5rw129TmryLuEFNmHwBYxgNOImn+u1p9B7RbO6gCuAy08Yg3oOB4xzPQESLhk1p48e6RQ8JYUq2f6o5XV67Ox204G3py4DEAbPDQsv7bu9ADm52x7Q0LEshI5I4WUxpiJXps/mL3YLqTM2uM27joWsOiELAQgayzRNsvhqkNSawjIOVbZeXPafHaiVDtB2EsSIt6fbfyTVgGQyDZLbFyizmZ/BjFI7EKjkUhftO8B81iNVC1BzeSSsj4ogRNjzlyJBF0zphDLT8PNRIfNgA9+JF0+5wY+W5KLvYIgGgxBAQ==
X-YMail-OSG: H9b0_msVM1mZNeEFXWMYjJHJ6BW1Lx5MYy5dPafoqOBh_WO7MywsoZ6xvA2M4wa
 A2sfsTN9ANCYh6cQR0f3fpyPhiw.vSuZcVGLulwoLj92KpYnh0cLCwzZFpgxbcwf8C4CrkgI14QR
 xgxvtx2Fq2DL7uAt3c0Lk_6Bc7deI7V1LGOMqVoi5yrivUUXW4lb89_b.GMcV4m8zMQtDSC7oTQ8
 OKe0jz55SOrXe2BZOjj03.t7YxmHqB8eJR1szF0dL.J6I3J6t0s95ldZNy7r8qR6pxqkUPpS2Lpy
 Q568vAxUk_UxfIN2NXl02wXcy9tmw2f_YwXf6euXkAyC.Xe5ICJarAeI84LhE2Yc7DR.85asqL.v
 S8mhKV7ipPUY2vn0W8_0DgVRfow09TRdK.cEYmtBtCvdZyH2kdhhtMg._Rn1ym9xH91k2vOVJNY.
 zDfJk4K1J.3C9DP5aVL3df2qbiVzwp0ZmheaWS3SUMI5glyvqMrfbCAXAViCki8aNOAqDZNnXA4T
 fimYjUgOtzZiWGmnLg60O1hR7VIvRKlZBHiNhH3wUltqm3RE4ylppvIIy7BZR9ABTIZgTLoKqG0U
 W3EcreXu0JZov4SYv86N1R251guoiTD8ywn7Q0YMydheTKOE1To23qprxhjkgg6oqouEnmo2msAF
 uqj0szvUL.5YcFPEUgQnewpAialYM7Hts6ug6RZQNE6Tr5oT0V95Zzrq38iSbF5wJyboNT09FmVU
 LlUV1hFblEPoiz.S3zK4ec.XpZly4RYAHGwoEZVMC6L1iDnWyTcDf7z6QtasGKP6Z_8YSXTJGhdR
 lDJsaAN7213u0a7KBmIsqH_DmjyF6AAcB26eB9.Dcy3gdqr8UZSXzUNHrFTLWexULcvN5O6gKtic
 KWr0RuqkmQxoVXmXr1256ND1m2mr3Uv7_CNcAVEHVXnEVhbIryDtoXfKNgO0sExKuYwHxt2SPKMc
 8ilKd5FdijS4iFoFnM5Ykj7MZV8uMWOlxEGM1ihkyXfgX3CWW7Q.zZH42twy_Hs4HamcCtzbJl9q
 6ChIKM5Cq4e2kt8ch8EU6qWxQx0GkUWZ9uHDLjwnv3.6RFt1YTbT7iB.X4MSxHbw6r67EEJO2LKK
 xbmDp0zZErshvg3L1gaKiNDI_CiP5uE7e4KSonZes6DWS_F5HMga22akFkVr3JRtHocEqAQlAHx2
 pcvo1tndt2BX0CN9o7WIs3CYSwAYSZHWAEk3dRfd8dLqVGz_5xWUyiMU4APKyW1zYCSONvrm8cVJ
 FbpPuOqBUafo58t5izXld_0gpjhzh373j7Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Jun 2019 18:53:31 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0df5561e6e714d6e0f0f0c310b112dc6;
          Thu, 13 Jun 2019 18:53:26 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 2/5] t9601-cvsimport-vendor-branch: exclude test if cvs is not installed
Date:   Thu, 13 Jun 2019 14:53:10 -0400
Message-Id: <20190613185313.16120-3-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190613185313.16120-1-randall.s.becker@rogers.com>
References: <20190613185313.16120-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The t9601-cvsimport-vendor-branch test requires the cvs package to
be installed on the system on which the test is being run. The test
will fail if cvs is not installed. The patch checks that cvs is
installed by running the object without arguments, which should
complete successfully if available.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t9601-cvsimport-vendor-branch.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index 827d39f5bf..a473f07d2d 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -32,8 +32,16 @@
 #       tag has been removed.
 
 test_description='git cvsimport handling of vendor branches'
+
 . ./lib-cvs.sh
 
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+	skip_all='skipping git-cvsimport tests, cvs not found'
+	test_done
+fi
+
 setup_cvs_test_repository t9601
 
 test_expect_success PERL 'import a module with a vendor branch' '
-- 
2.22.0

