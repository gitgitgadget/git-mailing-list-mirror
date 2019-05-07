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
	by dcvr.yhbt.net (Postfix) with ESMTP id 707B61F45F
	for <e@80x24.org>; Tue,  7 May 2019 20:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEGUc0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 16:32:26 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40505 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGUc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 16:32:26 -0400
Received: by mail-qt1-f202.google.com with SMTP id y13so18622295qtc.7
        for <git@vger.kernel.org>; Tue, 07 May 2019 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fHRXUFHws2uYANh84ODF4NxfjeExblERxKxvtsPN0aE=;
        b=Yasbg99VwYDlgZgHqWVqVo/oqF+r8gAbLbM45rZyQxmrO8holC0fd6jmvJjCoLqCID
         ZonKNM1trqHxY+pEJZxGuRApExA0az5mFhEhAz23Ji8YFTmFZEY4YqkO3at0tkFKsDUA
         kELuDKzFR+rswb40Sfhk9d+0aNha96KBdZK3u40txBafZCJwfLzxLTfGUeLwl4uiIcYw
         uFHEWFVOcCWvybfVUC7VCYjIpSwGUiVst2fhtrJrB/iRN99Aug0P2ZaRkUUe6aeq76Bf
         Tnp06g5wYGYE40Ofq6gbTzkZw0uIWvz2E702MOT7mXSx42axlQHj18QurmIwQoESBDqj
         4Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fHRXUFHws2uYANh84ODF4NxfjeExblERxKxvtsPN0aE=;
        b=KjeN9gkqlkgQTXNQM+M5EQKx7syOcLoPpIP7vExeyHiByZdMW2+qYNW1yYiKTXAsnr
         JfpVMhUqsS557L84DR39byBmp8VCs94P05uu8CnDbKqvcQWgdITYmoNynJN/ub/VhUmb
         PNsdM50F9KiNyWs+OPcKXHy9z0/FT4RRUHzP0wf5ucaIatw5Kr/tESn+YndiiwxMXyoU
         ysLzSCSKc0aUguP7CWhAWay10MPwcHcZZU1xZwpNf1eCx5zO3pB5x6esd6RWI9NOCmLj
         SYll0jHFwXK3oTc8HJjjdjYDkYmsI4tygacqB5co1gse54CFcITHAtBviXiSnyou6A4P
         W7Cw==
X-Gm-Message-State: APjAAAX/N21nArR68LU/m8NlEdwLIFAwSJarRNw6MVL6obyP0O5iHtNT
        N/7LKWo/u8k7zvuF+PF5YairNbRVEFEKtKVrfZdG
X-Google-Smtp-Source: APXvYqxFoheauCg/EBB5IpP5pG7oa2mB7ELXUQPynFqLX5d39GPp0x00gkQIxZoln5A4MPkGc/NwqHImJ5zmSK6ZsHTF
X-Received: by 2002:a37:8243:: with SMTP id e64mr27214737qkd.18.1557261144947;
 Tue, 07 May 2019 13:32:24 -0700 (PDT)
Date:   Tue,  7 May 2019 13:32:21 -0700
In-Reply-To: <20190507195938.GD220818@google.com>
Message-Id: <20190507203221.77744-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190507195938.GD220818@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [PATCH v4] documentation: add tutorial for first contribution
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, May 06, 2019 at 03:28:44PM -0700, Jonathan Tan wrote:
> > Sorry for not looking at this sooner. 
> > 
> > Firstly, I'm not sure if this file should be named without the ".txt",
> > like SubmittingPatches.
> 
> I should mention that during this change's life as a GitGitGadget PR,
> dscho performed a review in GitHub, which included a recommendation to
> name this SubmittingPatches.txt. This obviates quite a bit of
> boilerplate within the Makefile as there are rules for handling *.txt
> documentation generation already. You can check out Johannes's review:
> https://github.com/gitgitgadget/git/pull/177

Ah, thanks.

