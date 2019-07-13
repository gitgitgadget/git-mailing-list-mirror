Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB121F461
	for <e@80x24.org>; Sat, 13 Jul 2019 00:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfGMAj4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 20:39:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35916 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfGMAjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 20:39:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so5568925plt.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 17:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/K10lfQH+XZ2ndpJyFEiCi0pRt7D0iiXLXXd7MNRxE=;
        b=ZEKZSUZAjxXnVJ5Ob8WwC+Tz5NQHRgYP0nD4OYuk6IX/j3S/QdXWRuJzYrJAzevWz3
         rSuhBhxrqL0SULVpoi7FGFVRGffR3ahQqnSbZROGTmMf3o6UXTj5Y5siG9K6GxqhWK3B
         beMJBLWbvzdc8pgXJa1vV56QS7f671DGB+e0+sMgFx/yjuz7DyWM1JUeT8LDb4s2enYo
         GWg22uD72tTSohnKotwkBgovAg9TMqHwgN7qxqA/u8/ZZFADjB5Ko48P2zlz06PA0nG0
         Xmky7eDSC1HMqZuuAHMKhxG1W0F5EPccYI5GF1mIAj+iSFsMUo9jfcm9OGoeWa0E739s
         kU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=q/K10lfQH+XZ2ndpJyFEiCi0pRt7D0iiXLXXd7MNRxE=;
        b=ArbWynAS2EK7fzQn2IK4F7g/Ghigq8alPNfIcT9aPfSNlrVPyRGQVM3C3nk42IkoBB
         DXjssKV3FylB0hvFCud59E43jAKy1yEznHUwIMn+2Id/IbCa82CKEMAwH4X3I914SuVC
         0Y9DANfQLhogibDJLDn4X56pSzPkS7DosDlTl6eimcNf6AoyNWzJG1j2FNgUxjD+2C3+
         fgFwqyr9G0SmizzK07m6UJqoFZA+f9adaa9ZYMdJb36FGq5D9wJp5LLSeaIHKKGOT6Fh
         DbPBu87QvLBLfjPpaByeLnKN4tlUbKExbygtqPi/P9M0F1kEO8/+6kJjgvxpAIfrmfaq
         e91w==
X-Gm-Message-State: APjAAAUGO5ImJr7f+qrh8Hmz2sJdWOBVll5nLVXGgww95/mXOKoim2d+
        n/kGa7k/B2hXTcOAwfUtpxu72A==
X-Google-Smtp-Source: APXvYqz4oNQcEbjEoCHAjKK1zx9gYjTxK+lhFo2F6m7OoKWg9Lf3FzVh7DOXIWboS+Z3RPoS4nwM/Q==
X-Received: by 2002:a17:902:e282:: with SMTP id cf2mr15153900plb.301.1562978394498;
        Fri, 12 Jul 2019 17:39:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id b17sm13248839pgj.73.2019.07.12.17.39.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 17:39:53 -0700 (PDT)
Date:   Fri, 12 Jul 2019 17:39:48 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
Message-ID: <20190713003948.GA43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <xmqqef41mbmd.fsf@gitster-ct.c.googlers.com>
 <20190617235053.GD100487@google.com>
 <xmqq4l4lr4dy.fsf@gitster-ct.c.googlers.com>
 <20190620210649.GA87385@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620210649.GA87385@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.06.20 14:06, Emily Shaffer wrote:
