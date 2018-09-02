Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A591F404
	for <e@80x24.org>; Sun,  2 Sep 2018 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeIBXKo (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 19:10:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43238 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeIBXKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 19:10:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6-v6so7607788plv.10
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=H1noEEtwXWBvbOBnj5Y6w3fKoW4cl0i3kxwDUZKFdIA=;
        b=MPKDfLnmTKj+fpL4VWl19lbpA28aHcK4+ik+8nYgGZ4UWiuXqJFdhR8lRvJ8kjVI+p
         4vbUgQd7pqFXrEXtu0kQIWdRKT+gjBmadRKN0pxXjH/fjji1TyLpKG9ZhxKMi9wMAgJy
         V3pa+wLJpUT+ZTXNIz6Q8+XfwQT/Vx0kOdEH1j0xv9XuKYYd3Oe1CWVgD5TH73a/FU06
         n0BEg+SaoSlcwuzNEkwdjTSqT2E3+xQq7I/csCDEc3SLWQ4B1L/Ud6socIL6MnkrjhUC
         QsQoZV/TTKaZxLgi8WJLe8DoG7lyihztWASF31oiSf3OVDFHp44/6YuNVZTAKel72xgl
         +j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=H1noEEtwXWBvbOBnj5Y6w3fKoW4cl0i3kxwDUZKFdIA=;
        b=Tjlw4MyeiQJmTjiteHCzytm6Uw9txxWSeZvKjibZClBMSHiC8BDsaSCvkdYPgd4PUd
         7/Hjp41Jm8nzsqGdI0oN6E8DDl/j8EKqz1lt6HczY9EMqnTBXnvPaNghVxvUTxVzFPNY
         rhlw/eJ8XRpW8c/b1W1pvA9U7cB3nDVaDjaeNfZCUIXKn6SJXRT7D1uDdy/cHrkf/E4q
         1Krj3+PIoMrNOfttzXN0td3SKBYy4CmsPz8BCoqn6H0rZ2wu2BsfgbxmfOTJt+iETwYS
         6/kHB9ww2w11eLfJ841wSfhORh7w0SjYFtGyfTNxF3ZSSOC+Ca7oSnQ/Zs2DOAqfqSmH
         0MeA==
X-Gm-Message-State: APzg51DowauVLot6+AUZf8/1+Mj/5XpL0eiFf6C3EpRybzELm8AwgFz+
        8cxJeooF6gDP/1VgChJXi/Q=
X-Google-Smtp-Source: ANB0VdY8joDfgQtWjQmfG5Lwj9VeIDZGqaIacoZlZmIRoS1RbY4Xl5V/L77NOrhFroeacwrP7TtaOQ==
X-Received: by 2002:a17:902:5acc:: with SMTP id g12-v6mr25146243plm.90.1535914440746;
        Sun, 02 Sep 2018 11:54:00 -0700 (PDT)
Received: from unique-pc ([223.228.138.253])
        by smtp.googlemail.com with ESMTPSA id r23-v6sm34080921pfj.5.2018.09.02.11.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Sep 2018 11:53:59 -0700 (PDT)
Message-ID: <39ec35843c3164a9da75466b768636cb7871690d.camel@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
In-Reply-To: <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
         <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
         <20180821212923.GB24431@sigill.intra.peff.net>
         <20180822004815.GA535143@genre.crustytoothpaste.net>
         <20180822030344.GA14684@sigill.intra.peff.net>
         <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
         <20180822152306.GC32630@sigill.intra.peff.net>
         <20180823012343.GB92374@aiede.svl.corp.google.com>
         <20180823021618.GA12052@sigill.intra.peff.net>
         <20180823034707.GD535143@genre.crustytoothpaste.net>
         <20180823050418.GB318@sigill.intra.peff.net>
         <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 03 Sep 2018 00:23:41 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2018-08-23 at 06:26 -0400, Derrick Stolee wrote:
> 
> Around the time that my proposed approaches were getting vetoed for 
> alignment issues, I figured I was out of my depth here. I reached out to 
> Daniel Lemire (of EWAH bitmap fame) on Twitter [1]. His blog is full of 
> posts of word-based approaches to different problems, so I thought he 
> might know something off the top of his head that would be applicable. 
> His conclusion (after looking only a short time) was to take a 'hasheq' 
> approach [2] like Peff suggested [3]. Since that requires auditing all 
> callers of hashcmp to see if hasheq is appropriate, it is not a good 
> solution for 2.19 but (in my opinion) should be evaluated as part of the 
> 2.20 cycle.
> 

That was an interesting blog post, indeed. It had an interesting
comments section. One comment especially caught my eyes was [a]:

"So the way gcc (and maybe clang) handles this is specifically by
recognizing memcmp and checking whether a only a 2-way result is needed
and then essentially replacing it with a memcmp_eq call.

..."

I find this to be an interesting note. It seems GCC does optimize when
we clearly indicate that we use the result of the memcmp as a boolean.
So would that help in anyway? Maybe it would help in writing a `hasheq`
method easily? I'm not sure.

> [1] https://twitter.com/stolee/status/1032312965754748930
> 
> [2] 
> https://lemire.me/blog/2018/08/22/avoid-lexicographical-comparisons-when-testing-for-string-equality/
> 
> [3] 
> https://public-inbox.org/git/20180822030344.GA14684@sigill.intra.peff.net/
> 
> [4] 
> https://public-inbox.org/git/7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com/


[a]: 
https://lemire.me/blog/2018/08/22/avoid-lexicographical-comparisons-when-testing-for-string-equality/#comment-344073

--
Sivaraam