> > > +The list of commands lives in `git.c`. We can register a new command by adding
> > > +a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
> > > +with the command name, a function pointer to the command implementation, and a
> > > +setup option flag. For now, let's keep cheating off of `push`. Find the line
> > > +where `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing
> > > +the new line in alphabetical order.
> > 
> > For an international audience, it might be better to replace "cheating
> > off" with its literal meaning. It took me a while to understand that
> > "cheating off" was meant to evoke a so-called cheat sheet.
> 
> You're right; I leaned too far towards casual voice here and included a
> colloquialism. I've modified this to "let's keep mimicking `push`" as I
> feel it means the same thing, without the slang but with a similar tone.
> 
> I also considered "copying from `push`" but didn't want to indicate we
> would be copy-pasting lines of code. If anybody's got a better
> suggestion for a verb here I'm happy to hear it; "cheating from X" is a
> phrase I'm trying to stop using anyways :)

"Mimicking" sounds good to me.

> > I think it's better to describe the message ID as without the angle
> > brackets. Reading the RFC (https://tools.ietf.org/html/rfc2392), the
> > message-id doesn't have them.
> > 
> > [snip]
> 
> Junio argued the opposite here:
> https://public-inbox.org/git/xmqqr29vbpge.fsf@gitster-ct.c.googlers.com/
> and it looks like the RFC (possibly poorly-worded) also indicates the
> angle brackets are part of the Message-ID spec (the ID without the
> brackets is a '"mid" URL'):
> 
>    A "cid" URL is converted to the corresponding Content-ID message
>    header [MIME] by removing the "cid:" prefix, converting the % encoded
>    character to their equivalent US-ASCII characters, and enclosing the
>    remaining parts with an angle bracket pair, "<" and ">".
> 
>    ...
> 
>    A "mid" URL is converted to a Message-ID or Message-ID/Content-ID
>    pair in a similar fashion.
> 
> So I'll leave this the way it is.

OK, that's fine.

> > > +=== Bonus Chapter: One-Patch Changes
> > 
> > This is not truly a bonus - the mailing list prefers this if the patch
> > set contains only one patch.
> 
> In the context specifically of this tutorial, I sort of think it is -
> since the tutorial doesn't send out a one-patch changeset, this seems
> like an aside to me. That is, I feel like the flow of the tutorial says,
> "First you do A, then B, then C (and by the way, if you're doing C', you
> would do it like this)."
> 
> I also liked the phrasing as a bonus because it covers something that
> GitGitGadget does not support, so it's "extra content" compared to the
> analogous chapter on using GGG.
> 
> If you feel very strongly, I could change it, but for now I disagree.

Those are good points.

> > > +In some cases, your very small change may consist of only one patch. When that
> > > +happens, you only need to send one email. Your commit message should already be
> > > +meaningful and explain the at a high level the purpose (what is happening and
> > > +why) of your patch, but if you need to supply even more context, you can do so
> > > +below the `---` in your patch. Take the example below, generated with
> > > +`git format-patch` on a single commit:
> > 
> > It's not clear to me how `git format-patch` can generate the extra
> > paragraph below. The user would either have to include "---" in the
> > commit message (in which case there would be an extra "---" below the
> > extra paragraph, which is perfectly safe) or edit the email *after*
> > `git-format-patch` has generated the email.
>  
> I will clarify the wording to indicate that I mean the user should edit
> the patch after generating. Brevity got in the way of completeness here.
> Thanks.
> 
> I've modified the sentence to include that there was a second step here:
> "generated with `git format-patch` on a single commit, and then edited
> to add the content between the `---` and the diffstat."
> 
> I've also added a sentence to the note in the commit at the end, "This
> section was added after `git format-patch` was run, by editing the patch
> file in a text editor."

Sounds good.

> > The other meta-concern is maintaining the informal tone when we update
> > this document (for example, when we add features like range-diff which
> > can be used when sending v2 - well, somebody can add information about
> > that to this document once it has been merged); but I don't think that
> > is a concern in practice (either we keep the tone or there is a slight
> > tone mismatch, and I don't think that either is a big deal).
> 
> I see your concern. I'm not sure whether it would really be a big deal
> as long as folks who are editing the document remember that this is a
> tutorial, not a reference document. That is, with your range-diff
> example, an editor should mention something like "An alternative is to
> use `range-diff`; you can first run `foo` against your new commit and
> old diff, and then you can run `bar` to send it." rather than "Or, use
> `range-diff`. Usage: `git range-diff [foo] [bar] <baz>`." And hopefully
> that kind of tone difference should be pretty clear in the context of
> the rest of the document.

I agree - the main thing is to remember that this is meant for the
newcomer who wants to start with a small-scoped project instead of the
experienced contributor who wants to know all there is about a topic.
(Which I think you've done very well, and should not be a problem for
the rest of the project to keep in mind too with the "My First
Contribution" name.)

> The one concern I do have with the informal tone is that it may be
> exclusionary to international or ESL contributors in ways that I can't
> understand as a native US speaker. It looks like you caught one such
> instance in your review this time. I'm not sure whether it makes sense
> to reword the entire document, because I was hoping to keep it from
> being intimidating by being overly formal/technical. It seems like so
> far folks on the list have been comfortable reading it, so maybe it's
> fine the way it is?

I agree that it's fine the way it is, and that the informal tone does
make this document (and by extension, the project) more accessible to
newcomers, which is a good thing.

I think that Emily is planning to send out a v5 with the Makefile
alphabetization, section header link targets, and some other textual
changes, and once she sends that out, I think that this is ready to be
merged in. So here's my reviewed-by:

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
