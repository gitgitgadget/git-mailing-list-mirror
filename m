Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D3D1F576
	for <e@80x24.org>; Thu,  1 Feb 2018 11:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeBALFo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 06:05:44 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36855 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeBALFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 06:05:43 -0500
Received: by mail-wm0-f45.google.com with SMTP id f3so4864053wmc.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 03:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9UplkhlxPdM65c4MPXbw9oEZkgpAnk890ZcrFFFKgVc=;
        b=rlh54klqqtX1xIQDvGmaSpOculEYglwChkbXkfpT9Ldz6Uvbk1pNO+z7siSnXQynHL
         sxVYWr0UswDwFJ/E3ejIC2n57bJTMnZ5rHTf3hVM7pUSwEmTAL/3dRi1ZC3POQH+ER5G
         Ebh5CDIAthg4vKgkX4AdcgdUepNCjatQC1ndYMHDDaCF3/mopUfLjrUUwZ9YhftOGVZY
         I28GUHbrgJy34uVONn1XuVkq7yeB88UvW7WGknBQzzB/XotsEnbmqULWetMejgvq6duK
         2i6BFY8ar/wy2c58sAuijV89J8jlXdew9uxlOX7yQxpf7AzKUbYEnRxSKs3PKbljhz0u
         xeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9UplkhlxPdM65c4MPXbw9oEZkgpAnk890ZcrFFFKgVc=;
        b=OBWboVLtq/GDgIinKyfn0J/ugokO0YnCHPIBXNgqK0wSABrInGFKY0E+SOSp9sNc5C
         52f8pSIzbR6m3YeczhqKpbY0xBev4/HBmj8fltb7gaO835hKWxbAdtFvxjrqnpst9sJ0
         myjytCuFCNSqiFladjGw13XJL4QXNZHmtKSNSntDUMyStcr3lKhCEhU7qsH6Fic+DLGM
         AYyKNOsDbyh+QOl+QQbUyoh8PgM93NHBtXOJVSNOlaerMUH74BrdwGzuNa/O24/chpBG
         c3oGbW97ik1oK99bIl6NBKmSLU8GLOjm8UEGkouGz4JkcDvYJk0DcsOuSvQqIr+PUsoz
         4x2w==
X-Gm-Message-State: AKwxytdDuuUftTrZBlLmra+RYYDgQCTp0hd+TZiUwBNAstL3MiWnZblc
        rDJnelLoGTmlpxGIKEpQvI8=
X-Google-Smtp-Source: AH8x225mYIAQcMjvi/7aaK4aCD8ErxDb6PO/B9RnzBa2Ny0uGqZvPnUroY5JSo/ko2jdNagR5dRTjQ==
X-Received: by 10.80.145.27 with SMTP id e27mr61823624eda.217.1517483142211;
        Thu, 01 Feb 2018 03:05:42 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id v23sm10372418eda.92.2018.02.01.03.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 03:05:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 01 Feb 2018 12:05:40 +0100
Message-ID: <87mv0tm0l7.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 01 2018, Junio C. Hamano jotted:

> * ab/wildmatch-tests (2018-01-30) 10 commits
>  - wildmatch test: mark test as EXPENSIVE_ON_WINDOWS
>  - test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
>  - wildmatch test: create & test files on disk in addition to in-memory
>  - wildmatch test: perform all tests under all wildmatch() modes
>  - wildmatch test: use test_must_fail, not ! for test-wildmatch
>  - wildmatch test: remove dead fnmatch() test code
>  - wildmatch test: use a paranoia pattern from nul_match()
>  - wildmatch test: don't try to vertically align our output
>  - wildmatch test: use more standard shell style
>  - wildmatch test: indent with tabs, not spaces
>
>  More tests for wildmatch functions.
>
>  Expecting an update.
>  cf. <87vaga9mgf.fsf@evledraar.gmail.com>

The 2018-01-30 series is the update mentioned in
87vaga9mgf.fsf@evledraar.gmail.com. You probably noticed this / just
didn't adjust the note since you queued in in pu already, but just in
case: the known issues in it have been resolved, but hopefully Johannes
Schindelin can test it on Windows & report.

> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>  - update-index doc: note a fixed bug in the untracked cache
>  - dir.c: fix missing dir invalidation in untracked code
>  - dir.c: avoid stat() in valid_cached_dir()
>  - status: add a failing test showing a core.untrackedCache bug
>
>  Some bugs around "untracked cache" feature have been fixed.
>
>  Will merge to 'next'.

It must be Murphy's law or something, but even though the bug has been
there for years I just had some internal users again run into the bug
this fixes, so I'm building an internal v2.16.1 + custom patches (this
included).

> * ab/sha1dc-build (2017-12-12) 4 commits
>  . Makefile: use the sha1collisiondetection submodule by default
>  - sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
>  - Makefile: under "make dist", include the sha1collisiondetection submodule
>  - Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto
>
>  Push the submodule version of collision-detecting SHA-1 hash
>  implementation a bit harder on builders.
>
>  The earlier two may make sense, but leaning toward rejecting the last step.
>  cf. <xmqqk1xw6c24.fsf@gitster.mtv.corp.google.com>

This has been lingering for a long time. I think it makes sense just to
merge the first 3 down and then we can discuss 4/4 in another
submission. [12]/4 solve real bugs we have now, 3/4 is harmless to merge
down (and makes 4/4 smaller when we get around to discussing it again),
it's just 4/4 that's been stalling this.

Do you want to peel of 4/4 and just keep 1-3 should I submit another
version without 4/4?
