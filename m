Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F50A1F45F
	for <e@80x24.org>; Mon,  6 May 2019 22:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEFW2t (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 18:28:49 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56349 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEFW2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 18:28:49 -0400
Received: by mail-qk1-f202.google.com with SMTP id t5so15928557qkt.23
        for <git@vger.kernel.org>; Mon, 06 May 2019 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c9psTsrfYzedOKjo1YK0IqHAi2VdXIwgZuWD1lb97gs=;
        b=HU9UQwiqDQiMnF2sH8JgPwUNNQeVDxnBOo5OQkHCTmNdII+MQwWo1xmfDUBM4kqj9Q
         b3Y1QIxvvvqDTUmeAMY+s/lFO4SlImQtFUVNyqfExqWrCkpvWRT3JhiqzuLcAWH7q7lQ
         VAWxWvoRbYMCAf92jDNJgqmkfxAR/tAmyc1I7Ti0lXvkOMBFn6l/0OVg4e6Ozh3fpnnR
         gtY4toQ7AWzZ/sqA3FMvKX+Q8tx6ie91v6PLcCoonOGDs2Kt6li4dgGdDAgGn3FOxgkX
         N4XVPbX1VoPCsvFpl3LDF65NiARDPsSCfQ5bWkau8NauQ1iFwVoGYpDpYxB6djEMqHKZ
         eKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9psTsrfYzedOKjo1YK0IqHAi2VdXIwgZuWD1lb97gs=;
        b=Pgxqsg+tjWuVDJTrKxKl2DC3ilZxCMKMaF4cwR9UWVeuwP8KPkxQjcSRLYcQcSMohv
         t6PDvJvYhWucl5A+34UesVwr2lnnohXGWNe2UaaUNVwwknUfvNOY4PwCnYKv8EbmsDMi
         YKJ1AcRxzu+qTFzQjgCR8vXYkJmnTBQFpp1fyXdv0HrlFjGGe1RmN/9NJ9kodKLU4OIm
         /PtrFI2AyZ+TB0H47zZXXLrZKpzBJsrtvYXiqw7SPnkjJFOWXHczGk0LHm12HHmhXNW4
         gMfYr4slJ5UIWtFWMwdZd9J/rJaOZkdOsWyMAkpqVDqYKi9WFH8/dGCWM18v1fRo0Gn9
         +7Qw==
X-Gm-Message-State: APjAAAX3EKZkmDSl1D0XPukmHGGRy11BoMDeGAgas6rYfUUCHtNREkOD
        VQYbqiEZMZdMdy54R3BPIE+xCDXn4/lYOEGRk41v
X-Google-Smtp-Source: APXvYqzf0vC8f+tCpHRl8/jfbyxVC35UKD5B/M885g1MwUjtIM8ph3DpAjyT9SCAQhIv+gRuWBIOkZn/UdVAC0PAfgBF
X-Received: by 2002:ac8:930:: with SMTP id t45mr6981114qth.357.1557181728184;
 Mon, 06 May 2019 15:28:48 -0700 (PDT)
Date:   Mon,  6 May 2019 15:28:44 -0700
In-Reply-To: <20190423193410.101803-1-emilyshaffer@google.com>
Message-Id: <20190506222844.261788-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190423193410.101803-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [PATCH v4] documentation: add tutorial for first contribution
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for not looking at this sooner. 

Firstly, I'm not sure if this file should be named without the ".txt",
like SubmittingPatches.

As for my other comments below, the Makefile comment below is the only
one I feel strongly about; feel free to disagree with the rest (which I
think are subjective).

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 26a2342bea..fddc3c3c95 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -74,6 +74,7 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
>  SP_ARTICLES += $(API_DOCS)
>  
>  TECH_DOCS += SubmittingPatches
> +TECH_DOCS += MyFirstContribution

Any reason not to keep this alphabetized?

> +=== Pull the Git codebase
> +
> +Git is mirrored in a number of locations. https://git-scm.com/downloads
> +suggests one of the best places to clone from is GitHub.
> +
> +----
> +$ git clone https://github.com/git/git git
> +----

I would rename the header to "Clone the Git repository" instead, since
"pull" has a specific meaning. Also, I think that "one of the best
places" is unnecessary (I would just say "Clone the Git repository from
one of its many mirrors, e.g.:"), but perhaps you want to leave it in
there to maintain the informal tone.

> +We'll also need to add the extern declaration of psuh; open up `builtin.h`,
> +find the declaration for `cmd_push`, and add a new line for `psuh` immediately
> +before it, in order to keep the declarations sorted:
> +
> +----
> +extern int cmd_psuh(int argc, const char **argv, const char *prefix);
> +----

I was going to say to not include the "extern", but I see that builtin.h
has them already, so it's probably better to leave it there for
consistency.

> +The list of commands lives in `git.c`. We can register a new command by adding
> +a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
> +with the command name, a function pointer to the command implementation, and a
> +setup option flag. For now, let's keep cheating off of `push`. Find the line
> +where `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing
> +the new line in alphabetical order.

For an international audience, it might be better to replace "cheating
off" with its literal meaning. It took me a while to understand that
"cheating off" was meant to evoke a so-called cheat sheet.

> +Go ahead and inspect your new commit with `git show`. "psuh:" indicates you
> +have modified mainly the `psuh` command. The subject line gives readers an idea
> +of what you've changed. The sign-off line (`-s`) indicates that you agree to
> +the Developer's Certificate of Origin 1.1 (see the
> +`Documentation/SubmittingPatches` +++[[dco]]+++ header). If you wish to add some
> +context to your change, go ahead with `git commit --amend`.

I think the last sentence is confusing - didn't we already add the
context? (And if it's meant more along the lines of "if you want to
change your commit message for whatever reason, use --amend", I don't
think that's necessary here, since we are assuming that the user knows
how to use Git.)

> +=== Implementation
> +
> +It's probably useful to do at least something besides printing out a string.
> +Let's start by having a look at everything we get.
> +
> +Modify your `cmd_psuh` implementation to dump the args you're passed:
> +
> +----
> +	int i;
> +
> +	...
> +
> +	printf(Q_("Your args (there is %d):\n",
> +		  "Your args (there are %d):\n",
> +		  argc),
> +	       argc);
> +	for (i = 0; i < argc; i++) {
> +		printf("%d: %s\n", i, argv[i]);
> +	}
> +	printf(_("Your current working directory:\n<top-level>%s%s\n"),
> +	       prefix ? "/" : "", prefix ? prefix : "");

Follow the Git style by not using braces around the single-line `for`
block.

> +Still, it'd be nice to know what the user's working context is like. Let's see
> +if we can print the name of the user's current branch. We can cheat off of the
> +`git status` implementation; the printer is located in `wt-status.c` and we can
> +see that the branch is held in a `struct wt_status`.

Same comment about "cheat off" as previously.

> +----
> +$ git send-email --to=target@example.com
> +----

Hmm...don't you need to specify a directory?

> +You will also need to go and find the Message-Id of your previous cover letter.
> +You can either note it when you send the first series, from the output of `git
> +send-email`, or you can look it up on the
> +https://public-inbox.org/git[mailing list]. Find your cover letter in the
> +archives, click on it, then click "permalink" or "raw" to reveal the Message-Id
> +header. It should match:
> +
> +----
> +Message-Id: <foo.12345.author@example.com>
> +----
> +
> +Your Message-Id is `<foo.12345.author@example.com>`. This example will be used
> +below as well; make sure to replace it with the correct Message-Id for your
> +**previous cover letter** - that is, if you're sending v2, use the Message-Id
> +from v1; if you're sending v3, use the Message-Id from v2.

I think it's better to describe the message ID as without the angle
brackets. Reading the RFC (https://tools.ietf.org/html/rfc2392), the
message-id doesn't have them.

[snip]

> +----
> +$ git send-email --to=target@example.com
> +		 --in-reply-to=<foo.12345.author@example.com>
> +----

The angle brackets can be omitted. Also, directory (or glob expression
in this case)?

> +=== Bonus Chapter: One-Patch Changes

This is not truly a bonus - the mailing list prefers this if the patch
set contains only one patch.

> +In some cases, your very small change may consist of only one patch. When that
> +happens, you only need to send one email. Your commit message should already be
> +meaningful and explain the at a high level the purpose (what is happening and
> +why) of your patch, but if you need to supply even more context, you can do so
> +below the `---` in your patch. Take the example below, generated with
> +`git format-patch` on a single commit:

It's not clear to me how `git format-patch` can generate the extra
paragraph below. The user would either have to include "---" in the
commit message (in which case there would be an extra "---" below the
extra paragraph, which is perfectly safe) or edit the email *after*
`git-format-patch` has generated the email.

> +----
> +From 1345bbb3f7ac74abde040c12e737204689a72723 Mon Sep 17 00:00:00 2001
> +From: A U Thor <author@example.com>
> +Date: Thu, 18 Apr 2019 15:11:02 -0700
> +Subject: [PATCH] README: change the grammar
> +
> +I think it looks better this way. This part of the commit message will
> +end up in the commit-log.
> +
> +Signed-off-by: A U Thor <author@example.com>
> +---
> +Let's have a wild discussion about grammar on the mailing list. This
> +part of my email will never end up in the commit log. Here is where I
> +can add additional context to the mailing list about my intent, outside
> +of the context of the commit log.
> +
> + README.md | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/README.md b/README.md
> +index 88f126184c..38da593a60 100644

[snip]

There's also the issue of titles having Capital Initials raised in
another review [1]. I think it's better to use sentence case, like in
SubmittingPatches.

[1] https://public-inbox.org/git/CABURp0rE23SCxB4VD0-kVWp6OfS7-4O6biyD7zMqSUQvR_RZxg@mail.gmail.com/

Overall, thanks for writing this. I think it's a good overview of what a
contributor should do when they write a set of patches for inclusion in
Git.

I had a meta-concern about the length of this document, but I think most
(if not all) of the information contained herein is useful, so I think
that the length is fine.

The other meta-concern is maintaining the informal tone when we update
this document (for example, when we add features like range-diff which
can be used when sending v2 - well, somebody can add information about
that to this document once it has been merged); but I don't think that
is a concern in practice (either we keep the tone or there is a slight
tone mismatch, and I don't think that either is a big deal).
