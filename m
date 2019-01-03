Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296061F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfACVEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:04:08 -0500
Received: from sonic308-14.consmr.mail.ne1.yahoo.com ([66.163.187.37]:38967
        "EHLO sonic308-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbfACVEI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 16:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546549447; bh=jvvPLnbpxrdgQLwa79ygStOARpVvOxDs4qyfPndVtxg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Co+rxP8mHg91d9jnbvtEl9gy1NYZT1SGXTMMP8+xALiFCISeopaQSbpcWQLb1OYwl7Ngo44U79j7Xh3FiUb5HgSvsyS0U6jK95xxoD3iwwPdn1pCWclvgvvmqE4+xn2LSfl8ROieyC1cKs6UmOMpZ2R06bbIRNOzEMSPsEdqOTFiaEiH+qCXCXOe7uPuLZIXYshY+WZdMWtioCrEldpreicq7W8RAQ7VQhEHSI/aRZ3O1mi0UQvVT/HbDfX4FwXStDqplO/NsDU4bYBltVqQYtmGWy8byQh7crIIdOwiXlMtWxn0oGrt37eEbMGooOmWXJgo3iJAejr9Ao/onD5gOg==
X-YMail-OSG: x3xe69YVM1nXD51n3fwaNsQZmSHVMoMRYGXOjiKQ51yJ428N2dH1mIxGnWbVqHJ
 khvPwqTRiJm1_3e93aykHzSL_MzlmpGg_WnHIgJVES3nvG6gTT_CPYTq7d5fQW5YZPymsr2v6OTA
 0M2Gxn31fueYkJMEU_NhoY3ipn7yzo_BiOxMXeRstNvPidd8G_Ot4qGAImm5Pfma9V0gm_dI_5Gg
 a49L.VO.svZTBUHKZ_u6MOImjV4irN7KfVrSmqSeg0c4JbPmF2_DFTc1xqYMRPM4UmfJ19r9OKhA
 j3ZUv8LXrDAkW2akZJPWtt0FLUwEj8EmUPP1TAeGjnH1T7A924Gwlwez_4Qc17XmgvimkviSl4rE
 qKReFtFF0QAocIyWwRygY6mW7Ujj.D6ODAiYmP7URM7mxFEUQ83rWTI5RYvQoUMc4QZL6hCPyW28
 PAykXTiHPK5j8Aizlq.Z896ESe3x2RoO.w73yuJi2jm.IoV0F42OS31b7Ep6Vc1Lwh7tGi4Bzt6z
 v0ahH0205Pbi.0EJzidtX1OYmXzHR4bchUd2kWtuEYMva0Kx43P6SovT8yLSSP0om7mSFB7oqJhI
 .zE9TkMotEut_9rKZFWx6_ODQwP20VEqYBGUF1O6NY_j7UWzZAyVuPue04CTH_6U8hQ5cO_2wud5
 L3ljO2PqKKzzIv_H93jBUH4YfBYt1W_SINGHof0fGxhbXfabTozXFgGDt1x2D5bBB5a3mNdKrqZj
 6qU7EejZXVvvcmnlTSOJulqt7qPtgcS.WMXx8G_Dtf82hdJUJV33tKJHuRp24Heb2LmOP_sw8u48
 cQRgU65yoUiayg9jU_eGTnEDImkZuHdKEgBWtuzzgThfeySjp.g0__.MGniToUirHlPAn0xsbwy9
 mV0klJ_Z6DPhJnSQ5z_YI5XBQPBJ9m5qLA0jxueoMt5NBlnYlAWm0CpFGtCGs6OPA5iIMMoDCsqx
 3Pg5i_IkioBHjEwGSSvP4CYFXReF3B5s6f5AI30k9IvmsoONejgJC0ZrhbPRID45_fMG79OFcssi
 CKK_Av0KDeLIv3_3BcnlurMw3JDw_Wsu9aVGhVhnW1CpNMpllKPukvIViKKKSxFHSGXgtCIr3oMA
 VcMGWxhyL_9dzW4qlHAEFmxx2xfpCYIrr
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Jan 2019 21:04:07 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be612531d29230a92e273a46c8c0f700;
          Thu, 03 Jan 2019 21:04:05 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [Patch v5 1/4] transport-helper: use xread instead of read
Date:   Thu,  3 Jan 2019 16:03:48 -0500
Message-Id: <20190103210351.13920-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190103210351.13920-1-randall.s.becker@rogers.com>
References: <20190103210351.13920-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

This fix was needed on HPE NonStop NSE and NSX where SSIZE_MAX is less than
BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
was the only place outside of wrapper.c where it is used instead of xread.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 transport-helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index bf225c698..5afead9f8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1225,9 +1225,8 @@ static int udt_do_read(struct unidirectional_transfer *t)
 		return 0;	/* No space for more. */
 
 	transfer_debug("%s is readable", t->src_name);
-	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
-	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
-		errno != EINTR) {
+	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+	if (bytes < 0 && errno != EINTR) {
 		error_errno(_("read(%s) failed"), t->src_name);
 		return -1;
 	} else if (bytes == 0) {
-- 
2.12.3

