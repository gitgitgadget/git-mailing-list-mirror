Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3C21FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbdFMMeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:34:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34418 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbdFMMeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:34:20 -0400
Received: by mail-it0-f65.google.com with SMTP id 201so12286460itu.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=giCWuI+/iszmstYkEo9M+eJ8VPICOH8Tvtg5QV2uFig=;
        b=q0dbhhy3ioN6RuDWBZBkDqxHIeoL6tJUNuj8z8UNn19WAkdjbmfGgy5WI1nsL4m0CI
         FkVhxdofwvOhnAaQ75EkD4uPIgtI4niajfHRM2g2b8baKI7PQEB+l4rSouA6/5ZRv40u
         iBVP2Zb79x32u3f8E3EHP09RGW5vRKtzPJ+18WUh7MeO6ZV+D4M4XAxQnyJIkgtPqGXP
         hSan5dXq2BWftks6n82xAifQR3zS2gaAwjFGtzzPi3IbYArTCu2btNmXgmf3Cy+sQZXb
         37ZR0TmJ7Cy3ljEVQvMOpwLRwFGU1N+ASpf0Ba3pOQbqyRBRgaLUy5R8k8x4xNX3Rh4J
         Wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=giCWuI+/iszmstYkEo9M+eJ8VPICOH8Tvtg5QV2uFig=;
        b=Cl4hGbiiciZeWPqumwxeNkkHdmFgJm7VV89uBDBVda/1otcdJR4j6sgMul+ufdcIq6
         ZFecQTUiCJzydSHe8lJpp/ISMYdhcSQKPuJB553348/oPk8GuRc07tu9YWY5Gu6N7Vwa
         0KotKJPlMchfkyFng90JpcZYYYmXqkcCKJ0N1abrI6/r5DTAXitrvJacEJvKBX3+HQsC
         ShjisfM26u/hT8dMICJnjQHlCb73rCHec//jtxZGm2oD/XWU6ZJohbQYr0t26Gs1PX7i
         qnpgSpfCWEX4+zZk/u2b/Bp6Cqv8LrwlVYJ+GFuBX00UOH0+1srv5NCQDqXtmb2RhYOQ
         9cWQ==
X-Gm-Message-State: AODbwcBniSjmHlokff9r2MFpko+gy6EgwFWEgtX8LQaVq5s5v+f3kfvg
        zYyXASo6I/EK1gZlOXfKGw==
X-Received: by 10.36.61.130 with SMTP id n124mr16782142itn.52.1497357259326;
        Tue, 13 Jun 2017 05:34:19 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id k2sm1455226itk.3.2017.06.13.05.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 05:34:18 -0700 (PDT)
Subject: Re: Feature Request: Show status of the stash in git status command
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Samuel Lijin <sxlijin@gmail.com>,
        Houston Fortney <houstonfortney@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
 <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
 <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
 <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
 <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
 <xmqqpoe9p6bn.fsf@gitster.mtv.corp.google.com>
 <2217b9a1-dc8c-635a-649e-eae2dec5aaa5@gmail.com>
 <20170613064142.aww23a75pu3ytym6@tigra>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <be7311a1-1dfa-2cb6-4426-6771db545892@gmail.com>
Date:   Tue, 13 Jun 2017 08:34:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170613064142.aww23a75pu3ytym6@tigra>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

On 13/06/17 02:42 AM, Konstantin Khomoutov wrote:
> On Mon, Jun 12, 2017 at 11:42:44PM -0400, liam Beguin wrote:
> 
> [...]
>>> Conceptually, the contents of the stash are *not* commits, even
>>> though the implementation happens to use a commit to represent each
>>> stash entry.  Perhaps "has %d entry/entries" is an improvement, but
>>> a quick scanning of an early part of "git stash --help" tells me
>>> that
>>
>> what's different between a stash and a commit? 
> 
> The same that exists between an interface and a concrete implementation
> in a programming language.

Makes sense, I thought there was a more fundamental difference.

> 
> "A stash entry" is a concept which is defined to keep explicitly
> recorded untracked files and which can be applied, shown and deleted
> from the stash bag (well, you can create a branch off it as well).

I've noticed this but I don't understand when it can be used.
I'll try to find out more on this.

> 
> The fact a stash entry is a merge commit of two synthetic commits is an
> implementation detail.  It can be very useful at times for power users,
> but regular Git users need not be concerned with this.
> 
> Another fact worth reiterating that what the UI displays to the user is
> better to match what the user reads in the docs. ;-)
> 

I'll make changes as suggested by Junio. I slightly prefer
"Your stash has %d entry/entries" over "You have %d stash/stashes" 
but I'll go with what's used elsewhere in the documentation. 

Thanks,

 - Liam
