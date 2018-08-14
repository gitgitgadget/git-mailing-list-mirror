Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F252D1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbeHNUb6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:31:58 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:37990 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUbx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:31:53 -0400
Received: by mail-qk0-f179.google.com with SMTP id 126-v6so13965508qke.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5INVZQXIcIzkBi0jiG0Tu3Pt9XrDPRpP40/HVVOtzzQ=;
        b=U/BNYnDVhIM6Dm9v8pzZnFy8rq7bMXECAGV99MPL7uC9EIT1GC5ZHgrk04DguffMKC
         GSdaUkdZaLMrUh59xHPIzbpXy6ojo+E7qwLyoduL+yoewyjR0UhMNjJB/rf2Mi5MsMXT
         pushvx5wNlEQsOXfFBg5c41vh1QlxcN4U6aoCMBbe61uG8Gq5m8sX/UdOmHCmiJ0YKhn
         8WxTAA3xuAPzuiCEK5hXKo3HxjvFV232MUgH0u9AEJ5thaV7tYl2G8l+PFQgnnOzB41C
         8by3qdbwTu65W43C3hFtBjRV1U99W4Ej90vtjLLFYTPhpGXiB3ps0XGXZvIBzqU9T/xq
         wMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5INVZQXIcIzkBi0jiG0Tu3Pt9XrDPRpP40/HVVOtzzQ=;
        b=XpjfG3khB3oLjtDdAUNd5qr599nOmj27x0mEdKHdRFWDP9KrKSD8O5jOwEzQSegMBj
         Plo/jssUXQ7jb7WFhAclRxR44JYw0D9wbgdJww3q0I0iE2TbZC7NMouIR+9vUZRwIHpn
         p9ewBJLmZbSnS5PbuZRsMbc9u0ukqbjbjeiikSFeo1AoE6hcUIVdZITzafMEZIBcDyIA
         gsGyaLkP0kFSrhWf8kfslLdhryn80bCXCHlDuaURm4yqWoor5Rw1p9IIyP5Q18hNrT0u
         LQ0sHRkV+fqRWV9oxRVTDg0nWFQWhdTEJ/DNC9orlVrusPz+lHEWlV4rriUHF70MCmJS
         6g2Q==
X-Gm-Message-State: AOUpUlGmpaHwl0A6ZZkBSxst/T3ZAdok8IH/duyNoPVG0FtUrLzQNXZ7
        1wGSxPQ/hdFJ8kkT5W7qlgw=
X-Google-Smtp-Source: AA+uWPwqNj7UndlVhHMLUcuonKxVlNajFpk4B2ib/NbpsXAq5SrUoq+WeYozJRdTlKBRJao8YBOdMA==
X-Received: by 2002:ae9:d8c1:: with SMTP id u184-v6mr20962718qkf.13.1534268621335;
        Tue, 14 Aug 2018 10:43:41 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:19d3:d700:87f2:5a2b? ([2001:4898:8010:0:309:d700:87f2:5a2b])
        by smtp.gmail.com with ESMTPSA id f64-v6sm15132021qkf.2.2018.08.14.10.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:43:40 -0700 (PDT)
Subject: Measuring Community Involvement (was Re: Contributor Summit planning)
To:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
 <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
 <20180813215431.GB16006@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
Date:   Tue, 14 Aug 2018 13:43:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180813215431.GB16006@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2018 5:54 PM, Jeff King wrote:
> So I try not to think too hard on metrics, and just use them to get a
> rough view on who is active.

I've been very interested in measuring community involvement, with the 
knowledge that any metric is flawed and we should not ever say "this 
metric is how we measure the quality of a contributor". It can be 
helpful, though, to track some metrics and their change over time.

Here are a few measurements we can make:

1. Number of (non-merge) commit author tag-lines.

     using git repo:

   > git shortlog --no-merges --since 2017 -sne junio/next | head -n 20
    284  Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    257  Jeff King <peff@peff.net>
    206  Stefan Beller <stefanbeller@gmail.com>
    192  brian m. carlson <sandals@crustytoothpaste.net>
    159  Brandon Williams <bmwill@google.com>
    149  Junio C Hamano <gitster@pobox.com>
    137  Elijah Newren <newren@gmail.com>
    116  René Scharfe <l.s.r@web.de>
    112  Johannes Schindelin <Johannes.Schindelin@gmx.de>
    105  Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     96  Jonathan Tan <jonathantanmy@google.com>
     93  SZEDER Gábor <szeder.dev@gmail.com>
     78  Derrick Stolee <dstolee@microsoft.com>
     76  Martin Ågren <martin.agren@gmail.com>
     66  Michael Haggerty <mhagger@alum.mit.edu>
     61  Eric Sunshine <sunshine@sunshineco.com>
     46  Christian Couder <chriscool@tuxfamily.org>
     36  Phillip Wood <phillip.wood@dunelm.org.uk>
     35  Jonathan Nieder <jrnieder@gmail.com>
     33  Thomas Gummerer <t.gummerer@gmail.com>

2. Number of other commit tag-lines (Reviewed-By, Helped-By, 
Reported-By, etc.).

     Using git repo:

     $ git log --since=2018-01-01 junio/next|grep by:|grep -v 
