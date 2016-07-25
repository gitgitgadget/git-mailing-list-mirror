Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E470F203E3
	for <e@80x24.org>; Mon, 25 Jul 2016 20:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbcGYUcp (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:32:45 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34923 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbcGYUco convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 16:32:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id f65so149331701wmi.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 13:32:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1rciMn+8lTUqJ5sMrcdGIn1y7YPVn/oyvx4+SJI50XY=;
        b=NnWoy3pbQJXAr2MEmsguZh9ZRDs0bLUrZHxQUfLT7uLTDCcGAkehv4OAecoRieuIZB
         pqp8N+yLMivielF7wEgBzGP5I6gnK2gSmR/zcGppAL2wru3OQkOeFYcP8X4mgz5KPTV/
         pKIyl6MYD+BrYD49IAu/h18Siyw5OF0BdD7Du/B3y/LbzAyGBe/TLjyZtHBNK4/qeMbW
         RqVF351xvgPtEmX1NatNyxq5aanJOfBFRb7nW1R6OYtOs41x543T+ZzePuwd+bmriD1h
         kkOzLsfRUaeVgaetNDFscXuuWzzNlakYhPHVVoPHx4rJ+3IyspWHrt21bHrVohfdZiLe
         zpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1rciMn+8lTUqJ5sMrcdGIn1y7YPVn/oyvx4+SJI50XY=;
        b=GMmANF31bLjA2H1eQB/aXyzDK/o3/ueR7FpIZPTp1Kc5J8U4EmrmJbFz0pDhb5oZRP
         BCP2Z4klzy8CNGR8Zf1ZRPZvniiI2svDoGnaZpYEhw9JBvGeldthZimbdsU6/caTB1bu
         wwl7dR9XScpahSAMJreJLWCloiMpp17y4IUzesHiMdRBjUF2Yi+hD9Kz9ykeH85Qf5L1
         uDpNr9TRB8vt1mwp/S9ny5FW70ZNvA+jZIxj7wR5omWJ+vCy0pHpiUT2TSFnd4J8w6s8
         LMSUZil3eFiEYRMmCd+wPnxcxuLNymf+9/UHXCbYGvDHAV7h93OVDGmsa50ddZErgaGc
         UKaQ==
X-Gm-Message-State: ALyK8tKdoAY3fup2vWCZXAjcU9Urf0fcCHDccpSttgPA26O7eDXr7N13XRJHrv2jL2F4mw==
X-Received: by 10.28.129.137 with SMTP id c131mr39512356wmd.79.1469478762637;
        Mon, 25 Jul 2016 13:32:42 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB7A6F.dip0.t-ipconnect.de. [93.219.122.111])
        by smtp.gmail.com with ESMTPSA id b203sm29115219wmh.20.2016.07.25.13.32.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 13:32:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <57954DA3.9090006@gmail.com>
Date:	Mon, 25 Jul 2016 22:32:39 +0200
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <7D0AD199-F077-4EB2-83A5-58EB603973CA@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com> <1A0C148F-C7C3-4FAF-BAEE-58B11A2324FF@gmail.com> <194ea810-76ff-f32c-0f8a-57e8e60b65f5@ramsayjones.plus.com> <57954DA3.9090006@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 25 Jul 2016, at 01:22, Jakub Narębski <jnareb@gmail.com> wrote:

> W dniu 2016-07-25 o 00:36, Ramsay Jones pisze:
>> On 24/07/16 18:16, Lars Schneider wrote:
>>> On 23 Jul 2016, at 01:19, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>>>> On 22/07/16 16:49, larsxschneider@gmail.com wrote:
> [...]
>>>>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>>>>> keeps the external filter process running and processes all blobs with
>>>>> the following protocol over stdin/stdout.
>>>>> 
>>>>> 1. Git starts the filter on first usage and expects a welcome message
>>>>> with protocol version number:
>>>>> 	Git <-- Filter: "git-filter-protocol\n"
>>>>> 	Git <-- Filter: "version 1"
>>>> 
>>>> Hmm, I was a bit surprised to see a 'filter' talk first (but so long as the
>>>> interaction is fully defined, I guess it doesn't matter).
>>> 
>>> It was a conscious decision to have the `filter` talk first. My reasoning was:
>>> 
>>> (1) I want a reliable way to distinguish the existing filter protocol ("single-shot 
>>> invocation") from the new one ("long running"). I don't think there would be a
>>> situation where the existing protocol would talk first. Therefore the users would
>>> not accidentally mix them with a possibly half working, undetermined, outcome.
>> 
>> If an 'single-shot' filter were incorrectly configured, instead of a new one, then
>> the interaction could last a little while - since it would result in deadlock! ;-)
>> 
>> [If Git talks first instead, configuring a 'single-shot' filter _may_ still result
>> in a deadlock - depending on pipe size, etc.]
> 
> Would it be possible to do an equivalent of sending empty file to the filter?
> If it is misconfigured old-style script, it would exit after possibly empty
> output; if not, we would start new-style interaction.

I think we would need to close the pipe to communicate "end" to the filter, no?
I would prefer to define the protocol explicitly as this is clearly easier.


> 
> This should be, if we agree that detecting misconfigured filters is a good
> thing, tested.
> 
>>> 
>>> (2) In the future we could extend the pipe protocol (see $gmane/297994, it's very
>>> interesting). A filter could check Git's version and then pick the most appropriate
>>> filter protocol on startup.

Thanks,
Lars