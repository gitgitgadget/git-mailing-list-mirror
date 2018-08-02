Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262291F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeHBVKb (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:10:31 -0400
Received: from mout.web.de ([212.227.15.14]:47701 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeHBVKb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:10:31 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hsk-1g5io42N26-00umoh; Thu, 02
 Aug 2018 21:17:58 +0200
Subject: [PATCH 4/6] send-pack: specify --force-with-lease argument help
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
Message-ID: <d4233136-45de-51ec-e8dd-b4879d42358e@web.de>
Date:   Thu, 2 Aug 2018 21:17:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KN9RLxDYIqPZyqkC+uXQE7qY4dQKhJJqKkLoI19Frp1X60Jo1Xf
 ZHzL+HJxZoinJB/fPgnm/frBKV8zuXt6TOxdknKIwz3IAu1/EzIDF8XZAQZXNBcT2fHlwcU
 DQTmCsQWt8nz2ZpyVTUudWOdlzrT8o3nF43LCc406C6c8ysW0XLCXDgw21X4f4R6IWYVaRr
 G4IMz/ze9Dh3D0FUGKgBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8Fo0D6aWBhs=:QILO2ToEvKiZIriFZwNY14
 LPKjaGQqL/wvYf2UwKmQqxHEyhWvu0XKt4apGp5KRBUR6W9lrm8VpfCuG0ZL3+c8qIUfGoJ2s
 zRq5gwOFc2ObOdE4j592B74c5HVoGaNP9UcMDaBPw/UTQyvNtpe1ss28hyYPDvKx1sFpq3t2w
 0oQ36EK38BV6Y45MWGhk5lLMW1GZLZGBr69omE9QCqwNTqJaxzxCvS6yONjsbqLDSLtaKMIs0
 5eYGuTiA6UQ5+/VJ2ZWMzFNms5UYqkb+ql/ivEGjUF4yNJl+2koeYcVYjqaQq1eHxHfyigMcu
 ChAO0HzCBajVZ8rudnTXBMUA0QfYmL0NAKwScnCo9wnOqvAufuA1cAUOqVYLjZgFPYNuyF3+7
 6bNjHj4MRg1UdDyqG3o9coHIk/XkURTtAZ4hjmaE+WFSDXTVywgXB5OWWQuOBshrcBFH7Td7v
 nXH8VWFms4BCjrvywqjoh+uL9mQ1iGpeEfTvI+xrnUGqmh8dkmzgjE53+ckPABFhLA3AK4B4+
 QBJ68ulaVsUVGGQLpx6yzmCMiK8nwWAhohajR9SAaN+EhCmNKyBqf2nteYP5qC+CEWU9J1CIC
 kTix8oELWnuV4AQ4gfprXPhesxT6o3oNgqV3ep8AbafDGPidjka7JNrjsO8XOJUbbQ9FefnxN
 cF+7i+gMKgq9kBq7RFabhoar+xe+Vn1uA/whunonG0fNLYWtFzrN3vDTx9if2vThV40WUmMM0
 uePl7S52pzoTvQeweEo5HgK66jJkmQcXkrqKLEqpwjVRef3Setis6bJILE+YZmzYMtBW9bVDU
 LoA9Xu9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap each part of the argument help string in angular brackets to show
that users need to replace them with actual values.  Do that explicitly
to balance the pairs nicely in the code and avoid confusing casual
readers.  Add the flag PARSE_OPT_LITERAL_ARGHELP to keep parseopt from
adding another pair.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/send-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 42fd8d1a35..0b517c9368 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -178,9 +178,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
 		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
 		{ OPTION_CALLBACK,
-		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
+		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
-		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
+		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+		  parseopt_push_cas_option },
 		OPT_END()
 	};
 
-- 
2.18.0
