Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29453202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 20:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdCIUcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 15:32:31 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35226 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdCIUc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 15:32:29 -0500
Received: by mail-lf0-f52.google.com with SMTP id j90so33170846lfk.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1wgRKhWLl4ln3+PJN5uiLjQgfWWwnIE7uCS58JPchZs=;
        b=ssL0IGLUJd9laoeyFuGEzJdBsLXwHqsAryY0xh30785zHoAQU/28itFbARZMbLAdxh
         45NL2v+mQykqiEo/U8rYCRfvYa9xlQU7pXnYu1XuZgPukwhe+azLD6UT6JdkVeBbDBAq
         Mh3NaCG9Au6436ahra5COE6fBkyDp8AWxmGyWPsH2PcJFhXCvTgQHSD23x/9Ztf8YDAo
         Np3sPpyn1u6PnK4R7dDAIF+S/5WdhpF3gul7lfcoSol8+pWltoUGifSUpacwFbQ+JWqO
         OCiY/mVkC6xETPRDDe/SNsLt1yowWAT0PWe4JQBFYlRu49QoCyVtopSYwGxb9WrhYbIi
         bjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1wgRKhWLl4ln3+PJN5uiLjQgfWWwnIE7uCS58JPchZs=;
        b=CS7wYPlnTL4Md0ETnT+m6JdDeSmXil60I/oThIs9qtJmghL0URSNzaiZopUeuSMLr1
         zwp/d6lLEuGYgyLiEKZz6X+VCOC9ve4/PgLeJsJpD6Taa/O75Q40ZFTE42CF27fqeIar
         77Fb1+xRBcjFt3zYe2O4JdoWtQVutqssO5V0rneznZCO2X3WLoZkStAwANxiff9el6HS
         mKW4AOaIXtwjpAQRuo9lx1N38BWmrhnG2EFZhJsjlc5VLrcZRWdGaZHSCvo3F8ua5QKh
         3ikDGfRAd0iQygMELJnSfGaN/1n6Z3P2PCANyAmtXcv3dfsMpJchBFnN0Vqy9+TkXXMZ
         cE1g==
X-Gm-Message-State: AMke39l+AAvXK2cvTNCPc4yI22dMhm2G4C4aupwdSW/pfNv4G9oStNx8GZ256uFGlMIe1bT8fZ5kRN3Q3r6k5g==
X-Received: by 10.46.71.81 with SMTP id u78mr4667566lja.16.1489091511492; Thu,
 09 Mar 2017 12:31:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 9 Mar 2017 12:31:51 -0800 (PST)
In-Reply-To: <20170309200243.2203-1-avarab@gmail.com>
References: <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net> <20170309200243.2203-1-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2017 21:31:51 +0100
Message-ID: <CAP8UFD3zGTO5RBpX-WE+8KfTa0pv5NcNDtBRVdRVEdGomL_Wfg@mail.gmail.com>
Subject: Re: [PATCH v2] ref-filter: Add --no-contains option to tag/branch/for-each-ref
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 9:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 525737a5d8..4938496194 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
>         <tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
> -'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
> +'git tag' [-n[<num>]] -l [--[no-]contains <commit>] [--points-at <object=
>]
>         [--column[=3D<options>] | --no-column] [--create-reflog] [--sort=
=3D<key>]
>         [--format=3D<format>] [--[no-]merged [<commit>]] [<pattern>...]
>  'git tag' -v [--format=3D<format>] <tagname>...
> @@ -124,6 +124,10 @@ This option is only applicable when listing tags wit=
hout annotation lines.
>         Only list tags which contain the specified commit (HEAD if not
>         specified).
>
> +--no-contains [<commit>]::
> +       Only list tags which don't contain the specified commit (HEAD if
> +       not secified).

s/secified/specified/

> +
>  --points-at <object>::
>         Only list tags of the given object.
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 94f7de7fa5..e8d534604c 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -548,7 +548,9 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                 OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on =
remote-tracking branches"),
>                         FILTER_REFS_REMOTES),
>                 OPT_CONTAINS(&filter.with_commit, N_("print only branches=
 that contain the commit")),
> +               OPT_NO_CONTAINS(&filter.no_commit, N_("print only branche=
s that don't contain the commit")),
>                 OPT_WITH(&filter.with_commit, N_("print only branches tha=
t contain the commit")),
> +               OPT_WITHOUT(&filter.with_commit, N_("print only branches =
that don't contain the commit")),

s/with_commit/no_commit/
