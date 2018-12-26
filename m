Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5EB5211BA
	for <e@80x24.org>; Wed, 26 Dec 2018 23:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeLZXFo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 18:05:44 -0500
Received: from sonic317-31.consmr.mail.bf2.yahoo.com ([74.6.129.86]:36024 "EHLO
        sonic317-31.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbeLZXFo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 18:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545865543; bh=FfihK8CiHDekT9bN1/46Fw78WKtTZrBTu7y8vPoYmms=; h=From:To:Cc:Subject:Date:From:Subject; b=SFoHGEWF5PIaJegEu0jF4WZyTTT45zgGNBVPRor9tBYPjm8INsUTiwODTESVQAi8adXJadXDH61bSgmYRl75rTOLBX5T6LSfXwKm233wLcbcYBScDbpvB154VF6wSS9NA069Sywp4TIW9vUu9lpLR2pjWM3zvVb2+J+H6CO5FGR26V1KgZs7Ep60WcQp0Pb6g/NkSzrbF/BTF3Vx0BJCSErfhRcaQ4AaatgdZaWpfu/vhPwsKLEo5zB5s+8awrV4VvfYASF+Npib2TCnzd/OT/B9DV/4XWlKfasINStOxhmO9rosj9pF6P29ssnoMROLiKNq8qP5znguLcmGkFkFow==
X-YMail-OSG: AdL06moVM1mA2Z52OOAs2uzGL7.x1TybiTXhxqfJWluQ.5kFjMv6F.MWl2tTv25
 dgz3hWHqQCnpYXDz0D_AvJNRq.kbyFFI9Cw9Tj4JJLRDtQ9kOVs_uFcJrI4_XQRqwib49VOPftx5
 pO8nb7_9IrhFddmmDZDIbTvNxJQ_hMVUAARN0iUbAdfT1nGCmLbRBngHFyw4bXRyofA6fVq9O3HO
 XzUDvYmByeJP7b71WTtDj81sPbQPh1yJei51sdndWK37KtEqXbeDTiaBxX_kPP0af0qGCebxVh0R
 r5BrFFWMK_T8ySplHpsSDfbZ7B3zeDjYopRIpih4zFFVHQfKEH2r_RM9swJWkJThPAqKsgzh.qML
 NnOnaIFszvs8hI0jsJt2l8RTo5KxtSaud_WSEMEipwMIsqiG06ao3hXrbDYA8gdfyv4YCo81fQ22
 .srG86ZCLU.xWwuqQDSRYK1XUvaGpUV9bZwuN9UaNxuLVjP0fJIjbHsSQKKcsLavsI12Sk1YCFID
 TRBUC3WHrtDNxltaAcvSj4UGULh8FDO9gjec2E4PEdAs9n2rX0Ltq9AE8cqe4FXgwGieu6SuohoR
 Cc5wJ8UCYg3h9j7_BJz_cXYasMW2HRw0Yp0HMsPVo4pPZkxRuAtv4HyDpPdXCwkGZ0XDW8DcW7gD
 971Lq3PZ9Vad7Lz104zTcJTCNCDK_LkK6ds4QkFE49W8oKcMAWzWYUrNDyH433SZg9.5UWidBrIF
 swZ_OABwk.bLwbv6ZL7rGxlw.c56bHN51fFjDo2dq8W_90SCJNAarlQt02GJxQzOs3148hgEDec2
 bDz8ShM4.xKT3DBG0fM25eJ5qGRtvilCVBgohguE.dmlQ9RfgPbqt.Wq238OyOnRVn.FcAX2erMS
 OOup_Vq_0vZJTi66WxRC0ehYsH1J3b2rf6SZXadrtlkuHfB8mSyXFpIABtsH6pwnuAP4FgU5Utr4
 uaL5ZpwsvTfqIOFUcy8qMVICzHEv52N3Wvcf0notOk92KD9Snlum9XPTDQrsqKn0V9KR2Vyxceg2
 aXyo6N0E8wv0NpvwCJwKmeukIs3ycDFWk1iXSyJ1MFHx4rCv5kzBM6cWDyUrDk.O5MfC3ZG9ofL7
 QfEQbpp3QTVQ.0vju3ONmib9xEw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Dec 2018 23:05:43 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98f6f8df7851f5cc32b027b3d2c09fa1;
          Wed, 26 Dec 2018 23:05:41 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 0/4] HPE NonStop Port Commits
Date:   Wed, 26 Dec 2018 18:05:19 -0500
Message-Id: <20181226230523.16572-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This set of patches is a distilled version of the minimal
set of changes to git that will allow it to run as client
and server on HPE NonStop NSE and NSX systems. NSR systems
are no longer under support so references to them have
been removed. Each patch in this set is independent but
required for correctness.

Randall S. Becker (4):
  transport-helper: use xread instead of read
  config.mak.uname: support for modern HPE NonStop config.
  git-compat-util.h: add FLOSS headers for HPE NonStop
  compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop

 compat/regex/regcomp.c |  8 ++++++++
 config.mak.uname       | 34 +++++++++++++++++++++++++++++-----
 git-compat-util.h      | 15 +++++++++++++++
 transport-helper.c     |  2 +-
 4 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.17.0.10.gb132f7033

