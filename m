Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970231F453
	for <e@80x24.org>; Sat,  9 Feb 2019 17:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBIRTT (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 12:19:19 -0500
Received: from sonic303-24.consmr.mail.ne1.yahoo.com ([66.163.188.150]:41238
        "EHLO sonic303-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727394AbfBIRTT (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 12:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549732757; bh=WIokRzRqYacxg6QlJ877F7b/8M+Qq9/f5cwd3iJYyLo=; h=From:To:Cc:Subject:Date:From:Subject; b=FEEqLlHBaxnl9zmbXznYx2nmT5CqoYzMLT4qs5mvrSk/7iqFwZXXffCheuAJTsLPTC0LTt1PPcvhZmHEVyTmap/ykB52sVrepAwSLtj4IoWn8Qd/O5HuTzAjkbCbWds9ToLse7/AKRtG8fdzitNlh8bEHbQvvE/J7xa/nk2OkZGbnytI9fIZTHNltBy8bnAjWz5pfRjSSJmgT8kBA1g2/3uCQKX2wPrJj21R50XG5Mzii+ruxUMFi6FyIbQXY8kvFeryCUgBMKMXJJOgCkxlzS+u8S2zNs0sOd3Q9jLJB+gsEz0j7JsVUneGt93OcC6Gra7EjNbzCVec3z80QzPc9w==
X-YMail-OSG: 2QEdkcMVM1mVXXXJALYwJqyzYeKWkMx_5UIKGaeuguLNSW4whDBZyrPfBUjDpq_
 WwPaIQoE.PbHzwZEMyhqElb8rAMCj48mwAI.iPU2gXEZof4xIRC3Nc6Q0NU8tAIVqhwRmbv2HT.U
 2gmSZ8dt8IOBqKfODU0XWXGrLiQ181cRIK.k1M7y9NbH4U5p4Y6An4UGN1a3h2v83xKcTr1u0jiE
 Y3WZT73O._DA1L8HK7FdITh5m_bVczaTeH9OE_CzazNOjgyE8duYC2RxHbTLGfKKmEupDJroqq51
 G0JfKCp3zbiyJ1lNGUtZFeA8fED0_7ITShUQWnSOpQCndKobQ4qpaNskLiGfgjGEVrhxCP4Suic1
 RQEZP4tV4mRVBMesIylkTtiPOw.odXMrfTzNoVhSQcbMF5DxNlnms3TvS06iP9.boUueETTa3lKK
 G9JEEETFGNDokxIAovrXvl9Pqp8d4wyRutLmegaLJiRTONqH_bac0ZEkBOWPLUpMGz1fmwwyDbqm
 2u5BzMNlHdVj.6A4i13cXMB.vbTFlUpO5IR47TnO4Lv1YtqS8Pp9.2UBu9ZBBa5ak7gyJQ2MsqOB
 Fg7iq.9Tgc7NACtp76IVtRGjy9uZPsW.vuTot70EtZzAhqe67e4DiNHFIFMo2jx.MVzbu_2swYMb
 cX4_dt6SW.Rb.AJRtLXCx6uvFDN1gTZ9N4_OGX9DjpKATGQJmcqPRfSuGWFa5Fd9lJJRwV6Attya
 5yAdaln6vdDCqpuoYta8yBkB.bQ_QWjUNspxkCI5EIqJUa0PkTBbiOAVw4nHsnu7rw3XgxihPmEn
 XV.ZBQAUCfOqpVT2fkPuPOmvU78skayogWW_fsRo_9ICTYOWTBH0LwG3NsI0CWYnl3eMncLuhRAA
 VIQkW7VqKSqzJy1iz83VBhgS4MGoVSiUjJEWT1NZShnMrnw5J5aPHvSDFk5Y3.wf8bx3407sH890
 Ggw32uAy.qa8_13wZr6pVLbp940tt._aA6020HxjnyGIxjTPhgJpCiM02Z42dzkqUjIPCyn3dRYL
 I.hlcLLDhV9RTfleU_3K_aCziXfI9cfsLBZzk4lfGB9TxaL8SHJ2tESpnjP0t9T5OxmyA01BNvcv
 MIWm6pSK9yzoe5r3HQ97aWr0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 9 Feb 2019 17:19:17 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 139f72c060334d5704d6f0c716554d26;
          Sat, 09 Feb 2019 17:19:12 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Fix v1] config.mak.uname: move location of bash on NonStop to CoreUtils
Date:   Sat,  9 Feb 2019 12:18:57 -0500
Message-Id: <20190209171857.17116-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The default bash is now officially in /usr/coreutils/bin instead
of in /usr/local/bin. This version of bash is more stable and
recommended for all use as of the J06.22 and L18.02 operating
system revision levels. This new version provides more stability
of test results.
---
 config.mak.uname | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 786bb2f91..6bd67eb86 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -507,9 +507,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# RFE 10-120912-4693 submitted to HP NonStop development.
 	NO_SETITIMER = UnfortunatelyYes
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
-	SHELL_PATH = /usr/local/bin/bash
-	# as of H06.25/J06.14, we might better use this
-	#SHELL_PATH = /usr/coreutils/bin/bash
+	SHELL_PATH = /usr/coreutils/bin/bash
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
-- 
2.12.3

