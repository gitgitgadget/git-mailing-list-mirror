Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF52E20248
	for <e@80x24.org>; Thu, 11 Apr 2019 11:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDKLLc (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 07:11:32 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:50604 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKLLc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 07:11:32 -0400
Received: by mail-it1-f180.google.com with SMTP id q14so8909248itk.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1MawSP4yD4+s1hIpRShMwQuIpUobHesvsKk+QoTBec=;
        b=EVDcSpB8XUgZmnTUqnQ8kZRVT8FYaAO9Ye3IkACDBG9YMvRhEOMSXLtqhv0HTz9WlB
         Ny0PI1jVWkmn5vEC3NBHwzjvf9cxOZ2SvZc6crGVqnR9IM99z3vXF2aswO4tgZv9Qiro
         v4x63ErcX+/FlovNxqTgwGxPeKrSAhOPYH4N8kpPf5hoxaniLPX9dMxuasrHExJOElPy
         mp+oYNxklyfOh+eonUHRsSFco303CfrsMiyCEM4tP7FvS8dTPiiKN35Exk3Y64RZ7L0m
         nNsyCwzvHb1/O1zr3of/iXp/Xen4EQ6tQX7ceHfWUILYGabZQwERPl3UiS0Ce3/KcP/B
         ItFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1MawSP4yD4+s1hIpRShMwQuIpUobHesvsKk+QoTBec=;
        b=uVyTE+yRKsUQiGYlP7+kNJ2a5aMNmlaRHbdVAMCvCX+P8fA/AKElCplxfdql5FPxt1
         I5ENOCANtG5JgtHJcmqqlrli+KUaccVar8M404jcKOQbbYZ4O2S0Dp37HTQKN3iIWNuG
         84xOo6kv5cJDo2olEoOX7a+1i1mQIHUzxWbKd0IGzfodygLYGSoEbsJI6A9hhPHuIXmW
         +H8iTe+maFRsaeJ7qr4pLg2CZw7S+HImvWqLm9Hb1ZCpddh5OM0Lmty8iSzYJwTn5iWx
         L5kMrKM6QepGSBWhNUAn1ma6YYtQGdBuZLDTuiBqO8y28r56JzXciKZlKQZXE9bTFrwz
         PtxA==
X-Gm-Message-State: APjAAAUI69sx7UjhdjHFNrDEBfW5pFvAsbxJlX/Lna1qPsgsdhyBwT0c
        tz1Uf7SCSkRCaEdjfej08semfKh3IqKrQHs1te4=
X-Google-Smtp-Source: APXvYqw2ea/p29IVBFhsmWFW/BeX+X/FpFHWpYrNmIRnVyyU7s2NV/C2XgYL8H4Tjnck6ulvv9oMSVWBKLHQPULtGVM=
X-Received: by 2002:a02:c50b:: with SMTP id s11mr4067jam.84.1554981091896;
 Thu, 11 Apr 2019 04:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180116103700.4505-1-pclouds@gmail.com> <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
 <20190411111038.GA5620@ash>
In-Reply-To: <20190411111038.GA5620@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Apr 2019 18:11:05 +0700
Message-ID: <CACsJy8Ays5vUs9aREmornQGhT7dMEkd8uzA90A2=Ghf1BfN_8w@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry mistyped 'y', please ignore.

On Thu, Apr 11, 2019 at 6:10 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
>


-- 
Duy
