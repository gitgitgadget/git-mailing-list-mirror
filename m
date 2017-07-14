Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7023720357
	for <e@80x24.org>; Fri, 14 Jul 2017 23:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdGNXRL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 19:17:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34296 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdGNXRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 19:17:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so13147499wmg.1;
        Fri, 14 Jul 2017 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LDuBs9rspcPD8Fi3003TRKaMnD3iQlBJc638433r6B8=;
        b=DoBsxdchqPkc1pjjxU8Z/dNxKGLxaGXcfKaKE3jQYXWLiMqykoZe/z4IgPBHvVWlAz
         WmLF2IGngXUQWMjL8dePSH1p4Y/YgWz2fzk5KZVRccV7zBlJFF5zYKaZkXKg7UivH9mS
         iQXboiw2X1n3ZR+SeVNPcrn4PP95rt12mbM9Lo3tKd9sCAwh3nlX795G/lYawnPgGZoA
         z17tMVtdvBeKOCXJ2v2tKz3hqteLZr5r7074gadzPReatkAtuM8T5+XCK+NQgtXTuYiB
         IQgcwNOvUk9Xa51zP/Lb16qCR9M69KRPvehKZvV2D0wPmIMLYREM5Ahxm7NZVKKf0B7K
         MYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LDuBs9rspcPD8Fi3003TRKaMnD3iQlBJc638433r6B8=;
        b=tSTxoYky8kMynIMQn5QTECn3e80bYzY58uTCKfsMSeJkdhcI2K2Qalx1CrknfgaSFG
         1BbjtKI34Lo+GBliHdi0+IhDZqED+gppUCONGIMNoildw8Wy2j9cUw30RbX57ghyCFP6
         9hvkIuiiEZiz1+gVNr8thaEGvn2SOTOzN32ByyUbDOqUfrgl5wVUFUNWd2Bmt2YtUI/j
         it3zUTNOMemQle8eIk7+2vPk9BmaZgwkTYjnCTSILrk2R5zQw6akRCEfOf3XuKXgXFr0
         fDEu2LPKl6LpYkprAeVrlvGskY2bDK9K42C4dr3x8t7DTCDbuHUkfegIAZzrk+BvshJs
         mQ1g==
X-Gm-Message-State: AIVw111Lws8gCx6I/TWkVyr1vK0aOCEbV9g9jZuALnwBMLUtab+Xph04
        ef34xE+Cpg321kQnDFM=
X-Received: by 10.28.129.205 with SMTP id c196mr4552156wmd.120.1500074228043;
        Fri, 14 Jul 2017 16:17:08 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id b30sm10151958wra.42.2017.07.14.16.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2017 16:17:07 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dW9pa-0002DC-8i; Sat, 15 Jul 2017 01:17:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.14.0-rc0
References: <xmqqzic7sy2g.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqzic7sy2g.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 15 Jul 2017 01:17:06 +0200
Message-ID: <87mv8638y5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 13 2017, Junio C. Hamano jotted:

Proposed improvements for the release notes (is this a good way to
propose RelNotes changes?)

> An early preview release Git v2.14.0-rc0 is now available for
> testing at the usual places.  It is comprised of 675 non-merge
> commits since v2.13.0, contributed by 53 people, 14 of which are
> new faces.
> [...]
> Git 2.14 Release Notes (draft)
> ==============================
>
> Backward compatibility notes.
>
>  * Use of an empty string as a pathspec element that is used for
>    'everything matches' is still warned and Git asks users to use a
>    more explicit '.' for that instead.  The hope is that existing
>    users will not mind this change, and eventually the warning can be
>    turned into a hard error, upgrading the deprecation into removal of
>    this (mis)feature.  That is not scheduled to happen in the upcoming
>    release (yet).
>
>  * Git now avoids blindly falling back to ".git" when the setup
>    sequence said we are _not_ in Git repository.  A corner case that
>    happens to work right now may be broken by a call to die("BUG").
>    We've tried hard to locate such cases and fixed them, but there
>    might still be cases that need to be addressed--bug reports are
>    greatly appreciated.
>
>  * The experiment to improve the hunk-boundary selection of textual
>    diff output has finished, and the "indent heuristics" has now
>    become the default.
>
>
> Updates since v2.13
> -------------------
>
> UI, Workflows & Features
>
>  * The colors in which "git status --short --branch" showed the names
>    of the current branch and its remote-tracking branch are now
>    configurable.
>
>  * "git clone" learned the "--no-tags" option not to fetch all tags
>    initially, and also set up the tagopt not to follow any tags in
>    subsequent fetches.
>
>  * "git archive --format=zip" learned to use zip64 extension when
>    necessary to go beyond the 4GB limit.
>
>  * "git reset" learned "--recurse-submodules" option.
>
>  * "git diff --submodule=diff" now recurses into nested submodules.
>
>  * "git repack" learned to accept the --threads=<n> option and pass it
>    to pack-objects.
>
>  * "git send-email" learned to run sendemail-validate hook to inspect
>    and reject a message before sending it out.
>
>  * There is no good reason why "git fetch $there $sha1" should fail
>    when the $sha1 names an object at the tip of an advertised ref,
>    even when the other side hasn't enabled allowTipSHA1InWant.
>
>  * The recently introduced "[includeIf "gitdir:$dir"] path=..."
>    mechanism has further been taught to take symlinks into account.
>    The directory "$dir" specified in "gitdir:$dir" may be a symlink to
>    a real location, not something that $(getcwd) may return.  In such
>    a case, a realpath of "$dir" is compared with the real path of the
>    current repository to determine if the contents from the named path
>    should be included.

