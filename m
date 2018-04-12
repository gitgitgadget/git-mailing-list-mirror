Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03E61F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeDLL2U (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:28:20 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:40295 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeDLL2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:28:20 -0400
Received: by mail-pf0-f169.google.com with SMTP id y66so3428708pfi.7
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AnbnLs+BEbqGbDnInxCZ3A68Z9VerVG3E/T8n92D80Y=;
        b=g2X5RS8V0Sf5ClXvinYMrA+UCUYCBEpawrVlL+e5zhSlEfSIiqtwAx5nUDDIet+d1X
         zlWtHZ8SK6e5jrQg2JkIHH7RqQs2mvUo2hG/Uj4S27N5hGYPDzY08oiW4c5NpPJ49M1Q
         cpYgrpF/ZuCCarHxscNLzKWJ7+uSlsIoNIO+elf+nO1KwqSTdIdYOrlavDcn2QqXQ6Us
         HuQ/1vj0VJmf7xFxaA1xU8kvxCenRxQvWDmxxGB7kuwvzG7qBkWUso6kboP0KhlRBTE3
         kErv9nxYPXFdADrUJQsc5Eml3icQDjPBfj6yN7W+w2LkujUPvmMmwWFKzLUtNZcXnDjC
         TBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AnbnLs+BEbqGbDnInxCZ3A68Z9VerVG3E/T8n92D80Y=;
        b=M70l/Zhi22BXCqRhgm9503lW3GQv8kcLUItO7w0HBkWABs+537eWgWQTB2fS44xlR7
         UDy9pmg4kgSON5sFFEOTl0fhbnhq0ObBxYO9jYrPl6x1TiXF/J+VEwHpvnatQA2Ve8Ax
         u3ptIZ2/zCbp6OLjGElEb9GtUwd/5sIuYXKVd1VU8a5LyHwPQjRss706s8x2SS2U60Or
         I3UH0Ipq/89/mB6qwfAKM+MzEqUHnl7pRD4lgAAGN1mNPBtMSGoGqLgTY98sKAO4nKR/
         th4MGoodxeuLP8XgNTVlBCjX0X7qf5bv8q6BSufsjgm25dkiuY4hLAUNIvgSqIKp9OBc
         nywg==
X-Gm-Message-State: ALQs6tAMXeijfrBPhzpYZG4hyM94y90D0ZrqdWT22ym2AxTyzsFFhGrr
        /BlFuEEhQcXxQUKE4D4RKUQ=
X-Google-Smtp-Source: AIpwx4+I+0EHZ9NRU6l9KnGiCse19ThCBEXTjIUsocr0tLRefynT8q0uxLcnNzbDd/W1X4YshZXL1A==
X-Received: by 10.99.100.68 with SMTP id y65mr398027pgb.257.1523532499490;
        Thu, 12 Apr 2018 04:28:19 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u6sm5769177pgo.1.2018.04.12.04.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Apr 2018 04:28:18 -0700 (PDT)
Subject: Re: [PATCH v8 03/14] commit-graph: add format document
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
 <20180410125608.39443-4-dstolee@microsoft.com> <86zi294fzq.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c2f639ba-4832-191e-03ae-fa893796e2a6@gmail.com>
Date:   Thu, 12 Apr 2018 07:28:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86zi294fzq.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2018 4:58 PM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> +CHUNK DATA:
>> +
>> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>> +      The ith entry, F[i], stores the number of OIDs with first
>> +      byte at most i. Thus F[255] stores the total
>> +      number of commits (N).
>> +
>> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
>> +      The OIDs for all commits in the graph, sorted in ascending order.
>> +
>> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
> I think it is a typo, and it should be CDAT, not CGET
> (CDAT seem to me to stand for Commit DATa):
>
>    +  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
>
> This is what you use in actual implementation, in PATCH v8 06/14
>
> DS> +#define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
> DS> +#define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> DS> +#define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
> DS> +#define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
> DS> +#define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */
>

Documentation bugs are hard to diagnose. Thanks for finding this. I 
double checked that the hex int "0x43444154" matches "CDAT".

Here is a diff to make it match.

diff --git a/Documentation/technical/commit-graph-format.txt 
b/Documentation/technical/commit-graph-format.txt
index ad6af8105c..af03501834 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -70,7 +70,7 @@ CHUNK DATA:
    OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
        The OIDs for all commits in the graph, sorted in ascending order.

-  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
+  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
      * The first H bytes are for the OID of the root tree.
      * The next 8 bytes are for the positions of the first two parents
        of the ith commit. Stores value 0xffffffff if no parent in that

