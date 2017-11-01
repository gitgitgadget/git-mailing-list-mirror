Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC4E202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbdKAPuD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 11:50:03 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:48661 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754560AbdKAPuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 11:50:02 -0400
Received: by mail-ua0-f180.google.com with SMTP id z4so1849776uaz.5
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MsB0Ls8C5OcQquADwHubStWNrJpQS9uvpyfKL1v1T9Y=;
        b=ou0OHFtVtoynle227VWv+66np5/i/zDaPr59QMaLs4Y5v9jJZEsE1nxo5ZDTFpJlQN
         GcY/KPR7RjEaE2NFa6ePl8unGJqnsOLI6WrlwfnqHy1VmKrdajMu2w5gXa1fCJtUvOSH
         GobIFRQ9U1/ZnOrhMpUF7kHJFIhtgKlzvxf2jsZU1jC1q96vyMvv1e3kmAx6WBEoKCKq
         mMnH8JqeZkBiaJjf8VUh08cDKuRL23dv7FXaovWEGcZ8dYBH7nmNO0BKP+W6oUMirvH6
         Ubb/JSJn4BYxlXwWAMf7GbQ8C87WSwbhmIBascMw6ybfoEuVjN0wt+X0hsEOAB6/528t
         jg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MsB0Ls8C5OcQquADwHubStWNrJpQS9uvpyfKL1v1T9Y=;
        b=hp6zDE95Ei2MeP/xVWUncwwX7DDlFUb6TcCZG9iBjiUm5UrAmJS75Gmm2aMwZs5b5G
         hB+/4mnJFJ1Qj6hPWhU6/zqGIsnUpt6LjIqn1AO+L62HszyV/wxWDaDTZDTSg1YGnP7Q
         8LsDwqDVUehYF6RO/dHUFQFVEEO3F7ekYI1+kEcDu2GwAO7a27DbzuC+vJTDGFwgPzoN
         EBQcwR1F8cwexY3/moMrgXAIsGuBcOtPvtDW7RURwmmWqYv5pVo1PXE779b0eUMywKq7
         Ijhv2xOmxrS0n7LZpeVgHheD/XlzfWZfZGjco5gDpjEsNUoTodi/f+Afn80iqIQRJp6y
         LCjQ==
X-Gm-Message-State: AMCzsaW/NV62OtUJ5p/P68NHg0HdntIzNnDMgtsSBNvEfPDMbmFUNE7u
        y6t0Hzi2jvRltFL7y6CL8fyO+rdeWJmBdU2CzpWXjg==
X-Google-Smtp-Source: ABhQp+RKnFTf5rhQXG+Sfamm8RtF2eH4gtxocqv9PCd+aSIwCcu0gKMUpCZW+5zo+OZSGRPm9gR+lgxu3kWbqGl8LuQ=
X-Received: by 10.176.3.46 with SMTP id 43mr220661uat.55.1509551401448; Wed,
 01 Nov 2017 08:50:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Wed, 1 Nov 2017 08:50:00 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Nov 2017 08:50:00 -0700
Message-ID: <CABPp-BF5Aitu05X83Lbm+8rWKojOnNNec_4bf5PRy+hKZGPPHw@mail.gmail.com>
Subject: Contribution licensing question(s)
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My employer has a new-ish open-source-contribution process, and is
curious about some licensing question(s) before I submit a few patch
series.

Background: git's README.md file points out that some parts of git are
under a license other than GPLv2 (while still GPLv2-compatible),
though it doesn't state which one(s) or what a contributor might want
to do if they want to grant permission under one of those more
permissive license(s). Also, I seem to recall that years ago there
were requests to make code available under a slightly more permissive
license to allow re-usage in jgit and perhaps other projects, though I
can't find any trace of this in the codebase.  git's COPYING file has
wording suggesting how to make a license transition (to GPLv3) easier,
but only considers completely new files as opposed to (significant)
modifications to existing files.

I'm not sure whether my specific git contributions would matter to
jgit (which we also use internally, both directly and indirectly), but
generally, is contributing under a more permissive GPLv2-compatible
license to permit re-usage in other projects like jgit (or for easing
future license switches) still relevant?  If so, which license(s) have
folks gravitated towards for these contributions, and how would one
mark their submitted patches?

Thanks,
Elijah
