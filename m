Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9611F45F
	for <e@80x24.org>; Tue,  7 May 2019 19:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfEGT7q (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 15:59:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45385 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfEGT7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 15:59:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so9190315pfi.12
        for <git@vger.kernel.org>; Tue, 07 May 2019 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iB1S4V8eiZv0AqMyle7PtkEm9Q2yaluk0ksGTVYCOBo=;
        b=RK3b9dGDvzlwtWjT53vmnUgbJIgjWak11ciRmZxFpVFDH0gNNsctHY8SHWwQevFe0Q
         25m25c3BXkyii7oUGCvM0LnG/eXPat0XoXI1xEnWofwlzufdyaCr/TsNIPeOA8C2N/+u
         /3AOpYqi6T4AVEcUDsZAgAS0sJjPRyFpMNi/bbvdp/fTid0LPVuaCcm+AvNPt3lQ4Jd+
         esLaRmbXlPOnEUGLoDWJY6j9LNIbpz6dk8uuEIxupJUOrNUwOh96GJQ0oLgCfsUmAIXE
         uktrZh+uVL31/PVvn3LA6oUt8UHVHknj9H3ewq7bAiVhI/9fuZj25DOFwUQNu6bzFJor
         JzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iB1S4V8eiZv0AqMyle7PtkEm9Q2yaluk0ksGTVYCOBo=;
        b=D6rIO8tc0jGL3cF2m5RvlYfayCQ4Z0vKMCrBKfFZTgywMYQi9dnxMwTKTe3tWWhuVG
         tQ395c6lHGGSi4/4C2Su6UyilRFpy7POlsH6/xm/1lSOsg4ohEsoebnh5PcSuVS+7VUW
         dnAtPwqoRUppEOCLn86KINC+HFgtqx3bUbMbwBTKeEDg6+61rOs1ObcDSc+8mw3mweNR
         ieYDeMJ/i8tvkN/2FKM+7NcmlbsdbNv8VYdlSsFEQrQ8yxiAs8PE3qzp8ykHxYRXvyD5
         8nRG7PdCUpAEKMdDnXbzMB8RK5vx62SEVX4MJpfJrXDTwSCVMkyVijZJMxId+u5miPBt
         bfOQ==
X-Gm-Message-State: APjAAAV3F1x0qyjPPVFEgwextyIcIUswhvhjiuYAYII6/sbGYWAtXD5Z
        RTzw4vH8HrvhxMPph9M2K+Ev1Q==
X-Google-Smtp-Source: APXvYqwrc64l70dIsEGotShNwjwIsa/NyrOGo/VSXy7jr7S4QZkSHaRm69LXsi/fYmAZsy0sMyIigQ==
X-Received: by 2002:a62:43d1:: with SMTP id l78mr12943741pfi.124.1557259184322;
        Tue, 07 May 2019 12:59:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id i15sm19765412pfr.8.2019.05.07.12.59.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 12:59:43 -0700 (PDT)
Date:   Tue, 7 May 2019 12:59:38 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v4] documentation: add tutorial for first contribution
Message-ID: <20190507195938.GD220818@google.com>
References: <20190423193410.101803-1-emilyshaffer@google.com>
 <20190506222844.261788-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506222844.261788-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 03:28:44PM -0700, Jonathan Tan wrote:
> Sorry for not looking at this sooner. 
> 
> Firstly, I'm not sure if this file should be named without the ".txt",
> like SubmittingPatches.

I should mention that during this change's life as a GitGitGadget PR,
dscho performed a review in GitHub, which included a recommendation to
name this SubmittingPatches.txt. This obviates quite a bit of
boilerplate within the Makefile as there are rules for handling *.txt
documentation generation already. You can check out Johannes's review:
https://github.com/gitgitgadget/git/pull/177

I keep forgetting to add a Reviewed-by line to my commit. I'll do that
before pushing based on your comments, as well as Josh and Phil's.

