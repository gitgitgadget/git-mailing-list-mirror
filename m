Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C68B1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 11:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeDSL0U (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 07:26:20 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:39235 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeDSL0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 07:26:20 -0400
Received: by mail-ua0-f174.google.com with SMTP id g10so3188094ual.6
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yLwisXjg/kE4xZAKsg3vGbX1nwD0LO7p0mFxzyK9AG8=;
        b=vbs1t2QqaBbj7SjdLW+yagvbb77ICc+9xWIHCRIbDfXBHzRjiXVZpu2jpQtLerV7dX
         r+LiaWeDuAbdPwzNkJ+7v2gNVQ144UFRwpbFCZu4VFt/m/Qa5BRpoj1zzjx9XRylpe3B
         GcX0atre62ufntPvZc7zoeELSZHJCmewSECansYFPNemrEb7Qu6SQGH1vqgn2z6NNq/+
         mkugPZFIxzrnC+MH54pGrnaaDV3HpzDMRa34vsAwqouFIhmHAdyDEmunwNMhQUWNiARG
         3O9oEmymbrFmH9O4K0unmqz1QXaGwvfPNDAuxZcuwFDvoQ1YU94Fa1gsWyQgmWeKRn+A
         FuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yLwisXjg/kE4xZAKsg3vGbX1nwD0LO7p0mFxzyK9AG8=;
        b=MfoPLQMf7eUh8VBW+rOh2jkOCt2LNHQoBW/rOBSi6ffWYjB7lTDe2SGHdWQSnaMsR4
         1KDW69sSd7gtDt8mEertOnR/utbPXLelA5uYDQBqaAdj/zpjU2NIhwLmXcUYa9uuR+KP
         eAME4OmSvSJUQhjazd2QcDuNc51p7U0ZXnD3LLtfj6gsjF/bLz9ZwFdQ4cu/CTqgULrH
         Xv/8qytCDwNQrTI7ND8StwosX48eM4xavdDmBgYTIpEkt3qsK9SaB4iKG28yT3xW6VRq
         bCfMoLThsv6zdZegQMH2fYuXxjsn1Q6aKmDtE8i8oNCEa1TZOHm2dri0v6luZJnPiofq
         +Xng==
X-Gm-Message-State: ALQs6tCBO5O7EReTD0JsP/T8gp6EgtZFKWX6ICf3owLS0nKD7FElWvS4
        EG93xrJsmWhFPOtvPTkRbLhE0ETtNnJjs0R+F98=
X-Google-Smtp-Source: AIpwx49S02FbIcHmf7XHcfZCgL8ZO6AEU6we/tWDA2AEVrHeokLr3zpicWwKdwpw8i7BTuuuw1sKIJESzzI84BmOZV4=
X-Received: by 10.176.82.225 with SMTP id w30mr4482678uaw.31.1524137179422;
 Thu, 19 Apr 2018 04:26:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Thu, 19 Apr 2018 04:26:18 -0700 (PDT)
In-Reply-To: <20180419103725.GB19591@ruderich.org>
References: <20180326165520.802-1-pclouds@gmail.com> <20180419103725.GB19591@ruderich.org>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 19 Apr 2018 13:26:18 +0200
Message-ID: <CAM0VKjkJJv2qLu_8Lx3pY7S1Hu8GCzYbsEw-8wXvBK6XC=KewQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
To:     Simon Ruderich <simon@ruderich.org>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 12:37 PM, Simon Ruderich <simon@ruderich.org> wrote:
> When running make -j$(nproc) with the current pu f9f8c1f765
> (Merge branch 'hn/bisect-first-parent' into pu) I see the
> following error:
>
> GIT_VERSION = 2.17.0.732.gf9f8c1f765
>     * new build flags
>     * new prefix flags
>     GEN common-cmds.h
>     * new link flags
>     CC ident.o
>     CC hex.o
>     CC json-writer.o
> ./generate-cmdlist.sh: 73: ./generate-cmdlist.sh: Bad substitution
>
> This doesn't occur on a non-parallel build.

It does occur in non-parallel builds, too.

See:

  https://public-inbox.org/git/CAM0VKjkns+AsVyMSe2fxzT8a8oqYdNX3qO8mnw2juOgFC7LHYA@mail.gmail.com/
