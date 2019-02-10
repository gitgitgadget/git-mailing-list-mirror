Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25261F453
	for <e@80x24.org>; Sun, 10 Feb 2019 00:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBJAUf (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 19:20:35 -0500
Received: from sonic302-7.consmr.mail.bf2.yahoo.com ([74.6.135.46]:40527 "EHLO
        sonic302-7.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbfBJAUf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 19:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549758033; bh=V1PV0dXP5svzCsszMTK6WL1P4JmfjiaaBzaMb1MM3R4=; h=From:To:Cc:Subject:Date:From:Subject; b=GaBsdfu7LDiY7mxzoDK6QzLmG4jqt13XseiLYDNe3zbunHO9zpyo5AZrFY/JNWR/HvvLh61IFZWC3Xf54sryjCLIXR3vzM4tDkwRf2cHcKee1VkplJQzmup4bvG3eICjgowgY2R/c7ACM6GVMZI4tNfjQ5KmMQXJ+jf7A1Ewe0tmRioToSHfSFXHUQOmFGqTUQF7xcxiyskzzs/cOxZx3PCUsIAfntjMYE+5ZD104ngG2USbXtaKTFr5LHIapISOfCojAUy37ZSEExDeLZMpvXjMpX4bs1HMN1LuTOSArDcDD0M2DEQ+fsgaI/uauXYmgu19b5qyMQnZZkQOIn/5rg==
X-YMail-OSG: QEhqUYMVM1loG1Y7Zc_7RyEcdETk4Nc31ITNQDnEbtPTWPCph2BvI9gWigRuzBi
 RGA.1OuwcVHhNaSTknoYnOF3KlwinTGoPCbcsf.76SJNEabQgH7E1Fpt7a49LLk9qt0LZ1aaO.ED
 EVI6E9dqeTZgJMdROv.SVuVoEfTvrwjUwmL0igiXw5HXpU4S6REUlQ9nALpNKhMHRJd5M3Mbp1SL
 mJ12iJY06mfQJqwCmaAabtlh2H6lIcTdyXf2I6I9bxR9LNWyjW3PEqKqlhZXxve.wxHWHll6OKXz
 zd0E5FKznTeYIcYUv76N5dXR0cpHgHNBBOBLr48yJybT6Bx3M73Bhj.y9Ln5unjlaVAoy950bL5z
 nz2YuXp3xkzheL7R2EpTZEQmVtVijhMkFaJMTfgvOqPS4odJ08oNhRHqSaYMKoV7hdZqe6LUlszz
 nybiInuNghKYKeFfyZshjOs3lSwwY4gZpibPG2MaaMRc70kW52f.vMcIIhN1p0dxE.SUilLiaK5T
 TaI8SacJdZnXJ2a3n2Yax4JfaAEX1z.t4pRWMGLTaUHHPvntPaNvMKH_bphKtFP9xs__ZX.XsYIS
 SJCgwNjZJRQhZB51Ry3ehtG5qPbueyODHKs0A8Mh9jO3y424BKVOkwpaO269TYLC9UjArBTklC9X
 tBrBflG9vf5.ylIJl4svpn6PG4R1CXmriXptz_0rNOGwoW2ty1OV.AQGQQxrOlm3TxJj4k5ULRQi
 ZuocbBZNF.9xupQQJN1kKWQ4neNbRb_fFD81mnozAdQvE2ICIPrXI4EZqdXCPwnfki_Q6le9UCnn
 3LaGSaqRioAdb76fMCz1SNB2BQiw0GXkUkQmU__I1IcqllejmGjYavQOUanDpMIT2ZOFJCRZFegO
 7NQ02tF0gacavPSrDsl_eYwAhbE.HiK3otGrUAFRpByHo6qp8nZs_YMknvo8N9fCmJyJqMr.xJj0
 01QABwYVje4L64SFeVLmHQKdEahW66YS6vuxaUSEOj7Ldc85dBP9AC5t_VHQmTW5IHLf73HWvvsl
 aAa2lGuNXlXK0nyBC5BNVPap.FpKy5.DJH2NiZBl.fX5YOwiSo27K_UUv1uE0xV3HOp3Zx.ixbZ4
 fiv8c2px3vlJp2ns2nymdNcEpKaw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sun, 10 Feb 2019 00:20:33 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8eb0bdec07881f35c6aa325538e25953;
          Sun, 10 Feb 2019 00:20:30 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Fix v1] config.mak.uname: add FREAD_READS_DIRECTORIES for NonStop platform
Date:   Sat,  9 Feb 2019 19:20:16 -0500
Message-Id: <20190210002016.22556-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The NonStop platform needs this configuration item specified as
UnfortunatelyYes so that config directory files are correctly processed.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 6bd67eb86..75ff43f1f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -490,6 +490,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	OLD_ICONV = UnfortunatelyYes
 	NO_REGEX = NeedsStartEnd
 	NO_PTHREADS = UnfortunatelyYes
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 
 	# Not detected (nor checked for) by './configure'.
 	# We don't have SA_RESTART on NonStop, unfortunalety.
-- 
2.12.3

