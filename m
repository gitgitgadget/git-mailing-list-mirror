Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702511F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936118AbeF1WnL (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:43:11 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46365 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934442AbeF1WnK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:43:10 -0400
Received: by mail-yb0-f194.google.com with SMTP id s14-v6so2634773ybp.13
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFMgoMpe8TrFz1jso8hqjm+ZC6nOCB3G3TBa2oPJMsg=;
        b=MidvVD6lpdAlP49sK57SfS+I/5R9onE8EBE+XztgH2LSw6E0XM836MHpXzPjgtict6
         siU5TmXBgTxQEfKh4c7VAd2CIjqBIwGFVjke3uZcbmep9RjY0PFuhH74azW0LMcAEanm
         UQmlTVAph7sLAZZTQncwpL8AXPPDuPhbD07GGVTepK5VQ67SvGDG4uUl6A5bOiZiI6xf
         ycxgH1sNvX/lVZZDhVisYsVl+11BBV3nfHu56QlfmlebWJ2lLZDToH8UA6MT8Uinz0TL
         UgLUGTGmDrnqyQXdXaQeg6+MzW1QZQCObafv/dojujFYsfeQRgcaW4Phi6IqD97Dke+u
         zKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFMgoMpe8TrFz1jso8hqjm+ZC6nOCB3G3TBa2oPJMsg=;
        b=PYljE7tT3rL+eM5gxqa5D/2Vj+s/4VEMpp/R/9mlYajSP/PXhSbQt8mTYHq4+eUaEW
         vRNRgj7lsLxh5vw1iaHMfQ63+4p0iSMGp2Mlcra7rCLkcK2JfKGc+JzLvKdDqkvDxPWb
         Tue/Nfwz8EW0lMFcRIwNug+KTeHk6p6MIcJd7PtlRB9Dgy3tobc+6F4S1mOYX8cJjaWe
         W/dqhfoSWQW+QVwfwvYQQ1BX0cYQSywyEArTRlEM0aj3koMkmovGzrMdBdV2ON1SjAJS
         4DXo2NSJ2u44cTtOQKDsBy7whQo1MP5x5xMcqs4j67ghZRV8FlywkeboElbVNBW6GU3D
         tDZQ==
X-Gm-Message-State: APt69E3qbeEyPFHvnq063LFkUlrkYr+wRHEgpotOLVeUNbu39u3h10yp
        XJSPoxdLeiR2CMIhv/8jJX6MmLbwGZIx6jMbKrUD0g==
X-Google-Smtp-Source: ADUXVKIQcMxZ4G8j9ydRvk0lGHBeHuPipyF8m4NmT0zJFbtCv3beSEEnUprNUZSxfW4ItLs6ouIeT9Ff2YQ7ZsN7GJk=
X-Received: by 2002:a25:c04:: with SMTP id 4-v6mr6474868ybm.247.1530225789100;
 Thu, 28 Jun 2018 15:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 28 Jun 2018 15:42:57 -0700
Message-ID: <CAGZ79kbKrDu8iW+867c73OMhgqEYA1H3-zQpejxq5jMMNRb2Bg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 2:40 PM Junio C Hamano <gitster@pobox.com> wrote:
> The tip of 'next' has been rewound and it currently has only 4
> topics.  Quite a many topics are cooking in 'pu' and need to be
> sifted into good bins (for 'next') and the remainder.  Help is
> appreciated in that area ;-)

Which branches are needing review most? Or should I start
commenting on random stuff? ;-)

>
> * bw/ref-in-want (2018-06-28) 8 commits
>  - fetch-pack: implement ref-in-want
>  - fetch-pack: put shallow info in output parameter
>  - fetch: refactor to make function args narrower
>  - fetch: refactor fetch_refs into two functions
>  - fetch: refactor the population of peer ref OIDs
>  - upload-pack: test negotiation with changing repository
>  - upload-pack: implement ref-in-want
>  - test-pkt-line: add unpack-sideband subcommand
>
>  Protocol v2 has been updated to allow slightly out-of-sync set of
>  servers to work together to serve a single client, which would be
>  useful with load-balanced servers that talk smart HTTP transport.
>

I think another selling point, which should be emphasized more is
the ease of ACL checking on the server side.
Even when the read permissions are per repository (e.g. githubs
model AFAICT), the serving side still has to do a lookup "Can
a wanted sha1 be reached from all refs?", which now can be
optimized away ("Can I access the master branch?") and it
is cheaper to run the server.
Specifically if read permissions are per ref (Gerrits model), I'd
expect some CPU savings on the serving side.

> * jt/remove-pack-bitmap-global (2018-06-21) 2 commits
>  - pack-bitmap: add free function
>  - pack-bitmap: remove bitmap_git global variable
>
>  The effort to move globals to per-repository in-core structure
>  continues.

This is mostly done, though Peff seems to expect a reroll with
clarification on how the series is structured?
https://public-inbox.org/git/20180611211033.GB26235@sigill.intra.peff.net/

> * sb/submodule-move-head-error-msg (2018-06-25) 1 commit
>  - submodule.c: report the submodule that an error occurs in
>
>  Needs a reroll.
>  cf. <20180622081713.5360-1-szeder.dev@gmail.com>

