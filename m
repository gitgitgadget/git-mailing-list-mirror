Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FDD1FF34
	for <e@80x24.org>; Wed, 10 May 2017 08:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdEJIIj (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 04:08:39 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36818 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdEJIIg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 04:08:36 -0400
Received: by mail-io0-f175.google.com with SMTP id o12so8550395iod.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q8nEyb1ZWcQo1tPqkphHLKij6p0vwfJR190Rmw1L5R8=;
        b=s3Epo2ch0UnxILYKx3aD4wX425AzU8p/aOQRqBeWhUuh19fcUQlnPmdf17QPrnDX+1
         EfWxL+ESiYgXnLoFZTbkyvWe8t4DCRjZW0BqfzYmoqI1M24DtrxdOVe0KFXCaYVXbdGi
         E13AlTLYVsVbQWG1hlmMAwSyOzJqBltuAA3f1vocVGaeT8rOY6swNhR6JnAWU/iRdbHd
         2L+to8xglrp6QIyag9RrgTCIkpPETPKhWtS5pSS5Hm0Gw43RqnqWAkmFJTjL77FG7Uaw
         eqtfmFxkAKWYUwt9P/G8kkxOFLtC9UiUSyF1vgZYhdu28DtK4753yGzOV5ur6xBd0VG2
         7zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q8nEyb1ZWcQo1tPqkphHLKij6p0vwfJR190Rmw1L5R8=;
        b=obzz4oKeD2bo/wjwidKlccUbawlUpGXde0qi/p4tpu9Wk5bhFGlEB6piBsyo4zn68Q
         wIFcFse0MizuXTaHv+OPtG950AI7stRG0lqyQGOtkiQ93dwjbHJ+P6v0ZjID43yGRZsa
         sBiogskVEy63+SdXbcz3IoO7N+xko4HYAiQaTme571xC5r5Bu/hRZJONqiV+2Rq8ohc7
         keYo1L3tii8RYbucsAHG2DXVkYivj+d2nYQ4ldLmWaShY0Mfh24kp+Un4We0IiI8quks
         IJHLEEPOG+9VwetDvsIpTSauuosckCvnkPo6WoRvolMNRiVzBCpfC0RNOVY+B9pTg59V
         A6Ww==
X-Gm-Message-State: AODbwcAD0BNzwQ0NMx+UaHwiGyjuCuw0mMV+KU7Ww8xIhJYAhU6Ffn/i
        SkVVNk6AliG6maf25yptWxsQUoErnQ==
X-Received: by 10.107.138.21 with SMTP id m21mr2192526iod.80.1494403715400;
 Wed, 10 May 2017 01:08:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 10 May 2017 01:08:14 -0700 (PDT)
In-Reply-To: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 May 2017 10:08:14 +0200
Message-ID: <CACBZZX4F2TL-kZj6y=00UTEhC-4VeDLm1EYOe2_eK=hscSdJ4g@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jean-Noel Avila <jn.avila@free.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * mg/status-in-progress-info (2017-04-14) 1 commit
>  - status: show in-progress info for short status
>
>  "git status" learns an option to report various operations
>  (e.g. "merging") that the user is in the middle of.
>
>  It is still unclear if the participants decided that it is OK to
>  spell "--inprogress" as a single word.

I agree with your mention in
<xmqqwpajikd2.fsf@gitster.mtv.corp.google.com> that it should be
--in-progress & status.inProgress, or alternatively just turned on by
default as mentioned upthread from that.

> * jc/bundle (2016-03-03) 6 commits
>  - index-pack: --clone-bundle option
>  - Merge branch 'jc/index-pack' into jc/bundle
>  - bundle v3: the beginning
>  - bundle: keep a copy of bundle file name in the in-core bundle header
>  - bundle: plug resource leak
>  - bundle doc: 'verify' is not about verifying the bundle
>
>  The beginning of "split bundle", which could be one of the
>  ingredients to allow "git clone" traffic off of the core server
>  network to CDN.
>
>  This was surrected from a "to be discarded" pile, as from time to
>  time people wonder about resumable clone that can be primed without
>  bothering Git servers with dynamic packfile creation, and some
>  people seem to think that the topic could serve as a useful
>  building block for that goal.  But nothing seem to have happend.
>  Unless people really want it, I am inclined to discard this topic.
>  Opinions?

I think it would be awesome to have CDN distribution, but I'm not
familiar enough with that area to say if the implementation is good.
Would be nice if this were pushed forward somehow.

> * ja/doc-l10n (2017-03-20) 3 commits
>  . SQUASH???
>  . l10n: add git-add.txt to localized man pages
>  . l10n: introduce framework for localizing man pages
>
>  A proposal to use po4a to localize our manual pages.
>
>  Will discard.
>  Has been stalled for too long.

Jean-Noel: Need any help with this?

> * jk/parse-options-no-no-no (2017-04-25) 2 commits
>  . SQUASH???
>  . parse-options: disallow double-negations of options starting with no-
>
>  Command line options that begin with "--no-" (e.g. "--no-checkout"
>  option of "git clone") can be negated by removing "--no-"; we
>  historically also allowed prefixing an extra "no" to the option
>  (e.g. "--no-no-checkout"), which made the command line look ugly
>  and unusual.  This proposes to forbid it.
>
>  While I agree there is no need to support "--no-no-checkout", this
>  looks more like "if it looks ugly and unusual, you do not have to
>  use it".  Perhaps we can drop it?
>
>  Will discard.

Having started this whole saga with another patch: Sound sensible, if
something's to be salvaged from this Stefan Beller's suggestion that
we don't have any no-* options but instead just have * on by default
was the most viable way forward I thought.

> * sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
>  - grep: use '/' delimiter for paths
>  - grep: only add delimiter if there isn't one already
>
>  "git grep", when fed a tree-ish as an input, shows each hit
>  prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
>  almost always either a commit or a tag that points at a commit, the
>  early part of the output "<tree-ish>:<path>" can be used as the
>  name of the blob and given to "git show".  When <tree-ish> is a
>  tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
>  "<commit>:<dir>"), however, this results in a string that does not
>  name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
>  "git grep" has been taught to be a bit more intelligent about these
>  cases and omit a colon (in the former case) or use slash (in the
>  latter case) to produce "<commit>:<path>" and
>  "<commit>:<dir>/<path>" that can be used as the name of a blob.
>
>  Will discard.
>  Nobody seems to be championing this change, after asked in all
>  recent "What's cooking" report:
>  "Is this good enough with known limitations?"

