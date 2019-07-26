Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9FD1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 13:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfGZNSy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 09:18:54 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:43310 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGZNSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 09:18:54 -0400
Received: by mail-qk1-f182.google.com with SMTP id m14so13303352qka.10
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=p77H00SzyDYr8Rjd7FXxrnhksIsLk50t7STLZY6O+ro=;
        b=TAdcz+ldXTwOszduiLJ4U6eo+NnpGtpVk82SYAR787pArWWp+q6jpc+JU8hDcHPZJh
         pUUP+Mr476VOPtDLeIDeyBPtvnJyw0ZngKunCQ14k30khHo5CQADgjT7bG1fKRiPxVuB
         C1ZkEQuxRyllYOzHhlnvwkRoxKK0YjQ9fdKGfCoQbaZt7FbOaU+r8F5RNcA5unVcLnVO
         vlvFUy2F8KnR4frpJ7iXZyFbJHuSDfWiWq7CxqbEvTalp0UWNFgVW8V2iTEFIsVEXKZH
         R3l59XpRhh0bJsHiogMGj0lix841TPU/2nElsfS45JIuFR6uhC5InbVIziFipztbHuD0
         DKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p77H00SzyDYr8Rjd7FXxrnhksIsLk50t7STLZY6O+ro=;
        b=TgqBt2QvHDEsfXExzjV3hraTsFnS7g2sqWnyq2uQeb55siUSvKXB1mbUNlB8bYLYQ0
         cKfpXMSpynSArT40MuCuPUMg/umDqeMDj78oLuRD0zLIOkjFRCyFbClNWG94l4IB2H2N
         wogAkLqwCWuocj7nu/HJnZHPN3jOYfRmZCaJ+0c1OFTl9ntHZcAv1JPxC3/gOpjLdAbZ
         LKcn34zl9dUy83S3ePQEnFpNa0TBOSv01ecoBswqPis0rCUgtOnDCuoHfNXXRNqEFSMx
         sjG9/8zs+WZjT3Jwk+wpMqevRkqDwdBQFzqgoSiaYU2CekWUynsi3QrhnKywjKLKt1Sh
         wQEA==
X-Gm-Message-State: APjAAAWMOu6b2Tre0ax6iJ1Y4pCz5Mf+u0IClTaqGajFog6BVTMK/8YY
        kXC3IZX8rsygFAnQQlJ8/CyvSq8T
X-Google-Smtp-Source: APXvYqwytFcg5NW9bPQsQme+VeAsX/dCbnGi9597eirW18bMRWODelOVz66rg34Q+q9Z6ayfD7Wddw==
X-Received: by 2002:a37:9c0c:: with SMTP id f12mr62198165qke.442.1564147133031;
        Fri, 26 Jul 2019 06:18:53 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:28d7:5e63:3fd6:bd80? ([2001:4898:a800:1010:da0c:5e63:3fd6:bd80])
        by smtp.gmail.com with ESMTPSA id z50sm27927957qtz.36.2019.07.26.06.18.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 06:18:52 -0700 (PDT)
Subject: Re: Alternates advertisement on GitHub
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20190726031840.GB23056@TaylorsMBP9145.attlocal.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <19a0d5a9-864e-584d-d869-f15b5959beba@gmail.com>
Date:   Fri, 26 Jul 2019 09:18:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190726031840.GB23056@TaylorsMBP9145.attlocal.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/2019 11:18 PM, Taylor Blau wrote:
> Hi everybody,
> 
> Pushes to forks of git.git hosted on GitHub now advertise the tips of
> git.git as well as branches from your fork.
> 
> You may recall that Peff and I have sent a handful of patches to allow
> repositories to customize how they gather references to advertise from
> an alternate, and then to use those alternate tips as part of the
> connectivity check (in [1] and [2], respectively).

I'm glad to hear you deployed this so quickly after review!

> GitHub used to advertise '.have's on pushes to forked repositories, but
> hasn't done so since 2012. We aggregate data from all forks into a
> 'network.git', and expose the tips of each fork as:
> 
>   refs/remotes/<fork-id>/<refname>
> 
> Each fork lists the 'network.git' as its alternate, and thus the
> advertisement can get prohibitively large when there are many forks of a
> repository.
> 
> Michael Haggerty's work on packed refs makes finding references
> pertaining only to the root computationally efficient, and [1] makes it
> possible to filter down when computing the set of references to
> advertise. With [1], we can specify that computation exactly and only
> advertise branch tips from the root of a fork network.
> 
> We've been slowly rolling this out to a handful of repository networks,
> including forks of git.git hosted on GitHub. If you host your fork on
> GitHub, you shouldn't notice anything. Hopefully, pushes to your fork
> will result in smaller packfiles. In either case, nothing should break;
> if it does, please feel free to email me, or support@github.com.

I tested this by updating 'master' in derrickstolee/git to match gitster/git
and the pack was empty (ref update only). This makes fork management so much
simpler!

Thanks!
-Stolee
