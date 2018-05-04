Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3B7200B9
	for <e@80x24.org>; Fri,  4 May 2018 05:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeEDFQT (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 01:16:19 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35737 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeEDFQR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 01:16:17 -0400
Received: by mail-ot0-f195.google.com with SMTP id h8-v6so23205591otb.2
        for <git@vger.kernel.org>; Thu, 03 May 2018 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Antn8hfAlJpCSOPNfJ8PwqTMeILIZflFr4N5jZ5Yujw=;
        b=KVOnljejtFXY2kHEyVzhZnTMuWZBagCl8HTePLAwj3f6/TTVF5S0u3IVAYF3oy9ncR
         R5evWPAdBxvewZNhnqNFTkxl2qIwqxK3rTo6Xx/6jwTPYYUPFG3LkLFfLmkJqdN+2Kdn
         i+5ufPS28TpoaSpdcVkc7CT6RfG8CeB46SckqoZUI280qVI8O1DD5SOTE6WJw2rELQnO
         YbUQTUSUbH+4pf98xIq4kX94yvFQIixaWo8fevkkltBDg7zXkWRpuNYDudbozKHrg+Fw
         r+x0qVxfyexkLzN+12dPwsk+xcmahz4aUhTXgsW5rtevhjHJCFkwzSayzzAznnwRFINH
         T4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Antn8hfAlJpCSOPNfJ8PwqTMeILIZflFr4N5jZ5Yujw=;
        b=KoRUz6Qq+9Cz4THJzAZPj8UAUs88gHm+gNZ/0IHBuq/LKrioAcZ51fqegw6rE+IWFA
         zvmPY/fw72KrITE6XEhfcejVuQaf3yHgzK2t9pFXDYDk/YgCX1b3+WnJP/ZCNEtmadRs
         uz5wv+HjlsBeuUE5Z2y7K1OlYFAwYTxsbidvW0c5PObhgw9iwx9NOje/YUy1ZbIZsLXy
         1yeHpor/hd0dR9hX5BKN8+jqAaH+wjAMKQuVIfExf3xedTY+x9CL21E2r8B2fi2jEfOU
         Ds0prLBcBVxd212RLM/DHWmTBqRXyGNv/+YVCaVAe5Yyz/Dh33vJpZrZXK9whLRgDn8u
         NI7g==
X-Gm-Message-State: ALQs6tDw3VmsdHK1Rq0iY5Nx8RudjfFify0hlkayMNWAeOO9A6S6SF2R
        /SZpYtmOkEL/TDto/0nTathruvAFwvOSOL5ThzY=
X-Google-Smtp-Source: AB8JxZrRg4kcWXpFv548GgA2t7thBDk8QB1rxc1oANo2269BerymfBnht7srvudDqF3KWbFXwfaIm76NnKSq++u62go=
X-Received: by 2002:a9d:4197:: with SMTP id p23-v6mr19380943ote.75.1525410976155;
 Thu, 03 May 2018 22:16:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 22:15:45 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 4 May 2018 07:15:45 +0200
Message-ID: <CACsJy8CRCb2go5qUBOdiSNvvAShotD=e4Cm3Jo1OxNk212YtCA@mail.gmail.com>
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

On Thu, May 3, 2018 at 10:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 3 May 2018, Johannes Schindelin wrote:
>
>> On Thu, 3 May 2018, Duy Nguyen wrote:
>>
>> > On Thu, May 3, 2018 at 5:30 PM, Johannes Schindelin
>> > <johannes.schindelin@gmx.de> wrote:
>> > > diff --git a/command-list.txt b/command-list.txt
>> > > index a1fad28fd82..c89ac8f417f 100644
>> > > --- a/command-list.txt
>> > > +++ b/command-list.txt
>> > > @@ -19,6 +19,7 @@ git-archive                             mainporcelain
>> > >  git-bisect                              mainporcelain           info
>> > >  git-blame                               ancillaryinterrogators
>> > >  git-branch                              mainporcelain           history
>> > > +git-branch-diff                         mainporcelain           info
>> >
>> > Making it part of "git help" with the info keywords at this stage may
>> > be premature. "git help" is about _common_ commands and we don't know
>> > (yet) how popular this will be.
>>
>> Makes sense. I removed the `mainporcelain` keyword locally.
>
> On second thought, I *think* you meant to imply that I should remove that
> line altogether. Will do that now.

Actually I only suggested to remove the last word "info". That was
what made this command "common". Classifying all commands in this file
is definitely a good thing, and I think mainporcelain is the right
choice.
-- 
Duy
