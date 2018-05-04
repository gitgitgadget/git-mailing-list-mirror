Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6A0C2023D
	for <e@80x24.org>; Fri,  4 May 2018 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEDPa0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:30:26 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:37463 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEDPaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:30:25 -0400
Received: by mail-ot0-f180.google.com with SMTP id 77-v6so24907027otd.4
        for <git@vger.kernel.org>; Fri, 04 May 2018 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7CR/SAz6ZYTe5YUPvOGOISfctzRx0nvPFrkbEK4oBKE=;
        b=foi0j55hK2ABCc2+X9nBzH+4rxjs3qiD1pZwdbTgyI4NVxrZ29QpL3KogvHa9t3qgG
         J23qIHJEpL5PrW1n4uKedl2kGOnSW1swMNjaN7SiIyLR2+KCZ+XqmUpjnknzw3Uz/wGu
         YRQ9BKpqIB8vlA40nisbGqu+yW1X3der4F2twfn2PZglahrEi0Obz2ImPgWVTYXB4dKg
         xHFdnm4Lk7lgsXD5veTGDExchw6kwGetysGpMPsbrit56hGJG3xwOkx4nJS7cCZnHI3d
         5pE5gDcOwdxSk8p8lFzqktbnXd++Xao2+0HHwC2NDjmHPGelnAxNhIbVwnvqWmgRhm39
         RL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7CR/SAz6ZYTe5YUPvOGOISfctzRx0nvPFrkbEK4oBKE=;
        b=jnKRJW0AfXrcZKtYU2l5UvQpfAO8f9Tl2ZtIgxi07ViP/TdKxutEY3I45SNQ8WSThK
         TkYY0TrKNqzofoVJRzdMUfPANEwYSMnqzZiPs8kdl/UbIHyMdhyGzMV4ii049RgnWJaK
         1l9IX7F5YiMwauk2MaaZpzFFIWJd8M1Y5jzEl/NDwoqq8Xvj4R8suuE4d+/NzSUmEF1I
         /XnybkLl3HMhZkxar9rFs4e1ryEJojjrA8nP7foDFJ0cXpCO4v/wusLlHhvreH+MOfdj
         sC6gj/DOYLM56+MNvsygUlBOf46JfBL/VxLiTbmGieIbmL7g/eNhRPoP5C9lDj5Eb7IM
         yfEQ==
X-Gm-Message-State: ALQs6tDt/emPztwN4Aux5hj8vQvhMEyal38k/IAAGOdvgAmON5uwD3oK
        ml3ik3AULc6ZlWdW8yTCxdoDDmkFd3RrjL/CFJA=
X-Google-Smtp-Source: AB8JxZreJgRhtgYPsFfjxOc92nO4uuuvy42SxW55kpiB6o4kYwveiH5RGa8swwXgHKXBeQ+Al0MbkghKayEv1HZmIiA=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr20908569otb.152.1525447825213;
 Fri, 04 May 2018 08:30:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 4 May 2018 08:29:54 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805041723050.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet>
 <CACsJy8CRCb2go5qUBOdiSNvvAShotD=e4Cm3Jo1OxNk212YtCA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805040919400.77@tvgsbejvaqbjf.bet> <CACsJy8AnWC8bLfhj25quzHokber-wrWdSsJiCDra=Ymr++0-nQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805041723050.77@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 4 May 2018 17:29:54 +0200
Message-ID: <CACsJy8Cr8f1oXe18_YdJn-5=mKuCJZgM22dBd=Z6+GQh8EUF6g@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 5:23 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> > So that's what `info` does: it influences whether/where
>> > the command is listed in `git help`'s output... Interesting. I thought the
>> > lines here were trying to automate parts of the tab completion or
>> > something.
>>
>> Oh it does many things. The completion part is coming (so yeah you
>> don't need to update git-completion.bash at all, as long as you have a
>> line here and use parse_options() ;-), but I think it's mainly for
>> "git help" and command listing in "git help git" (this command for
>> example should show up under the "Main porcelain commands" in that man
>> page when you put a line here)
>
> I have a hard time believing that anything automated can infer from the
> source code that branch-diff can accept the non-options in three different
> formats, and what those formats look like...

Yeah. For now it can only do options which is machine readable. But I
have a big plan, so who knows :D
-- 
Duy