> On Wed, Jun 19, 2019 at 08:17:29AM -0700, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> > 
> > > Maybe there's a case for storing them as a set of patch files that are
> > > revision-controlled somewhere within Documentation/? There was some
> > > discussion on the IRC a few weeks ago about trying to organize these
> > > tutorials into their own directory to form a sort of "Git Contribution
> > > 101" course, maybe it makes sense to store there?
> > >
> > >   Documentation/contributing/myfirstcontrib/MyFirstContrib.txt
> > >   Documentation/contributing/myfirstcontrib/sample/*.patch
> > >   Documentation/contributing/myfirstrevwalk/MyFirstRevWalk.txt
> > >   Documentation/contributing/myfirstrevwalk/sample/*.patch
> > >
> > > I don't love the idea of maintaining text patches with the expectation
> > > that they should cleanly apply always,...
> > 
> > Well, I actually think the above organization does match the intent
> > of the "My first contribution codelab" perfectly.  When the codebase,
> > the workflow used by the project, and/or the coding or documentation
> > guideline gets updated, the text that documents how to contribute to
> > the project as well as the sample patches must be updated to match
> > the updated reality.
> > 
> > I agree with you that maintaining the *.patch files to always
> > cleanly apply is less than ideal.  A topic to update the sample
> > patches and tutorial text may be competing with another topic that
> > updates the very API the tutorials are teaching, and the sample
> > patches may not apply cleanly when two topics are merged together,
> > even if the "update sample patches and tutorial text" topic does
> > update them to match the API at the tip of the topic branch itself.
> > One thing we _could_ do is to pin the target version of the codebase
> > for the sake of tutorial.  IOW, the sample/*.patch may not apply
> > cleanly to the version of the tree these patches were taken from,
> > but would always apply cleanly to the most recent released version
> > before the last update to the tutorial, or something like that.
> > 
> > Also having to review the patch to sample/*.patch files will be
> > unpleasant.
> 
> I wonder if we can ease some pain for both of the above issues by
> including some scripts to "inflate" the patch files into a topic branch,
> or figure out some more easily-reviewed (but more complicated, I
> suppose) method for sending updates to the sample/*.patch files.
> 
> Imagining workflows like this:
> 
> Doing the tutorial:
>  - In worktree a/.
>  - Run a magic script which creates a worktree with the sample code, b/.
>  - Read through a/Documentation/MyFirstContribution.txt and generate
>    a/builtins/psuh.c, referring to b/builtins/psuh.c if confused.
> 
> Rebasing the tutorial patches:
>  - In worktree a/.
>  - Run a magic script which checks out a new branch at the last known
>    good base for the patchset, then applies all the patches.
>  - Now faced with, likely, a topic branch based on v<n-1> (where n is
>    latest release).
>  - `git rebase v<n> -x (make && ./bin-wrappers/git psuh)`
>  - Interactively fix conflicts
>  - Run a script to generate a magic interdiff from the old version of
>    patches
>  - Mail out magic interdiff to list and get approval
>  - (Maybe maintainer does this when interdiff is happy? Maybe updater
>    does this when review looks good?) Run a magic script to regenerate
>    patches from rebased branch, and note somewhere they are based on
>    v<n>
>  - Mail sample/*.patch (based on v<n>) to list (if maintainer rolled the
>    patches after interdiff approval, this step can be skipped)
> 
> (This seems to still be a lot of steps, even with the magic script..)
> 
> Alternatively, for the same process:
>  Updater: Run a magic script to create topic branch based on v<n-1>
>    (like before)
>  U: `git rebase v<n> -x (make && ./bin-wrappers/git psuh)`
>  U: Interactively fix conflicts
>  U: Run a script to turn topic branch back into sample/*.patch
>  U: Send email with changes to sample/*.patch (this will be ugly and
>     unreadable) - message ID <M1>
>  Reviewer: Run a magic script, providing <M1> argument, which grabs the
>     diff-of-.patch and generates an interdiff, or a topic branch based
>     on v<n>
>  R: Send comments explaining where issue is (tricky to find where to
>     inline in the diff-of-.patch)
>  U: Reroll diff-of-.patch email
>  R: Accepts
>  Maintainer: Applies diff-of-.patch email normally
> 
>  I suppose for the first suggestion, there ends up being quite a lot of
>  onus on the maintainer, and a lot of trust that there is no difference
>  between the RFC easy-to-read interdiff patchset. For the second
>  suggestion, there ends up being onus on the reviewers to run some
>  magical script. Maybe we can split the difference by expecting Updater
>  to provide the interdiff below the --- line? Maybe in practice the
>  diff-of-.patch isn't so unreadable, if it's only minor changes needed
>  to bring the tutorial up to latest?
> 
>  I'm not sure there's a way to make this totally painless using email
>  tools.

Random thought about the "magic scripts": if we keep an mbox instead of
a directory of *.patch files, then it seems like git-format-patch and
git-am would solve the bulk of this. I don't think dealing with
diffs-of-patches-in-mbox is much worse than dealing with
diffs-of-patches-in-multiple-files. And for the "Doing the tutorial"
workflow, it nudges the new contributor to learn git-am.

But I guess the hard part here is the reviewing diffs-of-diffs part.
I'm leaning towards the second option here; I personally would not feel
too troubled as a reviewer by having to run an extra script. And as you
say, diff-of-diffs may not be so bad in practice. Reviewers already see
these whenever someone includes a range-diff in their v>=2 emails.