> 
> As for my other comments below, the Makefile comment below is the only
> one I feel strongly about; feel free to disagree with the rest (which I
> think are subjective).
> 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 26a2342bea..fddc3c3c95 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -74,6 +74,7 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
> >  SP_ARTICLES += $(API_DOCS)
> >  
> >  TECH_DOCS += SubmittingPatches
> > +TECH_DOCS += MyFirstContribution
> 
> Any reason not to keep this alphabetized?

No reason, done.

> > +=== Pull the Git codebase
> > +
> > +Git is mirrored in a number of locations. https://git-scm.com/downloads
> > +suggests one of the best places to clone from is GitHub.
> > +
> > +----
> > +$ git clone https://github.com/git/git git
> > +----
> 
> I would rename the header to "Clone the Git repository" instead, since
> "pull" has a specific meaning. Also, I think that "one of the best
> places" is unnecessary (I would just say "Clone the Git repository from
> one of its many mirrors, e.g.:"), but perhaps you want to leave it in
> there to maintain the informal tone.

I've merged the language from both and added that the GH mirror at
git/git is official.

"Git is mirrored in a number of locations. Clone the repository from one
of them; https://git-scm.com/downloads suggests one of the best places
to clone from is the official mirror on GitHub."

> > +We'll also need to add the extern declaration of psuh; open up `builtin.h`,
> > +find the declaration for `cmd_push`, and add a new line for `psuh` immediately
> > +before it, in order to keep the declarations sorted:
> > +
> > +----
> > +extern int cmd_psuh(int argc, const char **argv, const char *prefix);
> > +----
> 
> I was going to say to not include the "extern", but I see that builtin.h
> has them already, so it's probably better to leave it there for
> consistency.
> 

This was brought up in an earlier review and there's also a review
pending to remove them, which seems to have turned into a discussion
about how to maintain a script to remove them :) I'm going to avoid
politics and also remove the extern here, because it looks like that's
the direction the codebase is heading anyway.

