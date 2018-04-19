Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A701F404
	for <e@80x24.org>; Thu, 19 Apr 2018 19:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDSTIq (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 15:08:46 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:42713 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeDSTIq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 15:08:46 -0400
Received: by mail-ua0-f172.google.com with SMTP id o34so4156909uae.9
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YjuBQBVCbF+c2KnjYGyMVGHCEaBBvFa8bcbFasjD4v8=;
        b=lP063Zwn132v9dXYSK1DAE8/eo/g5PIHTeTjqF3QqRKFr9ZQx11b7tL4haPYF7q9LW
         MKqtdJK6j4Bdc3+awnNBqMjTZmnypV1TK43oKL0PiUglRWo7BZP42VkhWmXlJxEubjtz
         l3R1QEJ0oqpQfaEMB2WQLNhA+S4bsyAxrCHTWr6mBWqOtObYo+qd5m+8bMZjsY1dCdGH
         Q4dzoZbLN0Wuiw9HXdSbrRQJCEA+O7lYTm/N0y11OMV0jW3ctpbMKVbK6W1+JvBEoe8B
         /UCcD/AHCnSuSCVCuPXCrwFLjTiPSkLuEWvFZK4SWcLCJNYRsO1TDYdqeQk4plgbnh7d
         ojhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YjuBQBVCbF+c2KnjYGyMVGHCEaBBvFa8bcbFasjD4v8=;
        b=SO5+bpEpRS5uOhDWNzbhzU2AMXmprBUN8eVfOYTugA4xMpeJHeVqah3n0zalTx4FKG
         fY+vgZR/NGP0GjIaQ5xk5NoAgjmZcJPkL02yrTH4YbZAvx4CEi9gNFBJ2cFfE1Du1UuU
         WBjx51UCuS20mbKhEybfUS4wZNav5hdc1c10uF25XYC1bX+QVhd/jyrdBSBWpP3ONS5M
         QxSv6lWGFYD2FXFrdHHcSyH35hnL9P2cKFNjs7VbJgeJKCBPzIy9hc3mFKRiOl08mK5W
         ZLWh+RJeTOXzzAbGgq2v1oQdX0vDvyVpiZeIqMVOksVy+3ZDMyGh1OgC58P9oCnLR+Ob
         W1Yw==
X-Gm-Message-State: ALQs6tDPsSqIgAmYJVmNhYSvzfYEHRXASF7Pq1YcgoEV4gbcCI4CvyZE
        slmPuyMrhC3E+Y6mi8vn+ohht4UqUaf7577idpQ=
X-Google-Smtp-Source: AIpwx49FwW8pWYijU3z6pG+EHFcr7a/UUZzvALiGxrzuFxMFiZkJL2PIEluC2J6wGD3Paaxg0OaQ2SmU7pfRJ5ZtIaE=
X-Received: by 10.176.91.137 with SMTP id y9mr1196324uae.48.1524164925255;
 Thu, 19 Apr 2018 12:08:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Thu, 19 Apr 2018 12:08:44 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804181421590.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180318012618.32691-1-szeder.dev@gmail.com> <20180416224113.16993-1-szeder.dev@gmail.com>
 <20180416224113.16993-2-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1804181421590.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 19 Apr 2018 21:08:44 +0200
Message-ID: <CAM0VKjmJTBxBke7YNHGeqiUyqM5drqjs7ceuv19uhMqOPt5jiQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues
 with quoted pathnames
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Manlio Perillo <manlio.perillo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 2:31 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I suspect that the culprit is once again Cygwin's trick where illegal
> characters are mapped into a private Unicode page. Cygwin (and therefore
> MSYS2 runtime, and therefore the Bash used to run the test script) can use
> those filenames all right, but Git cannot.
>
> So even testing whether you could write an illegal file name via shell
> script is *not* enough to determine whether the file system supports funny
> characters.

I followed suit of all existing FUNNYNAMES checks:

  $ git grep -B3 'test_set_prereq FUNNYNAMES' master t/
  master:t/t3600-rm.sh-if test_have_prereq !MINGW && touch -- 'tab
   embedded' 'newline
  master:t/t3600-rm.sh-embedded' 2>/dev/null
  master:t/t3600-rm.sh-then
  master:t/t3600-rm.sh:   test_set_prereq FUNNYNAMES
  --
  master:t/t4135-apply-weird-filenames.sh-        if test_have_prereq !MINGW &&
  master:t/t4135-apply-weird-filenames.sh-                touch --
"tab   embedded.txt" '\''"quoteembedded".txt'\''
  master:t/t4135-apply-weird-filenames.sh-        then
  master:t/t4135-apply-weird-filenames.sh:
test_set_prereq FUNNYNAMES
  --
  master:t/t9903-bash-prompt.sh-
  master:t/t9903-bash-prompt.sh-if test_have_prereq !MINGW && mkdir
"$repo_with_newline" 2>/dev/null
  master:t/t9903-bash-prompt.sh-then
  master:t/t9903-bash-prompt.sh:  test_set_prereq FUNNYNAMES

How am I supposed to check this, then?


> As far as I can tell from a *really* cursory glance, this is the only
> affected test case. Apparently your prereq catches, somehow, on Windows:
>
> 2018-04-18T11:12:43.0459702Z     Your filesystem does not allow \ and " in filenames.
> 2018-04-18T11:12:43.0459823Z     skipped: complete files - C-style escapes in ls-files output (missing FUNNYNAMES_BS_DQ)
