Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D9420285
	for <e@80x24.org>; Thu, 24 Aug 2017 16:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbdHXQRM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 12:17:12 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:60180 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbdHXQRK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Aug 2017 12:17:10 -0400
X-AuditID: 12074413-3a3ff70000007929-19-599efc05b393
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 85.15.31017.50CFE995; Thu, 24 Aug 2017 12:17:09 -0400 (EDT)
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com [209.85.223.172])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7OGH8Y0019037
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:17:09 -0400
Received: by mail-io0-f172.google.com with SMTP id o68so3811909iod.4
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 09:17:09 -0700 (PDT)
X-Gm-Message-State: AHYfb5heODJPw4Uu5shVh2Ubb6urjSbD2uhT95YOSJ71szyvY86QqdOO
        upyrSo2OznUkvXQ+ahYqA/2GO6nOIg==
X-Received: by 10.107.142.66 with SMTP id q63mr5471751iod.77.1503591428410;
 Thu, 24 Aug 2017 09:17:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.15.204 with HTTP; Thu, 24 Aug 2017 09:17:07 -0700 (PDT)
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 24 Aug 2017 18:17:07 +0200
X-Gmail-Original-Message-ID: <CAMy9T_HNGEv+HX7Zyj+g9i=vmrB+hTx7NJdd=FVatZRUv1b-yQ@mail.gmail.com>
Message-ID: <CAMy9T_HNGEv+HX7Zyj+g9i=vmrB+hTx7NJdd=FVatZRUv1b-yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Implement ref namespaces as a ref storage backend
To:     Richard Maw <richard.maw@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1GX9My/S4PI/NYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGUsXfuIsWC1ZsWKji7mBsZOxS5GTg4JAROJjXtPMnUxcnEICexg
        ktj65xorhPOUSaL39mNmCKePUWLTvB5miJZ8iUW/JjBB2MUS9zc+B7N5BQQlTs58wgJiCwnI
        SbzacIOxi5EDyPaW+L1XHyTMKWAlcfThJ1aIEkuJUwfXgo1kE9CVWNTTDDaGRUBVYufXdywQ
        4xMlFm/azQoyhlcgQOL6z2CQsLCAn8T1N1PBSkQE1CWOvFkANpJZQEti889v7BC2pkTr9t/s
        ExiFZyE5bhaS1AJGplWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYISEsvINx
        10m5Q4wCHIxKPLwNl+ZFCrEmlhVX5h5ilORgUhLlXf4CKMSXlJ9SmZFYnBFfVJqTWnyIUYKD
        WUmEd9sDoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYI36hdQo2BR
        anpqRVpmTglCmomDE2Q4D9BwXZAa3uKCxNzizHSI/ClGY44rV9Z9YeKYcmD7FyYhlrz8vFQp
        cd4+kFIBkNKM0jy4abA09IpRHOg5Yd4DIFU8wBQGN+8V0ComoFWTTswBWVWSiJCSamDcql/6
        5lX3rwcZcfdduLdHnJG4bLPud1XNnbp9ZW9ubo5u+XosS/ZYJPt7gyOWPyPcOvR1JWvZhPed
        lnmd/0V10p9Xx0r22W2brtg9k0E5ZsbeudbS+iUdh0RWXp9w/Gbq/p5lprrzjNOkVCZZaLwS
        urUvb9/sdJf/Yvdv2d55vXMOu+/mr07+SizFGYmGWsxFxYkAI6atZh4DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 13, 2017 at 9:36 PM, Richard Maw <richard.maw@gmail.com> wrote:
> Forewarning: I don't consider this work complete
> and am unlikely to find time to finish it any time soon.
> I've mostly sent this because it may include valuable feedback
> on how well the ref storage backends works
> from trying to use it to change how git namespaces work.
>
> Introduction
> ============
>
> I work on a git server called Gitano,
> and I'd like to add support for git namespaces to: [...]

Thanks so much for your efforts and your description of the problems
that you faced. That will be really valuable for whomever might follow
up on your work (even if it is you :-) ).

> Unfortunately namespace handling was never implemented for any other part of git
> and at least gitolite makes use of namespaces,
> and will have to work around it not being implemented fully,
> but implementing it more fully will break work-arounds.

I agree that the current namespace feature is not a great foundation
for future work.

> [...]
> Fortunately the pluggable ref backends work provided an easier starting point.

:-) I'm glad my years-long obsession is finally yielding fruit.

First a general comment about the approach...

I've always thought that a workable "Git with namespaces" would
probably look more like git worktrees:

* One main repository holding all of the objects and all of the
non-pseudo references.

* One lightweight directory per namespace-view, holding the
"core.namespace" config and the pseudorefs. HEAD should probably be
stored in the main repository (?). Both the main repository and the
namespace-view directories would probably be bare, though perhaps
somebody can think of an application for allowing non-bare
repositories.

Even though this scheme implies the need for extra directories, I
think that it would make it easier to fix a lot of your problems:

* Each namespace-view could define its own namespace,
quasi-permanently. You wouldn't have to pass it via the environment.
(You might even want to *forbid* changing the namespace via the
environment or command line!) So fetches and pushes from one namespace
to another would work correctly.

* There would be one place for each namespace-view's pseudorefs. You
wouldn't have to squeeze them into a single reference tree.

* The main repository would know all of the references of all of the
namespace views, so maintenance tools like `git gc` would work without
changes.

* The namespace-view directories wouldn't be mistakable for full
repositories, so tools like `git gc` would refuse to run in them. I
think this would also make it a little bit harder for reference values
to "leak" from one namespace-view to another.

* Remote access could use different paths for different
namespace-views. The externally-visible path need not, of course, be
the same as the path of the namespace-view's directory.

By the way, there are certainly still places in the code that don't go
through the refs API (e.g., the one that Junio found). That's because
the refs API has still not been used for anything very interesting, so
the bugs haven't been flushed out. I see you've found some more.
That's because you're doing something interesting :-)

> [...]
> Bugs
> ----
>
> Most boil down to how special refs like HEAD are handled.
>
> 1.  Logged messages display the namespaced path,
>     which a human may deal with but confuses the test suite.

I think it's clear that the logged messages should reflect the shorter
reference names, and it is the test suite that needs to be fixed.

> 2.  Reflogs for namespaced HEAD are not updated.
>
>     This is because resolving HEAD to split the transaction's updates
>     to add a log only update to HEAD works by transaction_prepare resolving HEAD
>     using its own ref store rather than the main one,
>     so the namespace translation isn't performed.
>     See split_head_update.
>
>     The fix for this may be to move the transaction mangling out of the backend,
>     unless it should be implied that every backend implementation
>     must be responsible for symbolic ref reflog updates implicitly.

It probably makes sense for the namespace layer to do this step.

I think there is a similar problem with `split_symref_update()`. Here
the problem is trickier, because you don't know how to split the
update until you have locked the symref, but the locking necessarily
has to happen in the main-repo backend. So I think there will be
places where the main-repo backend needs to call back to the namespace
layer for some things, like deciding what reference names to use in
error messages and things.

You'd also want to prevent actions in a namespace-view from affecting
references outside of that namespace. For example, you shouldn't be
able to follow a symref from a namespace-view ref to another reference
in a different namespace. This also implies some cooperation between
the file-level backend and the namespace layer.

I guess it is also clear that symrefs on disk have to contain the full
reference names of their targets, but when they are read via a
namespace-view, the caller should see the short name as the target.

[...]

Michael
