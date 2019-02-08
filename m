Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E361C1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfBHT2i (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:28:38 -0500
Received: from sonic306-24.consmr.mail.ne1.yahoo.com ([66.163.189.86]:49294
        "EHLO sonic306-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727144AbfBHT2i (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 14:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549654116; bh=2+Gty8/NZaabxp21hgW4mulZj3VplIJbh6N8KT1TnP8=; h=From:To:Cc:Subject:Date:From:Subject; b=QyiezMiGoI6Fvhh3bPODnkldha+g5cOfrsamrSGTYQPmolktwRWl9MwA4ajf3x6+wRDx19WS+7MYzRYSlwoNfow/EOGiBGT1CAtJVZ77p7MxAvZSGzXR4XxPKy5217P+QXsDBJoxyi46ap066Ro9WdUTpXNL5tMOx7eXTypvReF4RyGN/+xog0Chzb7JXvA9RPJ/lCnSOmyMmqewTtsrjgpYx9ilkF7NLdxg+/ceIl3rqyZM1EBKl91LOwuTyG/ZYjEf9yRwdHV6XKdGfSuPBWirc1RVa3Assh5mZXZJYaP9fWFhLXBkMgpvc0k5u0XYFZbBMLffm4ehqot7YEYp+w==
X-YMail-OSG: Z8KKYV8VM1k8KnqO3dI3v1yffeeAvyO05Q1p4FL3YT9DpGp_2fai5e5Gw6gtcZD
 vOJKc2ir2BLtFrhUBxWoNzE8hjpVWNUrErC6lGDsY7ZgdF0zN8kqu7UKuom0s0yAr5gIA4nRmqEX
 uJGfBJpYSV.nvNkHyDz2_gvGtS0LtY4T7PD1JPWBUEAcCDrlewAdN9DryR4LuVqK1gl1y4mRB2Jf
 VpwyezEsq7Ch22YIiEDYaQY6NTPzwZ8JVXenLra_R0yYhKaj9SbjoWUo4C8c.V1o8Mbv3.RkTytt
 dIhree68H2XyoO184LrzPbXM32oepA8v.dBh7aovrS6vWEyIDfRuiOgRc5v3E7TLxVa3pB14ES5M
 jHU877rhXta9zPadsgEfs7xbCHkQXEPqzfuCGOoLVBK5fYGQLFNnEj8ALKM4WHv9d9bSoKSyg82a
 yquWIXvpYc3cXzHydaLCeuYBVkwDmTs0GvgGvevzUL_4Zgob9eDoVIOKevrNGEDRB4V32LWB0zr.
 Qy0B7y0aD5oSGuKmlZ3TjLPwPDFVA0vNQGGjS0OC7wE2rpSok.fPmsDc34toWhf68s..Y4d7CH6i
 RMjGhz9X_FKBFu4bbB5rDLWBjE_j8tPXvcqVRYozQQ0mnEoscuNkUaG689W9N7ePo33S6f6nQ0il
 OxllQ.yL632BlStis3lgAwvu4YAfHByJ62e32D07yQBuNA4_FMGZasdWWdEAYfKpOqGfyB4HLXeq
 qMsjFMYAM7ZVIZRJcgNFRjotWjouUIn_ooD.ZZWWdrKHvGoK3mFZmpt.sttYUBQ2cZ4.ncld8wOU
 JlRNS0qD8z_QblYeyBPpfKsonEi465rsJ8OKNEusGAsQDjDDkYIVXYEvofluNhKY25LbkkHq8mh_
 0zhase2zDpQ67tooRIkv3B4i6Yu_Q0DPdpohGJSZqipaALB3D8cupRF3DBJKQ4sNhf2Q8RSOfImx
 dLWwsFwF2kZIK5AEI_Tlu67vICpMOnPqhYMXQhLnWfTTzaA0MLuooxbQZ9hYtATEelEpBy6x2Xvm
 0K2XBWO1GdN7i.zMLp6xcMaNk83WZeYZqRUKpDuQGB0wnbDUcWeXld08p4nZjLrf3u1Zw_wdbnRe
 iO1ZYHfd5fUl5X4EfpoIvJg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Feb 2019 19:28:36 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ac65a831f87ae3d833889ef23c1efe7f;
          Fri, 08 Feb 2019 19:28:32 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Proposed Fix v1] t5318: replace dd if=/dev/zero with truncate
Date:   Fri,  8 Feb 2019 14:28:18 -0500
Message-Id: <20190208192818.21488-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The corrupt_graph_and_verify method has been modified to use
truncate instead of the /dev/zero pseudo-device, which breaks on
platforms where the pseudo-device does not exist. truncate extends
files to a specified length filling with nulls, providing a similar
function to the use of dd in this case.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t5318-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 16d10ebce..d627ffe09 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -383,7 +383,7 @@ corrupt_graph_and_verify() {
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
-	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
+	truncate -s $orig_size "$objdir/info/commit-graph" &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err
-- 
2.12.3