https://public-inbox.org/git/xmqqmuviq2n7.fsf@gitster-ct.c.googlers.com/

suggests that you applied that change and a reroll would not be needed.


>
> * ds/multi-pack-index (2018-06-25) 24 commits
>  - midx: clear midx on repack
>  - packfile: skip loading index if in multi-pack-index
>  - midx: prevent duplicate packfile loads
>  - midx: use midx in approximate_object_count
>  - midx: use existing midx when writing new one
>  - midx: use midx in abbreviation calculations
>  - midx: read objects from multi-pack-index
>  - midx: prepare midxed_git struct
>  - config: create core.multiPackIndex setting
>  - midx: write object offsets
>  - midx: write object id fanout chunk
>  - midx: write object ids in a chunk
>  - midx: sort and deduplicate objects from packfiles
>  - midx: read pack names into array
>  - multi-pack-index: write pack names in chunk
>  - multi-pack-index: read packfile list
>  - packfile: generalize pack directory list
>  - multi-pack-index: expand test data
>  - multi-pack-index: load into memory
>  - midx: write header information to lockfile
>  - multi-pack-index: add 'write' verb
>  - multi-pack-index: add builtin
>  - multi-pack-index: add format details
>  - multi-pack-index: add design document
>
>  When there are too many packfiles in a repository (which is not
>  recommended), looking up an object in these would require
>  consulting many pack .idx files; a new mechanism to have a single
>  file that consolidates all of these .idx files is introduced.
>
>
> * nd/use-the-index-compat-less (2018-06-25) 13 commits
>  - wt-status.c: stop using index compat macros
>  - sha1-name.c: stop using index compat macros
>  - sequencer.c: stop using index compat macros
>  - revision.c: stop using index compat macros
>  - rerere.c: stop using index compat macros
>  - merge.c: stop using index compat macros
>  - merge-recursive.c: stop using index compat macros
>  - entry.c: stop using index compat macros
>  - diff.c: stop using index compat macros
>  - diff-lib.c: stop using index compat macros
>  - check-racy.c: stop using index compat macros
>  - blame.c: stop using index compat macros
>  - apply.c: stop using index compat macros
>
>  Use of many convenience functions that operate on the_index
>  "primary in-core index instance" have been rewritten to explicitly
>  call the coutnerpart functions that take arbitrary index_state and
>  pass the_index.
>
>  I'd say that alone is a useless code churn, but people seem to be
>  excited about the change, so it is queued here.

As someone who also does lots of refactoring lately, I am excited
to see the code health moving in the right direction.

It is easy to quantify how often we are bitten by code churn
(that you call useless here); and very hard to quantify bugs
introduced or features not written/upstreamed due to clunky
API (as we don't see those or do not attribute a bug to a bad API).
So we are naturally biased towards seeing code churn
as bad, as the signals favor one over the other.

>
> * jt/fetch-pack-negotiator (2018-06-15) 7 commits
>  - fetch-pack: introduce negotiator API
>  - fetch-pack: move common check and marking together
>  - fetch-pack: make negotiation-related vars local
>  - fetch-pack: use ref adv. to prune "have" sent
>  - fetch-pack: directly end negotiation if ACK ready
>  - fetch-pack: clear marks before re-marking
>  - fetch-pack: split up everything_local()
>  (this branch is used by jt/fetch-nego-tip.)
>
>  Code restructuring and a small fix to transport protocol v2 during
>  fetching.
>
>  Is this ready for 'next'?

That is a good topic to review for me, I'll jump on it.

> * ds/commit-graph-fsck (2018-06-27) 22 commits
[...]
>
>  "git fsck" learns to make sure the optional commit-graph file is in
>  a sane state.
>
>  Is this ready for 'next'?

I hope so, as I plan to reroll the next object store series based
on it. I'll also review that.

>
> * jm/cache-entry-from-mem-pool (2018-06-28) 8 commits
>  - block alloc: add validations around cache_entry lifecyle
>  - block alloc: allocate cache entries from mem-pool
>  - mem-pool: fill out functionality
>  - mem-pool: add life cycle management functions
>  - mem-pool: only search head block for available space
>  - block alloc: add lifecycle APIs for cache_entry structs
>  - read-cache: make_cache_entry should take object_id struct
>  - read-cache: teach refresh_cache_entry() to take istate
>
>  For a large tree, the index needs to hold many cache entries
>  allocated on heap.  These cache entries are now allocated out of a
>  dedicated memory pool to amortize malloc(3) overhead.

This is also on my review todo list, still.

>
> * sb/diff-color-move-more (2018-06-25) 11 commits
>  - diff: fix a sparse 'dubious one-bit signed bitfield' error
>  - SQUASH??? t/4015 GETTEXT_POISON emergency fix
>  - SQUASH????? Documentation breakage emergency fix
[...]
>
>  "git diff --color-moved" feature has further been tweaked.
>
>  Needs to be cleaned-up with various fix-up bits applied inline.

I'll resend with those squashes and another (test-)fix SZEDER
mentioned soon.

Thanks,
Stefan