Stefan Hajnoczi: After skimming this for the Nth time it's not obvious
to me from the commit messages why this is better, and if it's
different from how this grep-commit feature is usually used.

Also I've read the grep manpage 2-3 times trying to find out how to
grep a commit/tree, but always end up not getting it and just brute
forcing something. Maybe fixing the docs would be a good starting
point for a series that changes the semantics of how the revisions are
specified?

> * ja/do-not-ask-needless-questions (2017-05-04) 3 commits
>  - git-filter-branch: make the error msg when missing branch more open
>  - read-tree -m: make error message for merging 0 trees less smart aleck
>  - usability: don't ask questions if no reply is required
>
>  Git sometimes gives an advice in a rhetorical question that does
>  not require an answer, which can confuse new users and non native
>  speakers.  Attempt to rephrase them.
>
>  I lost track of the discussion on this topic.  Did we decide that
>  this is not a good idea?

I tried to summarize the status in
<CACBZZX7kDx_F=b=efuH=m786SEOTy7EZ659tw7a=QpLWojaB5Q@mail.gmail.com>.


> * ab/grep-pcre-v2 (2017-05-02) 19 commits
>  - Makefile & configure: make PCRE v2 the default PCRE implementation
>  - grep: remove support for concurrent use of both PCRE v1 & v2
>  - grep: add support for PCRE v2
>  - grep: add support for the PCRE v1 JIT API
>  - perf: add a performance comparison test of grep -E and -P
>  - grep: change the internal PCRE code & header names to be PCRE1
>  - grep: change the internal PCRE macro names to be PCRE1
>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>  - grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>  - log: add -P as a synonym for --perl-regexp
>  - log: add exhaustive tests for pattern style options & config
>  - grep: add a test for backreferences in PCRE patterns
>  - Makefile & configure: reword outdated comment about PCRE
>  - grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
>  - grep: remove redundant regflags assignment under PCRE
>  - grep: submodule-related case statements should die if new fields are added
>  - grep: add tests for grep pattern types being passed to submodules
>  - grep: amend submodule recursion test in preparation for rx engine testing
>
>  PCRE2, which has an API different from and incompatible with PCRE,
>  can now be chosen to support "grep -P -e '<pattern>'" and friends.
>
>  Need to make sure that fallback for those without pcre2 works
>  without causing build failure.

This can just be ejected. I'm working on a complete replacement. I
have something ready to send now, but "wait with shiny toys" and all
that.

> * ab/grep-threading-cleanup (2017-04-16) 8 commits
>  - grep: given --threads with NO_PTHREADS=YesPlease, warn
>  - pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
>  - pack-object & index-pack: add test for --threads warning under NO_PTHREADS
>  - tests: add a PTHREADS prerequisite
>  - grep: skip pthreads overhead when using one thread
>  - grep: don't redundantly compile throwaway patterns under threading
>  - grep: add tests for --threads=N and grep.threads
>  - grep: assert that threading is enabled when calling grep_{lock,unlock}
>
>  Code cleanup.
>
>  Needs review.

Can also be discarded, will re-send in a different form soon.
