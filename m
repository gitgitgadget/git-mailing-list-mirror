Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62EFB1FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936827AbdEWJoL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:44:11 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32865 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757409AbdEWJoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:44:09 -0400
Received: by mail-io0-f174.google.com with SMTP id p24so93718513ioi.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0vakAMwHsv8IW/AjnC0ckti1QmDopConJqTxkgSfWDU=;
        b=MJmtE49/TlNlIDfiuurTlmY5daKM6y5eOqTsMktANotczTQXFeTW4tdh9c0KulKPzn
         xKgt8ug61J2Rp5vfbpm3UCTjcrb+oG8zvFL05T5Cir+ZK8ZvhoyqHcSQGOuAHSdjnT08
         pKgYS7jcG4fjpheUA+o0r1lZu2QXWJprjqtlL9B2qXAUmLBRtqI3TgfZE6RqWQhAElBV
         CZ7+VeOGwqnAew9zY+ecobQF1T/r4fSZyYcPKn381Mg9YAk64kM3RsS/XmyebHjq/tj3
         D3w17kG0CQ+TRSPgRlOJj+xlZdIIHz0mlN/DbcYJY02vI8YMjU0jFxhnZWS+QMcPxVrt
         aFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vakAMwHsv8IW/AjnC0ckti1QmDopConJqTxkgSfWDU=;
        b=pHPzEZ0goo+8fsNjz1yOC/RJ1DE81SsQ5too2ANTMdhvrJX+4mT/78V5TOCDX3yifS
         49KqBRL36d7jZa2auFdVtFb0vD5S3Ix2cM89F/C6cug/3xl6SkW0j5fq8Es6MWUy+9kh
         JgfU4/ZszzFHXfEMTy8HVwCul7SE+oSSygeMkaPFUVhwBPnqD4sZqbGsM/3jwIzuNGOg
         Qu9qMaIITNiFGQYhTK3E8m98NIb3E8INrtz8U5rDdHb8jBc/eIUC5Lt+8j4jbdcZeUHw
         fLpILpPQ0E8Kw7RBHR8nYnE2NTjXd0LcsKihNcltpZ2lHgWu/8SHdHBlrneb+wqq74Xo
         pnHw==
X-Gm-Message-State: AODbwcAJxAVRHuWPAb55s62egd2JCch/JHYGPbJSMvg/kGwVIuXgzroM
        gQmbXPuHDDmZXsrthAu0YIK/iolF0w==
X-Received: by 10.107.201.131 with SMTP id z125mr24054940iof.160.1495532648216;
 Tue, 23 May 2017 02:44:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 23 May 2017 02:43:47 -0700 (PDT)
In-Reply-To: <20170515122331.17348-1-avarab@gmail.com>
References: <20170515122331.17348-1-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 23 May 2017 11:43:47 +0200
Message-ID: <CACBZZX5k8jiz2uz4qygdr2-gRphmeQo5fPT1b=mNxcp2REXccA@mail.gmail.com>
Subject: Re: [PATCH] tag: duplicate mention of --contains should mention --no-contains
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 2:23 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Fix a duplicate mention of --contains in the SYNOPSIS to mention
> --no-contains.
>
> This fixes an error introduced in my commit ac3f5a3468 ("ref-filter:
> add --no-contains option to tag/branch/for-each-ref", 2017-03-24).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-tag.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index f8a0b787f4..1eb15afa1c 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
>         <tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
> -'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>]
> +'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
>         [--points-at <object>] [--column[=3D<options>] | --no-column]
>         [--create-reflog] [--sort=3D<key>] [--format=3D<format>]
>         [--[no-]merged [<commit>]] [<pattern>...]
> --

Junio: I think this one's fallen through the cracks, could you please
pick this up? It's also something that should be in 2.13.1.
