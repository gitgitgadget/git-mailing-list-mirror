Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294F91F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeHBVKU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:10:20 -0400
Received: from mout.web.de ([212.227.15.14]:49471 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeHBVKU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:10:20 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOUUv-1fqWIX1XIz-005uRR; Thu, 02
 Aug 2018 21:17:44 +0200
Subject: [PATCH 2/6] difftool: remove angular brackets from argument help
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
Message-ID: <b6993beb-f9cc-225f-41e8-5a13b9e7ea58@web.de>
Date:   Thu, 2 Aug 2018 21:17:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iHBuaISJBSoqbRx3ODKybSNPXlcm3pUXN3tdWTW+z7Bw3oyzaQZ
 X+Li8F1t/ooitW5wgJHwwIDZP2GwfEfTX183iL52pOrf0AWeFF57XoyN5/njGPN1uhSXabG
 qIEBNHm3Srf7XAPw1jCR1MghRlpfz5f4p0UU7Za0uATvJlm1J6F6yiGdgRiYGZ7Dq0lLWAJ
 KH1sqyXmERaPi9r9NGwog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gEJUACw3REI=:swhfkTLqmBUuZlFN06zpWB
 3W4TGKWBEKnfNJTUo7Zh+ov9qIF3rHYLmpncd3Kux6BJ/Ts/zoY/QHYyPqyiZaE7RodtZHTta
 e9DdXoXkCKRSebjANh1K36ZlaczlLDL8Qg6gwIuVcci5F79WC50ZYmHLt3LaSWoxJmTSvo3sk
 AF9TeOWlFVPsVQ+Zy69D/t7+JqeOmKCdUZsFVHcqKIvJewHLQCmBmgjb83ReM0GsSL7HfqVKP
 9rxm37AOKV4KTDWJhVvxIxb2IZGKyGHxgcGGp8NzAIIuD60MhDhPL55o2KBWHcb6fb+IBndrc
 GJmuMJMbg7HedMjoOtS918D3r2M3gnKYOsvnkQykKMGNja07b2pXZyAYibTUbvRHJkhRxrkH0
 CSBkGraqC8Xk0YAQaSLQBJkUz8FUYzvPxvLWH/j+rRC0GeZvN+ow5hlp8mQ7sOFhV8VIbXth/
 dqOd5yuF+rpNozERvjEUGE6ks3S4Usj6uK+jBfrTE1EVzGhZzkIS/9Tadr+bInLwPuFHtCHmV
 s0N7W+wRfZ1s7V7tRDFolL/3x/tWBnAKNL96spEP7fH64kALiYCs7q0GqMVNweuDFUaBwZ9Hz
 wpRUGh6/5SIOPzrN58I2xwDqJdP/fISCBdWj3Sdkgpi0OXZqEK991jOSPurDdYOxoterfX9Fk
 Cly7syVkWpbL6WWPG17adg1L2o7aSDMq6zK+F09T1NE7zlchGXeWnB7sAG9xDOROIFMDXWYm4
 ZlIynpMzixuLb0X1m49axavSVWb8PONOrhkjrISGh9Gr7RPh+z32/uRcg01lPk1D8/FA2hfP4
 8/WKUoU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Parseopt wraps arguments in a pair of angular brackets by default,
signifying that the user needs to replace it with a value of the
documented type.  Remove the pairs from the option definitions to
duplication and confusion.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/difftool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 51f6c9cdb4..172af0448b 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -703,7 +703,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "symlinks", &symlinks,
 			 N_("use symlinks in dir-diff mode")),
-		OPT_STRING('t', "tool", &difftool_cmd, N_("<tool>"),
+		OPT_STRING('t', "tool", &difftool_cmd, N_("tool"),
 			   N_("use the specified diff tool")),
 		OPT_BOOL(0, "tool-help", &tool_help,
 			 N_("print a list of diff tools that may be used with "
@@ -711,7 +711,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
 			 N_("make 'git-difftool' exit when an invoked diff "
 			    "tool returns a non - zero exit code")),
-		OPT_STRING('x', "extcmd", &extcmd, N_("<command>"),
+		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
 			   N_("specify a custom command for viewing diffs")),
 		OPT_END()
 	};
-- 
2.18.0
