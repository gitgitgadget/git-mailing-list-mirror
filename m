Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97EC1F404
	for <e@80x24.org>; Fri,  5 Jan 2018 05:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeAEF2c (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 00:28:32 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:37715 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeAEF2b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 00:28:31 -0500
Received: by mail-wr0-f181.google.com with SMTP id f8so3408596wre.4
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 21:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lLfIFnxAeLY/74f+SBWKtKgttUY3ZHQiYbwBAsYWQic=;
        b=oReongvKbM+pIp97Jd1wKogI/G10bWeI/Ld4nuca4XPNVi++Rx/ethbE5NEgUcg0cO
         NePxUQbjmgBxG87up1ul65d7zCTZ1LaZ576HfS63rVcOh5vLKeozhsK8T7LoImXnVLRj
         AwKR+v/d6Az+KWyAGLL1UEukXLlKol47ZOVEpQOhZ2KP9Tc4YTTMV9fQ3ruVK779ycr9
         FVHQJQKbRpUPd1/GRWqvfiEmLn532lEqQN2ITYCvM2TCIVV87h+5Gi22XI6xH9RSYTMj
         UmMXVygwDJE/fTITcgIgEGoB6aVJYQL9z1M0Hdy0awNgrN1cJ0glnbjMgq+IkmPMcnsS
         5M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lLfIFnxAeLY/74f+SBWKtKgttUY3ZHQiYbwBAsYWQic=;
        b=OH3I1qxH0GNS0J5ElkGPvMOqO2M2NK6fXeZxcL9Cx3Dkh4yF2i9fZ9JOojn9IzPJmo
         Pqq4kjTWqFkBoJDHtWJKPZl2BcSTUnqjozeuYkTcchrFb6x0vUe1mJMouaFNdOM4MG6Z
         Md1oQNPooZ7qaq0Bengca2Y/ijVrzU3avxKrA0NK8/vRzGw96lkN+uExeWXfd4GNN2JP
         mOUqTzi632egUY6NSjkWabdWAkaACzGezin17JIWarBgTgfHTrDbm/Lm8rkDFtcq6Bkf
         XwjgwW9fMeQj2MH+AaIFSbWbCvGKbPTlARZ617AOAJgxlNE3jDj9X7VnByy1Yb/RBRO5
         YV2Q==
X-Gm-Message-State: AKGB3mJgMncWbUh1Jq2GFuKntZoMUfeVtjI/4XlsTuyYJBzJqo0cVWFN
        8pcuAPEWqsXq20jG7jb9QKdVWK3K2YuiEquFIes=
X-Google-Smtp-Source: ACJfBosfv5bd80pOjqZ4zIgetgOGqUe0m5grXx85yH3bg6tmzsSdgO2nJDrT/wGePQeZ9Eq8AoXwIyp9K/k1ZsnCPfI=
X-Received: by 10.223.163.201 with SMTP id m9mr1671974wrb.169.1515130110686;
 Thu, 04 Jan 2018 21:28:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.193 with HTTP; Thu, 4 Jan 2018 21:28:29 -0800 (PST)
In-Reply-To: <CAELBRWK6Y=-7WBwai16dBKd8OLxdXWOiZMALVJXrP9ak8gF-LA@mail.gmail.com>
References: <CAELBRWKYZK2tVhGZSExXRXrRB94jFN-4N3d=iKARzEsqLu7k1g@mail.gmail.com>
 <87fu7nc9a2.fsf@evledraar.gmail.com> <CAN0heSrZ4dEFqNX69PgtGCERJKabokz88v-vnNZkUBXfK118mg@mail.gmail.com>
 <CAELBRWK6Y=-7WBwai16dBKd8OLxdXWOiZMALVJXrP9ak8gF-LA@mail.gmail.com>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Fri, 5 Jan 2018 14:28:29 +0900
Message-ID: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jan 5, 2018 at 11:45 AM, Yasushi SHOJI <yasushi.shoji@gmail.com> wrote:
> So that I can make a test case.

OK, here is the step to reproduce on git.git

$ git bisect start
$ git bisect bad v2.16.0-rc0
$ git bisect good 0433d533f13671f4313c31e34707f0f5281a18e0
$ git bisect good
$ git bisect bad
$ git bisect bad
$ git bisect skip #=> works with error
$ git bisect good #=> Segmentation fault
$ git bisect skip #=> Segmentation fault

The following is with full outputs, just in case you need it.

$ git describe
v2.16.0-rc0

$ git bisect start
$ git bisect bad v2.16.0-rc0

$ git bisect good 0433d533f13671f4313c31e34707f0f5281a18e0
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[c87b653c46c4455561642b14efc8920a0b3e44b9] builtin/describe.c: rename
`oid` to avoid variable shadowing

$ git bisect good
Bisecting: 2 revisions left to test after this (roughly 1 step)
[4dbc59a4cce418ff8428a9d2ecd67c34ca50db56] builtin/describe.c: factor
out describe_commit

$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[cdaed0cf023a47cae327671fae11c10d88100ee7] builtin/describe.c: print
debug statements earlier

$ git bisect bad
cdaed0cf023a47cae327671fae11c10d88100ee7 is the first bad commit
commit cdaed0cf023a47cae327671fae11c10d88100ee7
Author: Stefan Beller <sbeller@google.com>
Date:   Wed Nov 15 18:00:37 2017 -0800

    builtin/describe.c: print debug statements earlier

    When debugging, print the received argument at the start of the
    function instead of in the middle. This ensures that the received
    argument is printed in all code paths, and also allows a subsequent
    refactoring to not need to move the "arg" parameter.

    Signed-off-by: Stefan Beller <sbeller@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 beb1f2c4d9ee7584e54e0489c7e85e348cbf9fc7
b9882eea0772e3025690d3513cea5a940567668e M builtin

$ git bisect skip
There are only 'skip'ped commits left to test.
The first bad commit could be any of:
cdaed0cf023a47cae327671fae11c10d88100ee7
We cannot bisect more!

$ git bisect good
Segmentation fault

$ git bisect skip
Segmentation fault
-- 
               yashi
