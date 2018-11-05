Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EFA1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 16:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeKFCIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 21:08:52 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36544 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbeKFCIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 21:08:52 -0500
Received: by mail-yb1-f196.google.com with SMTP id g192-v6so3997967ybf.3
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 08:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rK2PAzn5nUNVQzu609VQKm5k+2xdtoN42GRJVUz78WA=;
        b=G9j5Q4jWQQn5VtfVtIZB27qHEjW8sVFm678Xtr5a3e7HmQnVunZTrg3QipFa3FX5c4
         7uEUhI0jzIq3pWh/PqE2IRE4T5R7DcyRJVtM8RXC8ye83sd5ijsUmzg26LEpeNUH1IBB
         DKFy+MyCqKM/CJEdNxvyKCbX+W5DaOxlyqsDKIDet/egTVVCWGqNc4aVSBlUkvWsIbJQ
         Sn1udxPzKf8qga2ubCQFwS/iey6bh903ehpmKS3g/5hIwEYLaFuCf2TcVSpelEQkkMhs
         BhXeTEgcCRpe8bWtL8MM87kxpFn/WZCrPVQ07sH1iw5i6zu90Lwpzcaac8SwiP2IoO3T
         XsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rK2PAzn5nUNVQzu609VQKm5k+2xdtoN42GRJVUz78WA=;
        b=d4Ny4aMrB8Nc/0NxaFmmFpEmoK/EKJl2y1ssNcCHApEKrOVm08JEBVEMOqxUG6sfyc
         2prJ181Rk76rf4rbCw03u+XGMy9y51RrXoXZn6z12CtHQ9GMlVSehzcGfEcC7Izvwno7
         Ub6XqlJLNRDLxTbsGVYwSelqYOJ07gS7ukng8raysJ34VpInAgWZFMElY6YpqNT9qllE
         FW58z7pYLmE46kt7F7MIY5Gk4TOEKr7JyEGNthioXcD+pgb8km/DaBR7adQ6cMv73s/g
         YLGQjkMLfyTkC875oiKglQh0tR5AcQGpuh/jch0PAB0wVYgjq+4kiY4Mc7XBct21ry/n
         GnZg==
X-Gm-Message-State: AGRZ1gI2pgzJgdbBS9NRN1L1We+UyhU1tfiILbCj9KwfJ+pfFgiIXml4
        hLfMZ/b1/5JIMMcIIZ+YYTgFLqDm
X-Google-Smtp-Source: AJdET5cYN52DZK8q5dahRBH3dGQQNWxDj+7VpgVu3emSHnO19ENKdF550rAOR7gHZD0wkCL3fDbSNg==
X-Received: by 2002:a25:4095:: with SMTP id n143-v6mr22096138yba.40.1541436499336;
        Mon, 05 Nov 2018 08:48:19 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z136-v6sm2617161ywz.2.2018.11.05.08.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:48:18 -0800 (PST)
Subject: Re: [PATCH] multi-pack-index: make code -Wunused-parameter clean
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
References: <20181104004957.52913-1-carenas@gmail.com>
 <20181104022746.GA30936@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0ace7b35-e967-6230-8733-e9cacebc75c1@gmail.com>
Date:   Mon, 5 Nov 2018 11:48:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181104022746.GA30936@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2018 10:27 PM, Jeff King wrote:
> On Sat, Nov 03, 2018 at 05:49:57PM -0700, Carlo Marcelo Arenas Belón wrote:
>
>> introduced in 662148c435 ("midx: write object offsets", 2018-07-12)
>> but included on all previous versions as well.
>>
>> midx.c:713:54: warning: unused parameter 'nr_objects' [-Wunused-parameter]
>>
>> likely an oversight as the information needed to iterate over is
>> embedded in nr_large_offset
> I've been preparing a series to make the whole code base compile with
> -Wunused-parameter, and I handled this case a bit differently.
>
> -- >8 --
> Subject: [PATCH] midx: double-check large object write loop
>
> The write_midx_large_offsets() function takes an array of object
> entries, the number of entries in the array (nr_objects), and the number
> of entries with large offsets (nr_large_offset). But we never actually
> use nr_objects; instead we keep walking down the array and counting down
> nr_large_offset until we've seen all of the large entries.
>
> This is correct, but we can be a bit more defensive. If there were ever
> a mismatch between nr_large_offset and the actual set of large-offset
> objects, we'd walk off the end of the array.
>
> Since we know the size of the array, we can use nr_objects to make sure
> we don't walk too far.
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks, both, for catching this. I prefer the approach that adds defenses.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

> ---
>   midx.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 4fac0cd08a..ecd583666a 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -712,12 +712,18 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
>   static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_offset,
>   				       struct pack_midx_entry *objects, uint32_t nr_objects)
>   {
> -	struct pack_midx_entry *list = objects;
> +	struct pack_midx_entry *list = objects, *end = objects + nr_objects;
>   	size_t written = 0;
>   
>   	while (nr_large_offset) {
> -		struct pack_midx_entry *obj = list++;
> -		uint64_t offset = obj->offset;
> +		struct pack_midx_entry *obj;
> +		uint64_t offset;
> +
> +		if (list >= end)
> +			BUG("too many large-offset objects");
> +
> +		obj = list++;
> +		offset = obj->offset;
>   
>   		if (!(offset >> 31))
>   			continue;
