Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F831F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeHBVKY (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:10:24 -0400
Received: from mout.web.de ([212.227.15.4]:35631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeHBVKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:10:24 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ld2nY-1gBsQp1BpY-00iDFM; Thu, 02
 Aug 2018 21:17:51 +0200
Subject: [PATCH 3/6] pack-objects: specify --index-version argument help
 explicitly
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
Message-ID: <d400a141-ba11-605b-94ec-cb4c859d7a1f@web.de>
Date:   Thu, 2 Aug 2018 21:17:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9kUwiaiDzaGmRgppBVYRGaW8b6WZxLZPiAieA3FpDhg/wjq6BIA
 d5fLTXYUZYbskTphURFrUYUknnq67VoUbD5luLVO/8YJqrM+E1RPLjCSOt7RKQxgL5FKUnU
 YTSOQkDtKeq0ECl0QRa/IzNXQ4jOEDyrdvsylxOedaa5glHl4TbFgVgJQAVebVb8EQNWZmC
 bWXd025uDInQO6R/D9VUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1/uVSki3o8U=:TB9hsn/VtoxAIzORya37Ea
 72zbv1naaR3RY78N2AJP13OtVKmqXBhhYww9PvBSMN7ejg0Q5tdPJ+UjiqYfx4SZtNIyP9Glr
 9xFYoKlc59wM19/RV/qaHgNKbduy7EWDvsSp8RAi0e5FYJeveGfre5N3T8JihHJrW3H/K9WLb
 hlrwoyqpisiKvm+s7DNvG3xPnAJ4F+gmEL6qJKfqh/lZE+ugXYL4kfJyDYZ5/YBapZgyezTod
 RstMlSqQuUe6uMZEsAOvIyNu0p6zUdxet11vc/+823s0xQ+BjKucTiARCUn17Y2ZGsf4ZN6t8
 /WpalpFA+MRlRsn7q1jGPB+c63sIXx8GpUMyDiUYUDmLwgb3VjD6Zmhl+bD+um/pJ1bpLvWli
 UItZXc/27zW25G0c1oCdmg/3R5keheAeY3dBs8R9WKN7NbO+cgmB67JgEBVxtTZHY3gaGJxmm
 cIh2wSuNxAv9m0uVEUJgMlgETx9SrLcBFYkP1UihSKFmcDxTrqxgiXJNH8zVmZ15/hSQUHjOJ
 x17N4Tx1x+MH3pF2mhYhn/dXX/1ZJ2gL/epVNgsbJ0kmvZwsryQCO9Nj2mkU1AWT+L+JD5zgo
 53N/zBkvPm7Hi1mYYpQ34UAvvNfthWTPS1fV3TNGYKII1m5CEkKc+ZxDsf/FoY1fO3SxbNeWi
 01+DD18TC1IiVIVIsAzwrrpdHjP0CJHSU1Q1zTqcBkpSjmqyoPAxJ2crLRcEyZF+mDgClOTJK
 IvPaeDn5sRlv8HkSVPb9dXs+DjOLBtDVaE7RMZ6tjNWcSWucecTZPZXXCKCPAh6nCrSlG9gk0
 0ZAzHwf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap both placeholders in the argument help string in angular brackets
to signal that users needs replace them with some actual value.  Use the
flag PARSE_OPT_LITERAL_ARGHELP to prevent parseopt from adding another
pair.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebc8cefb53..3a5d1fa317 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3110,9 +3110,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "all-progress-implied",
 			 &all_progress_implied,
 			 N_("similar to --all-progress when progress meter is shown")),
-		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("version[,offset]"),
+		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("<version>[,<offset>]"),
 		  N_("write the pack index file in the specified idx format version"),
-		  0, option_parse_index_version },
+		  PARSE_OPT_LITERAL_ARGHELP, option_parse_index_version },
 		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
 			      N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
-- 
2.18.0