> > +The list of commands lives in `git.c`. We can register a new command by adding
> > +a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
> > +with the command name, a function pointer to the command implementation, and a
> > +setup option flag. For now, let's keep cheating off of `push`. Find the line
> > +where `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing
> > +the new line in alphabetical order.
> 
> For an international audience, it might be better to replace "cheating
> off" with its literal meaning. It took me a while to understand that
> "cheating off" was meant to evoke a so-called cheat sheet.

You're right; I leaned too far towards casual voice here and included a
colloquialism. I've modified this to "let's keep mimicking `push`" as I
feel it means the same thing, without the slang but with a similar tone.

I also considered "copying from `push`" but didn't want to indicate we
would be copy-pasting lines of code. If anybody's got a better
suggestion for a verb here I'm happy to hear it; "cheating from X" is a
phrase I'm trying to stop using anyways :)

> > +Go ahead and inspect your new commit with `git show`. "psuh:" indicates you
> > +have modified mainly the `psuh` command. The subject line gives readers an idea
> > +of what you've changed. The sign-off line (`-s`) indicates that you agree to
> > +the Developer's Certificate of Origin 1.1 (see the
> > +`Documentation/SubmittingPatches` +++[[dco]]+++ header). If you wish to add some
> > +context to your change, go ahead with `git commit --amend`.
> 
> I think the last sentence is confusing - didn't we already add the
> context? (And if it's meant more along the lines of "if you want to
> change your commit message for whatever reason, use --amend", I don't
> think that's necessary here, since we are assuming that the user knows
> how to use Git.)

I think you're right. Removed. This seems like a holdover from the first
iteration, where I provided oneline commit messages for each commit,
instead of good practice examples.

> > +=== Implementation
> > +
> > +It's probably useful to do at least something besides printing out a string.
> > +Let's start by having a look at everything we get.
> > +
> > +Modify your `cmd_psuh` implementation to dump the args you're passed:
> > +
> > +----
> > +	int i;
> > +
> > +	...
> > +
> > +	printf(Q_("Your args (there is %d):\n",
> > +		  "Your args (there are %d):\n",
> > +		  argc),
> > +	       argc);
> > +	for (i = 0; i < argc; i++) {
> > +		printf("%d: %s\n", i, argv[i]);
> > +	}
> > +	printf(_("Your current working directory:\n<top-level>%s%s\n"),
> > +	       prefix ? "/" : "", prefix ? prefix : "");
> 
> Follow the Git style by not using braces around the single-line `for`
> block.

Done.

> > +Still, it'd be nice to know what the user's working context is like. Let's see
> > +if we can print the name of the user's current branch. We can cheat off of the
> > +`git status` implementation; the printer is located in `wt-status.c` and we can
> > +see that the branch is held in a `struct wt_status`.
> 
> Same comment about "cheat off" as previously.

Done. Again used s/cheat off of/mimic.

> > +----
> > +$ git send-email --to=target@example.com
> > +----
> 
> Hmm...don't you need to specify a directory?

Fixed...

> > +You will also need to go and find the Message-Id of your previous cover letter.
> > +You can either note it when you send the first series, from the output of `git
> > +send-email`, or you can look it up on the
> > +https://public-inbox.org/git[mailing list]. Find your cover letter in the
> > +archives, click on it, then click "permalink" or "raw" to reveal the Message-Id
> > +header. It should match:
> > +
> > +----
> > +Message-Id: <foo.12345.author@example.com>
> > +----
> > +
> > +Your Message-Id is `<foo.12345.author@example.com>`. This example will be used
> > +below as well; make sure to replace it with the correct Message-Id for your
> > +**previous cover letter** - that is, if you're sending v2, use the Message-Id
> > +from v1; if you're sending v3, use the Message-Id from v2.
> 
> I think it's better to describe the message ID as without the angle
> brackets. Reading the RFC (https://tools.ietf.org/html/rfc2392), the
> message-id doesn't have them.
> 
> [snip]

Junio argued the opposite here:
https://public-inbox.org/git/xmqqr29vbpge.fsf@gitster-ct.c.googlers.com/
and it looks like the RFC (possibly poorly-worded) also indicates the
angle brackets are part of the Message-ID spec (the ID without the
brackets is a '"mid" URL'):

   A "cid" URL is converted to the corresponding Content-ID message
   header [MIME] by removing the "cid:" prefix, converting the % encoded
   character to their equivalent US-ASCII characters, and enclosing the
   remaining parts with an angle bracket pair, "<" and ">".

   ...

   A "mid" URL is converted to a Message-ID or Message-ID/Content-ID
   pair in a similar fashion.

So I'll leave this the way it is.

> 
> > +----
> > +$ git send-email --to=target@example.com
> > +		 --in-reply-to=<foo.12345.author@example.com>
> > +----
> 
> The angle brackets can be omitted. Also, directory (or glob expression
> in this case)?

See above re: angle brackets. I've added the argument "psuh/v2*" to
include the v2 patches.

> 
> > +=== Bonus Chapter: One-Patch Changes
> 
> This is not truly a bonus - the mailing list prefers this if the patch
> set contains only one patch.

In the context specifically of this tutorial, I sort of think it is -
since the tutorial doesn't send out a one-patch changeset, this seems
like an aside to me. That is, I feel like the flow of the tutorial says,
"First you do A, then B, then C (and by the way, if you're doing C', you
would do it like this)."

I also liked the phrasing as a bonus because it covers something that
GitGitGadget does not support, so it's "extra content" compared to the
analogous chapter on using GGG.

If you feel very strongly, I could change it, but for now I disagree.

> > +In some cases, your very small change may consist of only one patch. When that
> > +happens, you only need to send one email. Your commit message should already be
> > +meaningful and explain the at a high level the purpose (what is happening and
> > +why) of your patch, but if you need to supply even more context, you can do so
> > +below the `---` in your patch. Take the example below, generated with
> > +`git format-patch` on a single commit:
> 
> It's not clear to me how `git format-patch` can generate the extra
> paragraph below. The user would either have to include "---" in the
> commit message (in which case there would be an extra "---" below the
> extra paragraph, which is perfectly safe) or edit the email *after*
> `git-format-patch` has generated the email.
 
I will clarify the wording to indicate that I mean the user should edit
the patch after generating. Brevity got in the way of completeness here.
Thanks.

I've modified the sentence to include that there was a second step here:
"generated with `git format-patch` on a single commit, and then edited
to add the content between the `---` and the diffstat."

I've also added a sentence to the note in the commit at the end, "This
section was added after `git format-patch` was run, by editing the patch
file in a text editor."

> > +----
> > +From 1345bbb3f7ac74abde040c12e737204689a72723 Mon Sep 17 00:00:00 2001
> > +From: A U Thor <author@example.com>
> > +Date: Thu, 18 Apr 2019 15:11:02 -0700
> > +Subject: [PATCH] README: change the grammar
> > +
> > +I think it looks better this way. This part of the commit message will
> > +end up in the commit-log.
> > +
> > +Signed-off-by: A U Thor <author@example.com>
> > +---
> > +Let's have a wild discussion about grammar on the mailing list. This
> > +part of my email will never end up in the commit log. Here is where I
> > +can add additional context to the mailing list about my intent, outside
> > +of the context of the commit log.
> > +
> > + README.md | 2 +-
> > + 1 file changed, 1 insertion(+), 1 deletion(-)
> > +
> > +diff --git a/README.md b/README.md
> > +index 88f126184c..38da593a60 100644
> 
> [snip]
> 
> There's also the issue of titles having Capital Initials raised in
> another review [1]. I think it's better to use sentence case, like in
> SubmittingPatches.

Phil Hord pointed this out too. I've combed through the titles, and
caught one which missed a monospace formatting.

> 
> [1] https://public-inbox.org/git/CABURp0rE23SCxB4VD0-kVWp6OfS7-4O6biyD7zMqSUQvR_RZxg@mail.gmail.com/
> 
> Overall, thanks for writing this. I think it's a good overview of what a
> contributor should do when they write a set of patches for inclusion in
> Git.
> 
> I had a meta-concern about the length of this document, but I think most
> (if not all) of the information contained herein is useful, so I think
> that the length is fine.

Thanks. I wondered about that too, but mostly regarding review velocity.
I'm not sure that it makes sense to split this into parts, but I wonder
if it's worth it to add anchors to each chapter so that it'd be easier
to send a specific section to someone who had a question. For example,
in the standup last week, dscho suggested to vishal that they have a
look at this patch, and named a specific section. It'd be easier if
dscho could link something like
git-scm.org/docs/MyFirstContribution.html#adding-tests.

I've convinced myself that this is a good idea, so I'll add them before
I push v5.

> The other meta-concern is maintaining the informal tone when we update
> this document (for example, when we add features like range-diff which
> can be used when sending v2 - well, somebody can add information about
> that to this document once it has been merged); but I don't think that
> is a concern in practice (either we keep the tone or there is a slight
> tone mismatch, and I don't think that either is a big deal).

I see your concern. I'm not sure whether it would really be a big deal
as long as folks who are editing the document remember that this is a
tutorial, not a reference document. That is, with your range-diff
example, an editor should mention something like "An alternative is to
use `range-diff`; you can first run `foo` against your new commit and
old diff, and then you can run `bar` to send it." rather than "Or, use
`range-diff`. Usage: `git range-diff [foo] [bar] <baz>`." And hopefully
that kind of tone difference should be pretty clear in the context of
the rest of the document.

The one concern I do have with the informal tone is that it may be
exclusionary to international or ESL contributors in ways that I can't
understand as a native US speaker. It looks like you caught one such
instance in your review this time. I'm not sure whether it makes sense
to reword the entire document, because I was hoping to keep it from
being intimidating by being overly formal/technical. It seems like so
far folks on the list have been comfortable reading it, so maybe it's
fine the way it is?


Thanks a bunch for your review, Jonathan.

 - Emily
