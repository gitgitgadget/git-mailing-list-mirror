Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF261FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966061AbdCXP6u (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:58:50 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36578 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966038AbdCXP6h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:58:37 -0400
Received: by mail-it0-f47.google.com with SMTP id w124so12238146itb.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+F1VFEa3Bu60G0rQA2yM/9Of+EGL+36x5fyTcqSYm5Q=;
        b=VAoL/+7aZ6KQCi3eclU8cqY+ebs6+Xv5pQXmhWyCFHle+cZVolj2LVGeMq4prqL4PZ
         JO28Ol5b+NMjP6RTwQbwJX7IqZKat4lBSAZVTxZyuAU5wGzPQF4ehCrzE6uDuxSA1U6F
         xwCmJMzcKl773ctsW/HxAC92EFYSp/D32caiGffIL9laD2pDyLBxRKX/zaWSuLP713As
         aF5KA5Hdh1wY1dsVcprEh01zr+Y1pBGrJXtLKR7tt7bdv33q0mcXSTEacTqtWFFkZvRK
         juuu5f5FHlusCvMshGCDQe3/7p5n0rlsOmyojifI/sQOtgxU+Q2fHRHnOYshZq2K+dCP
         Yq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+F1VFEa3Bu60G0rQA2yM/9Of+EGL+36x5fyTcqSYm5Q=;
        b=SD8kAvyHvo9BEmDyOwrBEtYVFpb9YQfme+a4e4PbXcC5qviO2gMNwy3EjnIeq8Ku3s
         f07UuJnqYkNwS2QvrBVGMbYJgQo38MA+miYaWZ0NREkTK7yRYfVVCQpCMbf75uuQ/pPG
         gYmVdzyPZZGvBwvX0iSPSpznHZAYjr98GlS8BquvwqHVrKLK0xgkCqlo8p20usU2BK0H
         qkFut/KtD8XeyNwGicJFa5hcPLW4xZIRFYxwpAttjW5jNj4bOLu4z5YWtGUn7qwcOOxw
         itdGobXn86iv0/B34tRP8jOs2Is5lVVx9+s1N01qaeQFFAdhat271IAcuqD60d/J4Otg
         SJjg==
X-Gm-Message-State: AFeK/H0+0MVtmrf9jvMo8N5h8my/j5YD+kwcXSWdOhuthLrhzpqTmX1Ed/Iaynvm27qKgaglBVJx57oHYpFhBw==
X-Received: by 10.36.116.71 with SMTP id o68mr4048557itc.60.1490371114862;
 Fri, 24 Mar 2017 08:58:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 24 Mar 2017 08:58:14 -0700 (PDT)
In-Reply-To: <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
References: <20170312200248.3610-1-jn.avila@free.fr> <20170320210225.13046-1-jn.avila@free.fr>
 <20170320210225.13046-3-jn.avila@free.fr> <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 24 Mar 2017 16:58:14 +0100
Message-ID: <CACBZZX51BskROyC_Kp=-PHuqzJ4uaDpu277R0Y4qCvz=6vLUiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jean-Noel Avila <jn.avila@free.fr>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> But more importantly, aren't we essentially adding an equivalent of
>
>         cd Documentation && cat git-*.txt
>
> to our codebase?
>
> Surely we cannot avoid having a copy of all messages that are to be
> translated using msgid/msgstr based approach, and we already do so
> for end-user-facing in-program strings, but it just feels a bit too
> much having to carry a duplicate (and slightly a stale) copy of the
> entire documentation set around.  For N languages, we'll have an
> equivalent for N copies of the English text, in addition to the
> translated documentation.

As someone reading this thread from the sidelines you never elaborate
on why this is a problem worth solving (other than "a bit too much")
before everyone downthread jumped on trying to figure out how to solve
this out-of tree somehow.

So I thought I'd do a basic test of what it would mean to have this
in-tree. For every git version (every tag) since v1.0.0 I created a
parallel version of all our git-*.txt documentation, applied rot13 to
it, and dropped it in Documentation/po/rot13[1].

The end result after repack is:

    $ du -sh git-*/.git
    88M     git-orig/.git
    89M     git-po4a/.git

Now of course this isn't equivalent to the *.po files we're talking
about, which'll also contain the original English version, so let's
say that's at least 2x the size, or just assume 2.5x for extra
overhead because the translation is longer / uses higher Unicode
characters or whatever.

That's still only an extra 2.5MB per-language for 10 years of history,
and an extra 3.75MB to the checkout.

Even if we had 10 languages with a 100% translation (a stretch, since
the core translations in po/ only have 12 languages) the .git
directory would grow from the current 88MB to 113MB, and the checkout
from 33MB to 70MB (for comparison the existing po/ directory is
5.3MB).

Maybe I've just become desensitized to bigger repos but that seems
like nothing to me. For comparison the linux.git repository has a
1.9GB .git and an 800MB checkout.

There's always going to be some inconvenience cost to pay when cloning
doesn't Just Work. Right now grabbing any tar'd up git.git from any
service it's on will give you something you can fully build. This'll
no longer be the case for the po4a assets.

If there's a good reason to break that kind of stuff fine, but the
growth in repo/checkout size noted above seems tiny to me compared to
disks & hardware these days.

1. rm -rfv Documentation/po; mkdir -p Documentation/po/rot13; for
version in $(git tag -l --contains v1.0.0 'v[0-9]*.[0-9]*.[0-9]'
--sort=version:refname); do for file in $(git ls-tree $version --
./Documentation/|awk '{print $4}'|grep '^Documentation/git-.*\.txt');
do git show $version:$file | perl -pe 'tr/A-Za-z/N-ZA-Mn-za-m/' >
${file/git-/po/rot13/git-}; done; git add Documentation/po && git
commit -m"Bump rot13 for $version"; done
