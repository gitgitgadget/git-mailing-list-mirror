Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBC21F453
	for <e@80x24.org>; Sat,  9 Feb 2019 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfBIR0i (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 12:26:38 -0500
Received: from sonic311-25.consmr.mail.ne1.yahoo.com ([66.163.188.206]:45777
        "EHLO sonic311-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727684AbfBIR0g (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 12:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549733195; bh=h/4oaNRCs/98uUzawIilSefMO+f00Z59h8ttSQnUPCY=; h=From:To:Cc:Subject:Date:From:Subject; b=qM5MAWDmDnLqawuOXIUZjwzxFamduqcGbhm3foeRJI0l/17t9di40GSEdP/SBe9zdr1hI9eYC92SJTE2EAIGheLmuFOYD4oPUvvNZ77BkEtL3lqUGQCjE2S9geFzSOaGWGSea/A2C2NBn6g0WNbSrL55zkSvWUccB26Pk2m92V7/v6wAmTPQVlEuxQMutLSBCNILkXlQRnFb/NudkJIWyf0yBzkHo08cCtaSgB0+eGOdrAmc4YiKMjGTkuGqFq8N5O46KLProFN5fJMQqO2ThPHkpemSThEm1wWYtyxWwYuaX/09dhnPT52TW/ReFKIey1IziWrsKpzAx5/j8jXkFw==
X-YMail-OSG: 0qYV.uIVM1ljSVh.EBY2RA41zbILTtdSCshnBLRa6zAPpdpJFGnIXOfzMzB5oUM
 YnJlrfn0Hd0LPPTja3alRe042xx6xYDhkvrRBgizskvqr_dlPo3msS4EiaUrJcoO5zwqtfxvrIyQ
 .F71wsNPLDjL5V80yNdKgCAHatZmCGBuPutO9YUpaEjPXAhwrs_YhlqK71hbee_M2BUBU1F4Abkc
 wk8HQvq1zWsfc_BE1vK1azfsmPd_o6D.yDr55QdRxjgpI6LvJdiRAmei4erRM1Fs6IBt8R8_RXk0
 0YdeVSKtLuKdZFVC2qQyI2reh_s0uRBes3SIKKHtR7Dcbhc2yxhGHXo4s2_BbcLYAYpvQwfFW3nR
 eTythkXjxRhf3PN6M82Nf6m7LQ7Tfxv6h5ZqOsrTERYeeJ_XrW9.hfm59DCbOpBwyyMIwZAAqnAH
 Gb0xe6z1ZwVNVeTiIxxECExvtoNI_Vtt_q.6eUequ5yTPURBahUQfvi6Mk0mqqAwQgg23cm6djMW
 BdeTsOCgn_VYhRQDWwD2vnpOtpW3X02GhdYSLdD.8bO8MY385xHAnY0jmqhOLzeRZMWqClaVVvM2
 6VS5dhPdGQFj3Sd0.AOdpN.XxvLcs9WJ9H9ZannUBZ41paSQxr9LcRXwjqAzO1_PCX_gmikIdHnX
 Tdmd6Cv3NHFV3SMM0wyxHdWj.JNHWu94JkDHa162_TdEsaPUmSAohBYfzCSAb1bAavQkRKEZllIC
 2eQLkUuTg6d9aSTcSO0pxTpq1T2P_H281pn5ZwuR6qU1Va2JFBFFJaxn52CD0ccDY_Rzu3a0RHda
 s_BdEXA.bpBMyqstTXyZ8pdxSCFONG630L8HuOmIs1ltH69jbGlWivobDJ2TqgVR5.ZYK00_ILHl
 gDo7awzqC6gdR2vBnBK8zCWawlE0gxXwnpeVvQuAVhEXRCrR2hjKdh9XGoUDWaW8YdtWNaCujhoi
 txeCaTIUMFKzBAMzoKCJyMrHViojToNApvrwALA89HBhyMZkj.Wvu30kQ.O_Od2GVAg9zb3Ghg_c
 3xBGYWNDfWg6ynTTkszGHDn4EtHIkn15cxAY7poJ9Z7B7XbjRVv5u0M6U7p2gQSw3kMlArBJ8olx
 Y0OMG4sFOPU0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 9 Feb 2019 17:26:35 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0fbbc3ce2e17e4372638586a0d44ddcf;
          Sat, 09 Feb 2019 17:26:35 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Fix v2] config.mak.uname: move location of bash on NonStop to CoreUtils
Date:   Sat,  9 Feb 2019 12:26:11 -0500
Message-Id: <20190209172611.21340-1-randall.s.becker@rogers.com>
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

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
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

