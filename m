Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2BA1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeHBVKR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:10:17 -0400
Received: from mout.web.de ([212.227.15.4]:42707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeHBVKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:10:17 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRl2f-1fMn973gSH-00SuhZ; Thu, 02
 Aug 2018 21:17:36 +0200
Subject: [PATCH 1/6] add, update-index: fix --chmod argument help
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
 <20180802165457.GC15984@sigill.intra.peff.net>
 <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
Date:   Thu, 2 Aug 2018 21:17:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dcc5lbkNypJLd2h4CrA3VNaLTZBQjJwNYMRfyG/YC6cwRNM21Fc
 +PMETEQcwC62N8MnCB8662f8XrMmINb51bfKkH48Ko9dIwhwPQ1FxWAuTO/d7w/oD8s6Q/R
 XOGQ/usmYfGL/2bUN2nNWe68ybZQyFsRBuDPPKJP/DsAuwht5tjHlU4SPiy9ZqwrMGVDdF1
 bijawAgEhiQEWK3aSW7RA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dRrbAM6AWRU=:06UFoj5zfk9h0Hy6q4ZuqK
 83mc03n10vDLGiSlHw0uGwtPKm+gYDaG2IymvNlZS4OvMfIp2G0YLPbjRHH04FNqnihKQVNfr
 zIkiAke2MNNNZWqur5NgVbuPKiikPs/O6bpYwRIzHnuBlWho0fYPL7ju43umspXLFJ1uFI7Hw
 m9CcJPxrSP21jzhYszml71dr13z/zkUPHVYTJIEBcV23Z539BfWIcMD98tzft0fbX5JSuSPNh
 ibM2Vk7+5i0Zjwt4Q4KPibniW6Ag8i69PybjSwHsuQx3T7XVOtBw5e8ml72bIYEivnOX8ls+Z
 CHI1OvpjW6/eW1yemZ5ACO+9AFA3pOv+Q8+4fZwVSoQW10PpFqwd5zIP4AIIndU2YAGWgEAdT
 DIlfecf7RwP4FPTmilX0CEydHxTi4FzgmE88SqDoh8HVCzIghjlxeu9pXzKBy6jfAiNu3YvXg
 vLSrBQyCsjb68f1fi1mG0AJ9JiN7eHudfHmFVROejNgTWJv66ymkcW+E457DjLwu2pz+f8B1S
 1eBp5ygEsqlzVSZr5PERyK1JfoFGT7/EPeXhy0evD1CxD3Pn0lUYMy5t/M95IBsRJhBd16U/+
 +q7uIu0iMi03hCL5leZrtiC8GVMzC3e2hufG7mR4xyKlpGURWuAdU0mzMYriDyR2ECGlC2Z9+
 x8+uRWdykec/QbUsRDR/Cv7uZ58kkC6s4ULis8Wbf5U0NOx4MUCtNdW368ivLDSuKbVS1gbuf
 n1WlgUuTh0oORCiU+to1XUO5cABPfIVzBNCUu8Nnr8UVS2TM9oBmRWF6ec4hvNZ4i5CVJu/y7
 vkGQ5+F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't translate the argument specification for --chmod; "+x" and "-x"
are the literal strings that the commands accept.

Separate alternatives using a pipe character instead of a slash, for
consistency.

Use the flag PARSE_OPT_LITERAL_ARGHELP to prevent parseopt from adding a
pair of angular brackets around the argument help string, as that would
wrongly indicate that users need to replace the literal strings with
some kind of value.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/add.c          | 4 +++-
 builtin/update-index.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8a155dd41e..84bfec9b73 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -304,7 +304,9 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
-	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
+	{ OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",
+	  N_("override the executable bit of the listed files"),
+	  PARSE_OPT_LITERAL_ARGHELP },
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
 	OPT_END(),
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a8709a26ec..7feda6e271 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -971,7 +971,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			(parse_opt_cb *) cacheinfo_callback},
-		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
+		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x",
 			N_("override the executable bit of the listed files"),
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			chmod_callback},
-- 
2.18.0
