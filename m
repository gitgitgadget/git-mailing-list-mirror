Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93EED201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 15:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbdBUPEY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 10:04:24 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34792 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753498AbdBUPEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 10:04:22 -0500
Received: by mail-vk0-f41.google.com with SMTP id r136so80768504vke.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QwkjXUieZpDuQFMTwUDNHi0SX7RY79Ea9vwDt4io2+g=;
        b=ejkwVmaK0l+uH20ZoxikYdMngJL2vuJXZHLxd8fp5/zqEh10h/cw3s84zatnLVQLve
         rMXbJIdMDucS4zSjok+wVVp/Mfemx/H36qfpnU9ZGjcBHh7NujLHstfNOEgqn1e4A8xA
         UZ5QVkpxM6KZXq3m3+Q7oeBk4z3xeZIWKLdQHc+Nzt50j0NPwiL/2V70GMDUojiqesnU
         862oe2Et29B+uALKE90LnGHbzSE/boOjRCyV741IdboodR5Jz1NOVLy1nAsFTmjiKgDJ
         Ds/5jv9CQyAl67yTsU07VnHQ3RZ6lbYqm7/8lvL01py01eoq9OdfEj+NXV1cfulyVg8q
         y72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QwkjXUieZpDuQFMTwUDNHi0SX7RY79Ea9vwDt4io2+g=;
        b=UPhen3ePrxgtxLjdJ3Bbczk7kx7fFdsA+5r7hkzjz6Xzht2yIcmq+jiv4z9X5mJ7nG
         uGrNeZd6W8jmnspt6oYbhwNmWPpOVn7pytNvjjZx6YjykwvbLhbu+BILWFfhbcXsky5M
         LWKFxeIDc7jQpgGqB/ofb6zyYIMRj44gKZClbfYqy/0Aw0Jr6+E+EPj173cJoVXPMnqn
         qWdeixJhPoDO+8dKhwG0Nz0M/8NjmT7jptHKTn2J4FJZwTcKLkq2MrfaAwJvgrPOskAx
         cxR+9f/dr2IRKQo1/8+c2/IsPkIOaqqIXSuogrrDF9J76Jm5ySNveikkSlVJfrRbrEoF
         0A+g==
X-Gm-Message-State: AMke39ngSoS1FbxBoI3fCuBtWKMCrPEt2QZJEHP8sDY7oaRftC7rf86cuBMGPP1A4eOAp40rU+tXlFCkYg5pcA==
X-Received: by 10.31.92.1 with SMTP id q1mr11037959vkb.151.1487689461483; Tue,
 21 Feb 2017 07:04:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.120.136 with HTTP; Tue, 21 Feb 2017 07:04:21 -0800 (PST)
In-Reply-To: <D0D8D50D4A2E47568029FE8BC52C3DC4@datasoft.local>
References: <02FFA5DBB1C64A8DA1BF45F11EBF9930@datasoft.local>
 <20170221152216.be2b8401f65650bf766cdd8d@domain007.com> <D0D8D50D4A2E47568029FE8BC52C3DC4@datasoft.local>
From:   Dov Grobgeld <dov.grobgeld@gmail.com>
Date:   Tue, 21 Feb 2017 17:04:21 +0200
Message-ID: <CA++fsGEvYPeP1UYniHF7OnowTH8-UeH3Kwe2KqaYMRouWVzEbg@mail.gmail.com>
Subject: Re: Partnership with Git
To:     Nikita Malikov <nikitam@devart.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikita,

As git is free software, you are free to use it in any way you see fit, as
long as you adhere to its licensing terms, and to the copyright
restrictions on using the term "git". Thus there is no need to ask
permission and there does not on the git side exist any entity interested
in "cross marketing activities". If your want to use git in your products,
you are free to do so without asking, and if you need technical advice for
how to go about integrating git in your products, you can either ask here,
on stackoverflow, (and probably lots of other places) or hire a consultant
that can help you.

Hope this helps,
Dov

On Tue, Feb 21, 2017 at 4:08 PM, Nikita Malikov <nikitam@devart.com> wrote:
>
> Konstantin,
>
> My goal is to establish partnership relations with Git because some of
> Devart's products support Git version control system (for example dbForge
> Studio for SQL Server https://www.devart.com/dbforge/sql/studio/).
> My team and I would be glad to come up with cross-marketing activities
> between Devart and Git. We think that some users of our development products
> would be interested to switch to Git version control system.
>
> Best regards
> Nikita Malikov
>
> --------------------------------------------------
> From: "Konstantin Khomoutov" <kostix+git@007spb.ru>
> Sent: 21 February, 2017 14:22
> To: "Nikita Malikov" <nikitam@devart.com>
> Cc: <git@vger.kernel.org>
> Subject: Re: Partnership with Git
>
>
>> On Tue, 21 Feb 2017 13:21:38 +0200
>> "Nikita Malikov" <nikitam@devart.com> wrote:
>>
>>> My name is Nikita and I'm from Devart https://www.devart.com/.
>>> I would like to contact someone from executive staff of Git. I would
>>> be very thankful for some information how to do this or if someone
>>> contacts me.
>>
>>
>> Git is a free software volunteer project and as such, it has no
>> "executive staff" in the sense enterprises put into it.
>>
>> Can you maybe state your actual goals please?
>>
>> Say, if you're looking for commercial support, we could possibly
>> suggests a couple of pointers.
>>
>>
>
>
