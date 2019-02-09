Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6691F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBIS7u (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:59:50 -0500
Received: from sonic304-14.consmr.mail.bf2.yahoo.com ([74.6.128.37]:43263 "EHLO
        sonic304-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfBIS7s (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 13:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549738787; bh=q2MF1sUV83CYJ7dMdT7TSDEmhoB0cILrbwOT39Wgm0k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lkcNaOI1SxiP8heWxjGlyEHpdN9TEVIIe29SljdB0WqaEcd54ngg13VXE5dFHOV8zxnF37uoqwmUFYO2rb41ZNcz/oRbJtqJ/nytj7XxG2WzsH2pJVyEX/agtyj8Col8XbhVK6Mb+1cgUhaplb6WzsVXyhJns9lc+9mCsi9q5GLIziSOaivcIyBbYqPD2lK16Aq0ofGKXZs9spIwZuNTgdY2rDzSoXrQVMnEI2anR4NCsFJ2XF7ykA6Z5o5H+imoeg9mZGcnUhU59kEKFvfg/+bFTm2sOF7WTvtQfbRkH6oz2XRqdFZZD7XWz3n1NZVH30x0xIac7eavbt6avpHlNg==
X-YMail-OSG: 195yj1MVM1lPKF_yvAtwdUttDzjPxawB_C6deIB3xSXqt0HoEeB8Q5Ke4U2Dsvt
 XVgMgtLGRcKih.xR6mbTtshYGDmzK1lk.BxLksngXnhmkRDwWX4Bo05Gyyl_CqY6YB9F13gwWxpu
 lSkin0kGx.TmVTxzW_jkWtbDfC1YUHbimiVIWzSyMz7tNRDMLn9gZQE3_2FGno_suud4Xv.lLG_q
 elU.6DdxjaZwBPEG_aKu3qLrr9BqpVsId7xT8_ynidTubLfHCBfqlvLOGshTUTFaKjN7vpSevJ3D
 KHv2ZI.tnfVZ1GrvUFoqvvUsOLcjsec5TzEK9dY2i8nCU.ZBm1ch2OwI2Jyzh6rWASbk1ON_vZtb
 sUW0CCBCVazlsxT4NLd8kVPjVTgqdkiEOT2bBAMaYNSFc33NMayaUzQOuvTl1bnpaPr_1hryHNI8
 tIeAxN9e6LlPe2bN.jN9H6O8mHu7q6MdVLnS0JH71oHlAumxiUez6Ny6l32iuSpKEGMbmpTd7rWT
 Ee7BDargrc_..QmuDyTpjcQOmBC8FNXuGyHUbsQaLiSu2HTqOpHd3UY6OfHNItbn8QSYu4iv7AV8
 vFSIAPUSm7MqBZWoFV.bzr_ZsaBSemfAx58Oza4UhQ2JpbH2Js.WAEUx.vrfZ2qhNuA_FroXsvKB
 oiVBPQwCRunbnNRHetSbW5qop_obwvAmWw.QQitQlGmleQ68XQwbDePpICxh9NsEEAa6wUdw0jnl
 TdJekzkGtTzwaiPMzfP41BIyao7ETywAfS2w82wRpTBeLRYdXifpWDUzQE0e2b7Dan_MpeVR.hnT
 oP9A.KE8QnudGFfipJ0Lm1ZV_gN6YUad5BaZs9WlTMU8X88M6Ey7fqnIoEtejTJf5Rm258icfo8d
 GIuXjqx.E_nzrlii4ABCFGolcClvgUA0K5YbX5MWvQy8yAD2IioJRUMbUWfDJvmfnRuiLuxZrsBq
 _re4O9KKXOsshoB4Onq3xWV37qubq.PdxqbYF47jcfcKThaayGKhIo0vtufcURmK0c2Lg3cTS1hm
 hf166iw2mAVn.AFDLNP_9kNvFJVC48T7JmlDk5iDCkc2BoVopIrgtdaa9TAdRWvP6KtLvhncWaQR
 NZKjWW99Gkdl8PYzVEkSsDkYQVA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sat, 9 Feb 2019 18:59:47 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 84a16d171cb60baba1591047a4493b27;
          Sat, 09 Feb 2019 18:59:43 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch v1 2/3] t5318: replace use of /dev/zero with generate_zero_bytes
Date:   Sat,  9 Feb 2019 13:59:29 -0500
Message-Id: <20190209185930.5256-3-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190209185930.5256-1-randall.s.becker@rogers.com>
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change removes the dependency on /dev/zero with generate_zero_bytes
appending NUL values to blocks generating wrong signatures for test cases.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t5318-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 16d10ebce..65c1f45b0 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -383,7 +383,7 @@ corrupt_graph_and_verify() {
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
-	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
+	generate_zero_bytes $(($orig_size - $zero_pos)) >> "$objdir/info/commit-graph" &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err
-- 
2.12.3

