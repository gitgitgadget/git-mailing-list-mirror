Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3534E1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 11:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeHXOjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 10:39:04 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36890 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeHXOjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 10:39:04 -0400
Received: by mail-qk0-f169.google.com with SMTP id f17-v6so5565804qkh.4
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BGvCxLj29kuDgX6sdTtVKxMjZdeFCZ5lJ8mslU5Axpo=;
        b=dFuOyMe7hw/TPIuj6Dze+TWk/6mrmpFDY7rFm6eNaRNFwgbcNukkJtj4VtegkFRkwe
         +A9eMhkWR+WJUdKWpesNroB9OKayvvjQRywYez0IfgX9Pwv8AzmbWGWigzLncvBvKuBg
         n8CyJwFBPZB6B41qxLzVwFppko/IfSvi/I1SMvHgrfGQTHPGp7JbaQaNsz+i3ubAzb1Y
         XhSA70oe23JSmoFH43mHhM8gC3gjioAyAUxBjuHxB9c4fEIRX0pkpJanpEo3y9n0rSim
         id5iudgjsAD8ZdEQindmyi5Uu2sXry0K/mmX4Ffhe1iwbB1D80RWfDk4iET+CXzWNskN
         RfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BGvCxLj29kuDgX6sdTtVKxMjZdeFCZ5lJ8mslU5Axpo=;
        b=I+P8JZwKQCeBgxA+V8g2IGpftjqj8I0AX51c0szkUyhNqUZQxa3UYJvREbzeYGK3li
         8KmTXCwplvTlZUCthm8P4oPwKRbEKdCIMx6XLUM5HmNSS0aYZQvk02uwAf7S/0QHW73t
         TCdA4FLZ6w8ubQMpD8SgkKNlMDboM653MYFF4P3XC4OoGGyxd7JYRiYFL52h/Q5QFyky
         6DzzpOJOwcWPhKwYPbDbO3lp1kRnomY2nzLuC0H5V7BM6TYknxXPIhsN/a5biGHuGFDo
         JlSfdhmEJTEatXHZFttP67QtECrX1kDc/yixMOr/Zr5z3Fve1vmqmLUQZd/DB6n22tgT
         mZnQ==
X-Gm-Message-State: APzg51DYCmYQ2zp6Qaw2Tew+2H1WAES25sgYsbEqmDfg71uPA1IkYzE7
        i7L3wACQ+F0Kc5nNf4xHMuA=
X-Google-Smtp-Source: ANB0Vda6KWi26I+s9nWqxdYCmDRmJMtPpzBQWQ798pYmohcOnmuzeqovZiauvkFBJgRLQVAEwFq5Bg==
X-Received: by 2002:ae9:f401:: with SMTP id y1-v6mr1052205qkl.178.1535108694858;
        Fri, 24 Aug 2018 04:04:54 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1864843qkf.59.2018.08.24.04.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 04:04:54 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823161451.GB29579@sigill.intra.peff.net>
 <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
 <20180823234049.GA3855@sigill.intra.peff.net>
 <20180824000637.GA10847@sigill.intra.peff.net>
 <20180824001643.GA14259@sigill.intra.peff.net>
 <CA+P7+xpm-gsjCpPOZ=2z03Peb1Jb6axKo2nTp=UUpAFgWNureg@mail.gmail.com>
 <20180824025955.GA24535@sigill.intra.peff.net>
 <20180824064512.GA10521@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3c73a374-ddc7-2c6b-5578-1b695c0ea7e0@gmail.com>
Date:   Fri, 24 Aug 2018 07:04:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180824064512.GA10521@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2018 2:45 AM, Jeff King wrote:
> On Thu, Aug 23, 2018 at 10:59:55PM -0400, Jeff King wrote:
>
>> So I think we have a winner. I'll polish that up into patches and send
>> it out later tonight.
> Oof. This rabbit hole keeps going deeper and deeper. I wrote up my
> coccinelle findings separately in:
>
>    https://public-inbox.org/git/20180824064228.GA3183@sigill.intra.peff.net/
>
> which is possibly a coccinelle bug (there I talked about oidcmp, since
> it can be demonstrated with the existing transformations, but the same
> thing happens with my hasheq patches). I'll wait to see how that
> discussion plays out, but I do otherwise have hasheq() patches ready to
> go, so it's probably not worth anybody else digging in further.
>
I was trying this myself yesterday, and found a doc _somewhere_ that 
said what we should do is this:

@@
expression e1, e2;
@@
if (
- oidcmp(e1, e2)
+ !oideq(e1, e2)
  )

(Don't forget the space before the last end-paren!)

-Stolee
