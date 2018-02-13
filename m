Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF991F576
	for <e@80x24.org>; Tue, 13 Feb 2018 11:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934409AbeBMLTX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 06:19:23 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38678 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934226AbeBMLTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 06:19:22 -0500
Received: by mail-pl0-f66.google.com with SMTP id m19so1582834pls.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 03:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tKfZBdXlQTiEbcb7DqbVBz56gZ2nXmoD0Cuh4gQFlPU=;
        b=iGZ/7dF09mxUWKr+rc1kwG6CqQkDnUy2tvzpCvjoRPqYxJSs2P1DjCgnwiGlpmW/vH
         oW2tidMosVzyRzNn8cC3XA2W708FFDnQNcnX41z0JkkkxiCnqSTdySHOi50P9w1kkgZ/
         f89tFnita9Jd3Hij8L97mTKcp0i4jYnFd/QzNJOfwHfr1rC3Zyfrl3l1quVvqvjj+B9F
         c5kWXnY18OHJWglIAnr1EGyJf0Ln2kE9wOEO+c1qdFs6prE7p0FaYl9zI25PnClT9xuY
         KK7MrCgTdSzhMQA03LvRUHMquRQsiymAKQn5IAWZGRpIbAGCVJpzTjuYIxY789pPxCmb
         ohMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tKfZBdXlQTiEbcb7DqbVBz56gZ2nXmoD0Cuh4gQFlPU=;
        b=UxawE4nej3MlDLCOltDFKdQUS3p3y/cH6exJaZQh24TrwyjvRdZ8FDjhahT2/GMj39
         EmMt8oQIIYcStKPJVL1wGkjWFca0QNqJsDhfu1E60ApbEK9Cy/ze72Ec1dCscLwBVbZc
         83YphTXbXyUUH1bK26UMMJiUGZbYHlvhIspg+g9S1qf8xArpnoGoI28OU4VbCBoFauKg
         6cqy9e6+ktX7X17Y7pW5ZdVFzLC4yIt3gGns836y6f5ELbKdOn61u48dESIZED+iDHuG
         UuXkPERjh1AHDmoZqGLfJDnQNEGU24goVYPDc5soU7dwdS6KHrY1HMlEckWTSVuIgTJo
         3KEg==
X-Gm-Message-State: APf1xPC3fJLitQ1Na54ubph3VQcEVbKMCKgxCCbT+GXGgBYPUNDrRPsu
        sdbHpzMcuEi9ga0Umt2jNPScunRUq16ta0+cUphXcqjO
X-Google-Smtp-Source: AH8x224BDytowmJqe8XOUv2MVxOs4YSeLkFYN8m4AyumDeuV/ZHpt8PopcJwXcldLSnE5oEb4gUzCOmRZYL4ly5PeMw=
X-Received: by 2002:a17:902:6b05:: with SMTP id o5-v6mr798687plk.179.1518520762127;
 Tue, 13 Feb 2018 03:19:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.163.48 with HTTP; Tue, 13 Feb 2018 03:19:21 -0800 (PST)
In-Reply-To: <CACsJy8BPy_D4pg3n+c6eL_W=9eqeA++V4TOhp3PgOo_++YGhVw@mail.gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
 <ad9a12af60cdc6ff747337c4116fe41860f82701.1518365675.git.martin.agren@gmail.com>
 <CACsJy8BPy_D4pg3n+c6eL_W=9eqeA++V4TOhp3PgOo_++YGhVw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Feb 2018 12:19:21 +0100
Message-ID: <CAN0heSoDA1bAupV1ZNAF_2K6Op9tM6QGJFCC8RT8WkgQO_EQZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] config: respect `pager.config` in list/get-mode only
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 February 2018 at 11:25, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Feb 11, 2018 at 11:40 PM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>> Similar to de121ffe5 (tag: respect `pager.tag` in list-mode only,
>> 2017-08-02), use the DELAY_PAGER_CONFIG-mechanism to only respect
>> `pager.config` when we are listing or "get"ing config.
>>
>> Some getters give at most one line of output, but it is much easier to
>> document and understand that we page all of --get[-*] and --list, than
>> to divide the (current and future) getters into "pages" and "doesn't".
>
> I realize modern pagers like 'less' can automatically exit if the
> output is less than a screen. But are we sure it's true for all
> pagers? It would be annoying to have a pager waiting for me to exit
> when I only want to check one config item out (which prints one line).
> Trading one-time convenience at reading the manual with constantly
> pressing 'q' does not seem justified.

Well, there was one recent instance of a misconfigured LESS causing the
pager not to quit automatically [1]. Your "Trading"-sentence does argue
nicely for rethinking my approach here.

A tweaked behavior could be documented as something like:

    `pager.config` is only respected when listing configuration, i.e.,
    when using `--list` or any of the `--get-*` which may return
    multiple results.

Maybe it doesn't look to complicated after all. I'd rather not give any
ideas about how we only page if there *are* more than one line of
result, i.e., that we'd examine the result before turning on the pager.
I think I've avoided that misconception here.

Thanks
Martin

[1] https://public-inbox.org/git/2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvi=
o.com/
