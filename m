Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058B71F597
	for <e@80x24.org>; Sat, 21 Jul 2018 09:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeGUJ7N (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 05:59:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36487 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeGUJ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 05:59:13 -0400
Received: by mail-io0-f195.google.com with SMTP id r15-v6so5568613ioa.3
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EMj1EJEU4zDtSTvXQ/ly2Fs47he3UnAYX6sevLrWLeU=;
        b=g4oB2sK25BJXF2AjdyhftS2oPMrRkwQ/nRMzNiExIkYJtsawyGLkj0onL9FPMgFiXh
         53XC+ZN2tdryJ19y8f8bwK7jdZANI/DuLQLl+TwfTr+yC3DfF8Tq7wSf/YGWDz6U2kj3
         i8akJdbzbTqRoGrWX55T8kTo7g/3yoFbvf6ytpOOPKvZNgfpWa/GUZx6iVfayz8KFBv1
         uOmRcJo/2WU5nNlw4dCvGxagg0nsRL5nAWINoRAJ/NFvlCsdH3SM/tUJPVxmLh0V+40b
         KqssMwZ/4syoiBXnkRg9zoE7+UGpEIp2trUXp8rKCOIEm+NwUIAzpIfRhXJkeIJYHJ+R
         eeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EMj1EJEU4zDtSTvXQ/ly2Fs47he3UnAYX6sevLrWLeU=;
        b=khjqB8GItgnm9xQ58Z/7jmkVZwj6s4XleoRQWTvDlkkjrZUMbYCmIH0bphHNejUOq+
         qBTCEnaUo92Vvj0AwwNiRTOLWgX5p6DYRuzL9ZSjnejAeeSjJkSPh8qbq44NdAa/EOK1
         knCnt3nHiV2fkrmYGgc3QnPPCk7AFwFBxf2KRxGdYLYoqj8GDHqmNcD2Z0POTFRtKhkH
         SLFEbgabdjTgi0re3XungcXTRL3jFvQhwb0cvA7XEd9cfoWMbPKEMQNNj/glt+48+6u9
         tHJIvIFda1ZsscMu5huu+K+Pn794U1Ixopejh/e3kyLBXMRh//k0xFbuQs+kG44FyPgB
         1Ljg==
X-Gm-Message-State: AOUpUlHa/N5Bc0VvzqmGKVno41ab/dwBPzkLl+rTklCLYeGAYe+VHeKp
        jHEcg+4szVoszz8TiVklbwfZJWgpwcqJCs4gLMRv+w==
X-Google-Smtp-Source: AAOMgpdQwxV6fJY0s9aLcr0/E1skSKgiObySZkpRCTzh4IXqf8mBEWT4hudynCMuUgJc/LsA+q8b+zmXDc4MAiPrdQw=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr3776682ioe.282.1532164031581;
 Sat, 21 Jul 2018 02:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180630092031.29910-1-pclouds@gmail.com>
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jul 2018 11:06:45 +0200
Message-ID: <CACsJy8Am4bWKziBV6-J+c+Kz4u-rkotgZiorhvHOfy2K5cMBvg@mail.gmail.com>
Subject: Re: [PATCH 00/12] Kill the_index part2, header file cleanup
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 11:20 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
>
> Like part 1 this is also boring. I wanted to drop these 'extern'
> everywhere actually, so before I touched any header file in this
> series, I did a clean up first. This is the result (and to reduce diff
> noise later)

Junio, part1 of the "kill the_index" series is dropped, but what about
this one? I think it's still a good cleanup and it only slightly
conflicts with 'pu'.

>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
>   apply.h: drop extern on func declaration
>   attr.h: drop extern from function declaration
>   blame.h: drop extern on func declaration
>   cache-tree.h: drop extern from function declaration
>   convert.h: drop 'extern' from function declaration
>   diffcore.h: drop extern from function declaration
>   diff.h: remove extern from function declaration
>   line-range.h: drop extern from function declaration
>   rerere.h: drop extern from function declaration
>   repository.h: drop extern from function declaration
>   revision.h: drop extern from function declaration
>   submodule.h: drop extern from function declaration
>
>  apply.h      |  23 +++++-----
>  attr.h       |  24 +++++------
>  blame.h      |  28 ++++++------
>  cache-tree.h |   2 +-
>  convert.h    |  56 ++++++++++++------------
>  diff.h       | 120 +++++++++++++++++++++++++--------------------------
>  diffcore.h   |  50 ++++++++++-----------
>  line-range.h |  12 +++---
>  repository.h |  25 +++++------
>  rerere.h     |  14 +++---
>  revision.h   |  69 ++++++++++++++---------------
>  submodule.h  | 112 +++++++++++++++++++++++------------------------
>  12 files changed, 269 insertions(+), 266 deletions(-)
>
> --
> 2.18.0.rc2.476.g39500d3211
>


--=20
Duy
