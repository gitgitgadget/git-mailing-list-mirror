Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86EE5209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 20:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbcJJUxM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:53:12 -0400
Received: from mout.web.de ([212.227.15.14]:55518 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbcJJUxL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:53:11 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MIN5j-1brlDx1Uq7-0048Q5; Mon, 10 Oct 2016 22:52:58
 +0200
Subject: Re: %C(auto) not working as expected
To:     Jeff King <peff@peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
Cc:     Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6689ae49-6095-7bb4-ea06-1aaded174811@web.de>
Date:   Mon, 10 Oct 2016 22:52:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:udeRIHbVL5BXPa7rP3GdDSw/K6Scn7L7UXhJ/N9ZUh1d2FpFZA2
 S6s7hkeKSjgY4MlB/O6cBG84uo3Z0E4+OsnZNVY6n/yECkay2imQkTjTZeWPZMaIxT8ht7q
 jHlkSySW/be54Vv0BcLX6cimN2vRS9+Ov/NFFIDt9N/TJQPMxqGjeRzI8SblNJUY09r2H3R
 p4S+7yCfvYHAySw0pkYxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ddC8d/CS3Ts=:njPJLH1am0K2Kc1PfHSJ5D
 cy5Zy2DqTdU3L8bc1AdcGAGRdA3DbIOSQMAFP8/AkZFYk3pLWKe6YeOHCx+VkSXaTgA6oQy5h
 tITXaT+65zyHVwpZlm/8bJTbS5XnzHX7Xz7PRi5sIzG7Hbh0h5r22E5TgAtv6+dxWxLAkgP3d
 GXnv9/yBwOaUQSLWhS/8Axn/qqjzGMuUXweoVO0SLOuh0mVFOQFK0NTc0a9ZUaM7MAxynQ4KA
 wq/7sjrtcqFMYf7V8RiDXHglzTpYlN93qiHIU979Z55WamIPs/fIm3++D5lwv+h/UY7R3vTmt
 d6Cx4mAXac3Xp3NqNcktBgbZEw8L6FhPw2molGGaMCP/VOq9Bx3+T/FID5RbK+ejX/4RwviBJ
 SR/YtD4P3QR8GNLv5xg4ZVsxzmcvKLlrgSOxI44guiY9PN9XXbvIyfeEm/r9HE29e7EnTHC+4
 ZZSdDKUVJxJHIw72EtkwK1qgzDsavPuEV4BLt9itF5YXunebvIqEa8RyOeO2eiKHr8NpdGiDT
 1FAqCvboQKw24fvj737JSZl4gZiiK7jja9i0DTwpoxn0NC/FWiaJvxEx6LfuLYubJcXj7td47
 3qJ77VgsE828r5+krFwMtBqrGwyDkBLZHdD+ZmCK7B7XlCkv7RHz2nPHPwCGoEbgPBxcBn+xM
 ZHz00beSzr5uT4jBicjVARGL1SJvjP394OsA36oJd2oNuEX8AiecQMnmYIsD6/zeYmZfG4Tde
 qegkk46iIgAm848ETh5+7l2qkK4OyNUp6pnd9ypqyee5kJUFcKrQF5qf7FJB3EmbZQjwSdeZj
 tjMMOpm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.2016 um 01:46 schrieb Jeff King:
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
>> index a942d57..89e3bc6 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -166,7 +166,8 @@ endif::git-rev-list[]
>>  - '%Cgreen': switch color to green
>>  - '%Cblue': switch color to blue
>>  - '%Creset': reset color
>> -- '%C(...)': color specification, as described in color.branch.* config option;
>> +- '%C(...)': color specification, as described under Values, color in the
>> +  "CONFIGURATION FILE" section of linkgit:git-config[1];
> 
> I like the intent here, though I found "Values, color" hard to parse (it
> was not immediately clear that you mean "the color paragraph of the
> Values section", as commas are already being used in that sentence for
> the parenthetical phrase).
> 
> I'm not sure how to say that succinctly, as we are four levels deep
> (git-config -> configuration file -> values -> color). Too bad there is
> no good link syntax for it. Maybe:
> 
>   ...color specification, as described in linkgit:git-config[1] (see the
>   paragraph on colors in the "Values" section, under "CONFIGURATION
>   FILE")
> 
> or something.

That's better.  Or we could remove the "color" part and trust readers to
find the right paragraph in the Values sub-section?

-- '%C(...)': color specification, as described in color.branch.* config option;
+- '%C(...)': color specification, as described under Values in the
+  "CONFIGURATION FILE" section of linkgit:git-config[1];
