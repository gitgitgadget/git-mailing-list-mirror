Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E94A1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCCJOS (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 04:14:18 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:42582 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeCCJOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 04:14:17 -0500
Received: by mail-qt0-f180.google.com with SMTP id t6so14853585qtn.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 01:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=sv4K/M1UXezWMIgPjup7UehXsTo2zwylMRAm3g5OiaY=;
        b=eHDknoLBZ1wucV+Kxt5g6235XSXGqUtz+jjv3n/aTQq50RAPqmqWTq3R9XzcRvVaWC
         ryXw3I8otqe86FxNTcNvehtXFLVVPgukVdAqtZLJSfsTx2cKQ2oe3cgJzy1s/knFNKBx
         U/n6lV973f2F2uMjA36MRMuTSkz1bjNK2oWtBnVCzY0z9TZ99ATfJ6eiAAfd5BlYaRV4
         e2tpJnTwoWQX9+4W1riZlCjMEgkoUbyLBGoFAqHBDkiKs7UzOGbzbIl88vHKtCOIeBbs
         Kunzo8b03j5a4liB/inWWoqNf3DGVbQIG1gv3AFtE5nQ6vWNYfnHro7nP8fGoYcd+qyF
         mm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=sv4K/M1UXezWMIgPjup7UehXsTo2zwylMRAm3g5OiaY=;
        b=mevm55jGRPvh1aFfe1UvktAtSLu1xoTqhZmU4xpM5Y7rUAVbpzahazmyV8ZgaXsVI6
         os7avdSZUaqKbX5nnWNdEjKauUqk8QWeAnE9DHWhcOR4mYUIefMoXig1AYYM4p8ge+MS
         0U25GF2VtIHGEPJIk13PwAmZh8V7B2zzhVOGWlGQSb2JMpxp0f83CN2gL6g2yKLg5BRr
         Xn2S/Fm/C/pmda8fBoRmXKPH+Auyo2qLs7sNPrUSOiS+63JRkRIT0wTGSxaqtqGiewB4
         JWFDd8WNJOw3EeUJfDzgHu07QG6OEKTFie76GfuhXElan630wSZjZ7GvvZyw7Qsw/fKj
         /grg==
X-Gm-Message-State: AElRT7EIeItMosWpQItr28fOJeWfmFZrUkF+eYpTKbl7FkGYCCGJe368
        s7/j2mMHCgQqLhNJOg5JS4gm3gzkP5SB82eLSSM=
X-Google-Smtp-Source: AG47ELtDXXr+IGCRHh6YGdAAb+KhniI16wKTIPy/vQkEZ++t2FWRCCPNxlEhzLBFEVWrNOO0pBVRrSQeYmi4wNY8WpI=
X-Received: by 10.200.64.139 with SMTP id p11mr13243838qtl.33.1520068456595;
 Sat, 03 Mar 2018 01:14:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 01:14:16 -0800 (PST)
In-Reply-To: <20180303033918.15751-2-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com> <20180303033918.15751-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 04:14:16 -0500
X-Google-Sender-Auth: H2gjxfGiGDn036_W7utKmCWVgSc
Message-ID: <CAPig+cSo_n7y3-qDT92+NYspTB+yF+NUL19MLvfztLJ_qZhXnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gc.txt: more details about what gc does
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 10:39 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> @@ -15,8 +15,9 @@ DESCRIPTION
>  -----------
>  Runs a number of housekeeping tasks within the current repository,
>  such as compressing file revisions (to reduce disk space and increase
> -performance) and removing unreachable objects which may have been
> -created from prior invocations of 'git add'.
> +performance), removing unreachable objects which may have been
> +created from prior invocations of 'git add', packing refs, pruning
> +reflog, rerere or stale working trees.

s/rerere/& metadata/

>  Users are encouraged to run this task on a regular basis within
>  each repository to maintain good disk space utilization and good
> @@ -59,6 +60,10 @@ then existing packs (except those marked with a `.keep=
` file)
>  are consolidated into a single pack by using the `-A` option of
>  'git repack'. Setting `gc.autoPackLimit` to 0 disables
>  automatic consolidation of packs.
> ++
> +If `git gc --auto` goes ahead because of either too loose objects or
> +packs, all other housekeeping tasks (e.g. rerere, working trees,
> +reflog...) will also be be performed.

s/be be/be/

Perhaps this new paragraph should be moved up by one paragraph; the
result feels a bit more cohesive.

Minor rewrite:

    If `git gc --auto` finds that housekeeping is required due to too
    many loose objects or packs, all other housekeeping tasks (e.g.
    rerere, working trees, reflog...) will be performed, as well.

> @@ -133,6 +138,9 @@ The optional configuration variable `gc.pruneExpire` =
controls how old
>  the unreferenced loose objects have to be before they are pruned.  The
>  default is "2 weeks ago".
>
> +The optional gc.worktreePruneExpire controls how old a stale working
> +tree before `git worktree prune` deletes it. The default is "3 months
> +ago".
>
>  Notes
>  -----

Missing backticks around "gc.worktreePruneExpire".

s/tree before/tree should be before/

You lost a blank line before the "Notes" section.

With minor fixes:

    Optional configuration variable `gc.worktreePruneExpire` controls
    how old a stale working tree should be before `git worktree prune`
    deletes it. Default is "3 months ago".