I think this is backwards, comparing the realpath is what we did in
2.13.0, i.e. if ~/work was a symlink to /mnt/storage/wor we'd match
"gitdir:~/work against /mnt/storage/work only (the realpath), now we
also match it against the `pwd` ~/git_tree.

This also makes it sound like now we just do it differently, whereas we
do both now.

I think this may explain it better:

 * The "[includeIf "gitdir:$dir"] path=..." mechanism introduced in
   2.13.0 would canonicalize the path of the gitdir being
   matched.

   Therefore it wouldn't match e.g. "gitdir:~/work/*" against a repo in
   "~/work/main" if ~/work was a symlink to "/mnt/storage/work".

   Now we match both the resolved canonical path and what "pwd" would
   show. The include will happen if either one matches.

>  * Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
>    configuration variable an escape hatch for those who do no want it.

It's "diff.indentHeuristic" not "diff.indentHeuristics" (extra "s"). The
"and diff.indentHeuristics configuration variable" reads strangely to
me. Maybe this, and also explain what it's for (the explanation may be
shitty):

  * Make the "indent" heuristics the default in "diff". The
    diff.indentHeuristic configuration variable can be set to "false" or
    --no-indent-heuristic can be provided on the command-line for those
    who do not want it.

    The common case affected by the indent heuristic is to make diffs
    that deal with editing the middle of repetitive code look nicer,
    since they don't seem to e.g. "steal" parts of an earlier function
    definition for their own use.

>  * Many commands learned to pay attention to submodule.recurse
>    configuration.
>
>  * The convention for a command line is to follow "git cmdname
>    --options" with revisions followed by an optional "--"
>    disambiguator and then finally pathspecs.  When "--" is not there,
>    we make sure early ones are all interpretable as revs (and do not
>    look like paths) and later ones are the other way around.  A
>    pathspec with "magic" (e.g. ":/p/a/t/h" that matches p/a/t/h from
>    the top-level of the working tree, no matter what subdirectory you
>    are working from) are conservatively judged as "not a path", which
>    required disambiguation more often.  The command line parser
>    learned to say "it's a pathspec" a bit more often when the syntax
>    looks like so.
>
>  * Update "perl-compatible regular expression" support to enable JIT
>    and also allow linking with the newer PCRE v2 library.

At the risk of advertising work I've done too much, I think it makes
sense to split this into two separate and somewhat more verbose items:

 * For the "perl-compatible regular expression" Git can now be built
   with PCRE v2 instead of v1 of the PCRE library. Replace
   USE_LIBPCRE=YesPlease with USE_LIBPCRE2=YesPlease in existing build
   scripts to build against the new version.

   It is highly recommended that packagers of Git switch to PCRE v2 as
   the upstream PCRE maintainer has abandoned v1 maintenance for all but
   the most critical bug fixes.

   Switching to v2 is compatible with existing PCRE patterns. The only
   changes from a user's perspective are better performance, better
   error messages, and various fixed bugs. Bugs are getting closed in v1
   as "WONTFIX, move to v2".

 * The "perl-compatible regular expression" support with either the new
   PCRE v2 support or the existing PCRE v1 support (enabled for grep &
   log via grep.patternType=perl) will now take advantage of JIT support
   in these libraries, if available.

   For most patterns PCRE JIT (particularly a recent PCRE v2) is faster
   than the system-provided POSIX basic & extended regex
   implementations. Users who are sensitive to git-grep or git-log
   --grep performance should try to see if grep.patternType=perl
   improves things, note that the pattern syntax is incompatible with
   Git's default setting of "basic".

>  * "filter-branch" learned a pseudo filter "--setup" that can be used
>    to define common functions/variables that can be used by other
>    filters.
>
>  * Using "git add d/i/r" when d/i/r is the top of the working tree of
>    a separate repository would create a gitlink in the index, which
>    would appear as a not-quite-initialized submodule to others.  We
>    learned to give warnings when this happens.
>
>  * "git status" learned to optionally give how many stash entries the
>    user has in its output.

Since stashes are per-repo not per-user I fund the "stash entries the
user has" odd here. I think this is better all-round:

 * "git status" learned to show how many stash entries there are. Set
   status.showStash=true in the config or give it --show-stash to enable
   that.

>  * "git status" has long shown essentially the same message as "git
>    commit"; the message it gives while preparing for the root commit,
>    i.e. "Initial commit", was hard to understand for some new users.
>    Now it says "No commits yet" to stress more on the current status
>    (rather than the commit the user is preparing for, which is more in
>    line with the focus of "git commit").
>
>  * "git send-email" learned to overcome some SMTP server limitation
>    that does not allow many pieces of e-mails to be sent over a single
>    session.

Makes it sound like it does that automatically, also "pieces of e-mails"
and "sent over" is odd, maybe:

* "git send-email" now has --batch-size and --relogin-delay options
   which can be used to overcome limitations on SMTP servers that have
   limits on how many of e-mails can be sent in a single session.

>  * An old message shown in the commit log template was removed, as it
>    has outlived its usefulness.
>
>  * "git pull --rebase --recurse-submodules" learns to rebase the
>    branch in the submodules to an updated base.
>
[...skimmed the cut-out bits, seemed good to me...]
>
>  * An unaligned 32-bit access in pack-bitmap code ahs been corrected.

s/ahs/has/

>  * Tighten error checks for invalid "git apply" input.
>
>  * The split index code did not honor core.sharedrepository setting
>    correctly.

Maybe camel-Case: core.sharedRepository

>  * The Makefile rule in contrib/subtree for building documentation
>    learned to honour USE_ASCIIDOCTOR just like the main documentation
>    set does.
>
>  * Update the sha1dc again to fix portability glitches.

I think we can drop this item, covered by `The "collision detecting"
SHA-1...` above.
