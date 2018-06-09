Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469B31F403
	for <e@80x24.org>; Sat,  9 Jun 2018 11:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeFIL1D (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 07:27:03 -0400
Received: from mout.web.de ([212.227.15.14]:52125 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752923AbeFIL1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 07:27:02 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDPYb-1fUa0m2gVZ-00Gt9R; Sat, 09
 Jun 2018 13:26:53 +0200
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
 <20180417213049.118995-1-sbeller@google.com>
 <20180417213049.118995-2-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <737e4f2e-9896-0119-2c43-655ac29fe018@web.de>
Date:   Sat, 9 Jun 2018 13:26:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180417213049.118995-2-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+dR18Jo4iiGQQTaH58uYn1lpft7eC6rQVaO3V92d8x7Rj3Cu8lr
 Ude28NJH5s4lk+dVVmywcurXilyhmTUa6YbipL+3GRmTXUnY0ZKBCjGcLXcfjKadQwc0j0N
 tU5aNpy0LCb3ZdedFa33BDIRueGwUaZRWwhscCT105mtBkRXs6YfcL2wBbZygdYiB0Iw63o
 RO9+mq2XRQnac2c37rzGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ce6OS3frKiM=:3lFfjMuB0u1F3Cgr3htjju
 WIJMH6njVamQNJFPEw13g3/9NqDKHIVIyZVSIbxCJJ8jFxcEcV7Qf75GpxGs7jMAYguGcsJZe
 PmPWF7fzOd94imSgdw+P9PKAnhaf4ECRbG5JLt95erUdioCYjYXV7phiZQzyILcEKVXWpvbHH
 V1Fb1mFW4gGtdtWGFJ5b8BUCRiOdJzXRRKLmP0V3i5vbvfY+6npNJc94uWyNZTF3FEA9j+zX5
 TtBm6Zcln9hiTNAGy78DL/VkJOU6OJNZWi8T2UnwPkGdH9JS+oISnysGiI8vZzVefSHYHdCRt
 ShyrIWAdSQOMkGyrThT8d+UrlXOaQOApKlZcJb0iCNCgUnf2lWB/wt9w/QkzxqPoEznDsVwav
 sorMLCtlU26O9bDdZcKTYh8H8jxld3YVicWUBOuSWSgGed2CWz5kv5HIXaSYYRT+EhGXOKNJ7
 uhIViImVEFQNGcYb0ePvtPb8pJO6oMPg2H/KUo0DnbRcBxfjSJevdhet09+nwAtcpfb5DX6AL
 C2PM84e4LHSTYMRAM+yKR3HCB2zSTNsZuqQ/AWIry6Ykhc2BCHYcVInAthYIyZ9zC+THjlmtC
 0ThIuL4Fn+YtkBFdxcFagEVFZexiRT2tLHzM9N8rrQjv7nLzzCrUtoPFKTvfsJEt07dlZOLuR
 2FMR1xAv6OMf2ph9Twl353cYUtWwKwDXg8DZOE8poVvyUyps4UZ4wnL3sMtswOSIiQ/txJadl
 bA49+7/sA7RFwNvpXyP7SNGavqcdHDYLTWlw6wTDu+X2hrvUbgll+o6/4p5ujcmnay+aZMLDx
 RseiBkL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.04.2018 um 23:30 schrieb Stefan Beller:
> +static void parse_color_fields(const char *s)
> +{
> +	struct string_list l = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +	enum { EXPECT_DATE, EXPECT_COLOR } next = EXPECT_COLOR;
> +
> +	colorfield_nr = 0;
> +
> +	/* Ideally this would be stripped and split at the same time? */

Why?  Both approxidate() and color_parse() handle spaces.

> +	string_list_split(&l, s, ',', -1);
> +	ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
> +
> +	for_each_string_list_item(item, &l) {
> +		switch (next) {
> +		case EXPECT_DATE:
> +			colorfield[colorfield_nr].hop = approxidate(item->string);
> +			next = EXPECT_COLOR;
> +			colorfield_nr++;
> +			ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
> +			break;
> +		case EXPECT_COLOR:
> +			if (color_parse(item->string, colorfield[colorfield_nr].col))
> +				die(_("expecting a color: %s"), item->string);
> +			next = EXPECT_DATE;
> +			break;
> +		}
> +	}
> +
> +	if (next == EXPECT_COLOR)
> +		die (_("must end with a color"));
> +
> +	colorfield[colorfield_nr].hop = TIME_MAX;
> +}

This adds a minor memory leak; fix below.

-- >8 --
Subject: [PATCH] blame: release string_list after use in parse_color_fields()

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/blame.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4202584f97..3295718841 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -411,6 +411,7 @@ static void parse_color_fields(const char *s)
 		die (_("must end with a color"));
 
 	colorfield[colorfield_nr].hop = TIME_MAX;
+	string_list_clear(&l, 0);
 }
 
 static void setup_default_color_by_age(void)
-- 
2.17.1
