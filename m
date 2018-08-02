Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582B51F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeHBVKl (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:10:41 -0400
Received: from mout.web.de ([212.227.15.4]:42993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeHBVKk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:10:40 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQO44-1fOAZn28YW-00TnDm; Thu, 02
 Aug 2018 21:18:07 +0200
Subject: [PATCH 5/6] shortlog: correct option help for -w
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
Message-ID: <4e96d2a2-dfdc-3f6f-e2c7-2eb954ed633c@web.de>
Date:   Thu, 2 Aug 2018 21:18:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tlJfqLGkGkDzUkpTHbRopJupus9uPz7frlASLfenaHUI3pvyYAo
 SFY18yoacIFpmS5mQIa94sACjtvVcHlvml4Fsn8rY4qvqxGD1FgiqrqacQM0BqfUI03ejtw
 imRLVOs8tZSGgCGQK4/65Z+BrvMOhxo0GlrBv9kKan+wwmGoHEPx49PlC3O3Wnh2oY+EE/T
 6uMJMpHEfPlmBMYJWklKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yqwafz+b2hY=:iKsMWzT3pNoTNlW1+hroi5
 1PLbp5QtFJETfZ9M3pxuI9/S/NPf5uTpk0q1kcPH7mU/8doC0/WGK5X65bA+zaiDukQqiE3CI
 yRDJKI0GGZiCKmTDfJs9IGygzPl8yWnqc1Ufd5bf1J/k4KZ1Yy/JmhkSGoTuE/46PEwuX4gYS
 +LBt5JbX5KrgFOIdG1FrgHTi0P2UufwCoCrSus6kA9HckqFHUCkV1P3/0jo0M/M+8WUuHNH5m
 pc/oimPNYYy+tkhjqLH+VWyBViW5QcBeyBAn6zn3eeevCrSaHvPfxUC5fjLX4L2TfZ7SSw8L8
 2fqteUmOeSUHF3khKhJcDLzNFNSVNKd2ARVHYKhiDzBW8DXKBoGzi1Y6M70dPl/IATWg+ONK7
 khDNR38avx19b3u+ix3bOi1ZAnW08m5FbkeEHrKFpf33P4aMoEy4tIiUVSnmEI3gJZUfPumQp
 oB3FtKkijnEKKIs9EB9m9Jc6hg3Sn5LCrvEQweHC/3Gfy2iKL5RFdOGiFwOsWVgX5Qp047jnJ
 MHwMXYMrplC46zmMhzW1566j5VRmBN4F9xBOfJnL4vH3Y30FmPE9zFsYb02ndPoDcLVe7+Op3
 smP4p63KVYtEK8NUiWnLkC4NWjJlJvWkJtM0W7JaRY8Q28HuU7P/4TrFi3KQBe3dpQf8Ugy+W
 jFfYKGiC/xJC+1tqaTdQme5Nikq8P4kpy9jG8xa9iWSxLDxzyXpdjata13eW+xs4kHORzIUeG
 gNQJJwujL0cmAS8KRxznkmdmsfvG3mddHpKF6+e7mjcfPNWmWBuF0w1/3sB0aKxklhsudm9lK
 8GB5SR6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap the placeholders in the option help string for -w in pairs of
angular brackets to document that users need to replace them with actual
numbers.  Use the flag PARSE_OPT_LITERAL_ARGHELP to prevent parseopt
from adding another pair.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/shortlog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 608d6ba77b..f555cf9e4f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -268,8 +268,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			 N_("Suppress commit descriptions, only provides commit count")),
 		OPT_BOOL('e', "email", &log.email,
 			 N_("Show the email address of each author")),
-		{ OPTION_CALLBACK, 'w', NULL, &log, N_("w[,i1[,i2]]"),
-			N_("Linewrap output"), PARSE_OPT_OPTARG, &parse_wrap_args },
+		{ OPTION_CALLBACK, 'w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
+			N_("Linewrap output"),
+			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			&parse_wrap_args },
 		OPT_END(),
 	};
 
-- 
2.18.0
