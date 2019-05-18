Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC6A1F461
	for <e@80x24.org>; Sat, 18 May 2019 05:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfERFkk (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 01:40:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42861 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERFkj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 01:40:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id z11so5968469vsq.9
        for <git@vger.kernel.org>; Fri, 17 May 2019 22:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+JQL6WXlD6YqI8ArgMoPf5l4nUqzrApbmGK53Pv+w4=;
        b=qUX7+eM8G0itW4pDgv/gBZGhStJlgruA6tk5giina2YT2f92ysjtIkty4QyjdD/xZG
         8sVRtwC0sQ4CLjc/eWzJUQvrqfC04/ySh4jJWkxIOCwQvCUz9UyQeypeYr2lCgM+RrIo
         ch0+isB6i4tkl/x2sd0+Q6jLlZNMuUoh/j1UC9dTRghRpLlWFfxSPW9vQQL3zNEHIlDR
         3EZmS1/QC40afSCQQ03//gdMUh7jduiL2PpLyyvdHxbwQneqdoWjI4mtX2XCS1qD9R1l
         aEcIhjSxw4BrZmBKx8B8DfQj+iM2mT/wJZ40s+/8IPhxuSxuW7ESAwmmRjDcle2/nVii
         1HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+JQL6WXlD6YqI8ArgMoPf5l4nUqzrApbmGK53Pv+w4=;
        b=uShgF3u+1crkjJ+H7J12luC1+a56RKKuJcfwse+qyFY4Pj3aZNB9vcHlhKjBJkA+fq
         H5B8vZEyEnmV7y2B3Q+3O4ZtzKzZQuFQBOdYvE4ViTukmzRQPuO9KOqD6td2o8VaLTby
         /0iOM6CC3LKMnkDRtt7Bl2/Ql7HwW7POgCzRf6jif9jLttB3HBZeV4OESPtarf1sZIaC
         UYQ093fTzmBAwzuge3k2MM6v0iBDEPcx6WpICbj/n88ssxYqa2MCJIV7kWXp3+0NbjOm
         jB3xCv5kThs83CqZrl4LWkh8Ki8ZTGVioUvKJx0+hrUeHd58UVkCATFxZWjhOFAojgnW
         HPCg==
X-Gm-Message-State: APjAAAWLbNJH7jEft3xarC1RBz706Lzcrm5KwcnHORUjXe5nS8K2sfIn
        dW/xwNIdhUIzM3mZg+OYN3zwI9xHIP+22WGORjs=
X-Google-Smtp-Source: APXvYqwBlxUeHN/OCw3n+gSpnZ5hG30PMmuF5+olO3jhs/z8UuoEj4OyrMB3CYQjKE39I0b5ar5lSxVH9UHRcP7Joq4=
X-Received: by 2002:a67:6f07:: with SMTP id k7mr28730272vsc.117.1558158038832;
 Fri, 17 May 2019 22:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190517204826.45308-1-emilyshaffer@google.com>
In-Reply-To: <20190517204826.45308-1-emilyshaffer@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 May 2019 22:40:27 -0700
Message-ID: <CABPp-BHZkQG+pr4MmVGahHDR56grqvRsYNxZ=uShK70APzj9LA@mail.gmail.com>
Subject: Re: [PATCH] doc: hint about GIT_DEBUGGER
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Fri, May 17, 2019 at 3:40 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> We check for a handy environment variable GIT_DEBUGGER when running via
> bin-wrappers/, but this feature is undocumented. Add a hint to how to
> use it into the CodingGuidelines (which is where other useful
> environment settings like DEVELOPER are documented).
>
> It looks like you can use GIT_DEBUGGER to pick gdb by default, or you
> can hand it your own debugger if you like to use something else (or if
> you want custom flags for gdb). Hopefully document that intent within
> CodingGuidelines.

Thanks for working on this.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Maybe this isn't the right place for this patch. But right now git grep
> reveals that GIT_DEBUGGER is completely undocumented.

Does 'git log --grep=GIT_DEBUGGER' count?  ;-)

> Alternatively, it might make sense to only add a short blurb about using
> GIT_DEBUGGER flag to CodingGuidelines and then documenting how to use it
> inside of wrap-for-bin.sh.
>
>  Documentation/CodingGuidelines | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 32210a4386..e17cd75b50 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -412,6 +412,11 @@ For C programs:
>     must be declared with "extern" in header files. However, function
>     declarations should not use "extern", as that is already the default.
>
> + - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
> +   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
> +   run `GIT_DEBUGGER=debugger-binary some-args ./bin-wrappers/git foo` to

Missing some quotes around debugger-binary and some-args:
+   run `GIT_DEBUGGER="debugger-binary some-args" ./bin-wrappers/git foo` to

Also, one thing I always wonder about with command documentation like
this is whether people will understand that "debugger-binary",
"some-args", and "foo" are just placeholders rather than literal text
-- and that everything else is literal text and not meant to be
placeholders.  Does it make since to include a couple examples, or
perhaps modify the text somehow to avoid confusion between
placeholders and literals, or maybe just tell me I overthinking this?
(I've been bit by similar problems in other contexts, so I'm just
flagging it for you to consider).

Elijah