Signed-off-by:|sort|uniq -c|sort -nr|head -n 20

      66     Reviewed-by: Stefan Beller <sbeller@google.com>
      22     Reviewed-by: Jeff King <peff@peff.net>
      19     Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
      12     Helped-by: Eric Sunshine <sunshine@sunshineco.com>
      11     Helped-by: Junio C Hamano <gitster@pobox.com>
       9     Helped-by: Jeff King <peff@peff.net>
       8     Reviewed-by: Elijah Newren <newren@gmail.com>
       7     Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
       7     Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
       7     Acked-by: Brandon Williams <bmwill@google.com>
       6     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
       6     Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
       5     Mentored-by: Christian Couder <christian.couder@gmail.com>
       5     Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
       4     Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
       4     Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
       4     Helped-by: Stefan Beller <sbeller@google.com>
       4     Helped-by: René Scharfe <l.s.r@web.de>
       3     Reviewed-by: Martin Ågren <martin.agren@gmail.com>
       3     Reviewed-by: Lars Schneider <larsxschneider@gmail.com>

     (There does not appear to be enough density here to make a useful 
metric.)

3. Number of email messages sent.

     Using mailing list repo:

$ git shortlog --since 2017 -sne | head -n 20
   3749  Junio C Hamano <gitster@pobox.com>
   2213  Stefan Beller <sbeller@google.com>
   2112  Jeff King <peff@peff.net>
   1106  Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
   1028  Johannes Schindelin <Johannes.Schindelin@gmx.de>
    965  Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    956  Brandon Williams <bmwill@google.com>
    947  Eric Sunshine <sunshine@sunshineco.com>
    890  Elijah Newren <newren@gmail.com>
    753  brian m. carlson <sandals@crustytoothpaste.net>
    677  Duy Nguyen <pclouds@gmail.com>
    646  Jonathan Nieder <jrnieder@gmail.com>
    629  Derrick Stolee <stolee@gmail.com>
    545  Christian Couder <christian.couder@gmail.com>
    515  Jonathan Tan <jonathantanmy@google.com>
    425  Johannes Schindelin <johannes.schindelin@gmx.de>
    425  Martin Ågren <martin.agren@gmail.com>
    420  Jeff Hostetler <git@jeffhostetler.com>
    420  SZEDER Gábor <szeder.dev@gmail.com>
    363  Phillip Wood <phillip.wood@talktalk.net>

3. Number of threads started by user.

     (For this and the measurements below, I imported emails into a SQL 
table with columns [commit, author, date, message-id, in-reply-to, 
subject] and ran queries)

SELECT TOP 20
        COUNT(*) as NumSent
       ,[Author]
   FROM [git].[dbo].[mailing-list]
   WHERE [In-Reply-To] = ''
         AND CONVERT(DATETIME,[Date]) > CONVERT(DATETIME, '01-01-2018 
00:00')
GROUP BY [Author]
ORDER BY NumSent DESC

| NumSent | Author                     |
|---------|----------------------------|
| 76      | Junio C Hamano             |
| 64      | Stefan Beller              |
| 54      | Philip Oakley              |
| 50      | Nguyá»…n ThÃ¡i Ngá»c Duy   |
| 49      | Robert P. J. Day           |
| 47      | Christian Couder           |
| 36      | Ramsay Jones               |
| 34      | Elijah Newren              |
| 34      | SZEDER GÃ¡bor              |
| 33      | Johannes Schindelin        |
| 31      | Jeff King                  |
| 30      | Ã†var ArnfjÃ¶rÃ° Bjarmason |
| 24      | Jonathan Tan               |
| 22      | Alban Gruin                |
| 22      | brian m. carlson           |
| 18      | Randall S. Becker          |
| 15      | Paul-Sebastian Ungureanu   |
| 15      | Jeff Hostetler             |
| 15      | Brandon Williams           |
| 15      | Luke Diamand               |

4. Number of threads where the user participated

(This is measured by completing the transitive closure of In-Reply-To 
edges into a new 'BaseMessage' column.)

SELECT TOP 20
        COUNT(BaseMessage) as NumResponded
       ,Author
   FROM [git].[dbo].[mailing-list]
   WHERE [In-Reply-To] <> ''
         AND CONVERT(DATETIME,[Date]) > CONVERT(DATETIME, '01-01-2018 
00:00')
GROUP BY Author
ORDER BY NumResponded DESC

| NumResponded | Author                     |
|--------------|----------------------------|
| 2084         | Junio C Hamano             |
| 1596         | Stefan Beller              |
| 1211         | Jeff King                  |
| 1120         | Johannes Schindelin        |
| 1021         | Nguyá»…n ThÃ¡i Ngá»c Duy   |
| 799          | Eric Sunshine              |
| 797          | Ã†var ArnfjÃ¶rÃ° Bjarmason |
| 693          | Brandon Williams           |
| 654          | Duy Nguyen                 |
| 600          | Elijah Newren              |
| 593          | brian m. carlson           |
| 591          | Derrick Stolee             |
| 318          | SZEDER GÃ¡bor              |
| 299          | Jonathan Tan               |
| 286          | Christian Couder           |
| 263          | Jonathan Nieder            |
| 257          | Phillip Wood               |
| 256          | Derrick Stolee             |
| 238          | Taylor Blau                |
| 216          | Martin Ã…gren              |

(Note, some names have not been de-duplicated across multiple email 
addresses, but the email addresses are removed from these tables since 
I'm using a markdown generator that strips the emails in < >.)

If you have other ideas for fun measurements, then please let me know.

Thanks,

-Stolee


