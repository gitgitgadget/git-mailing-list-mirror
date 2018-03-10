Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A94D1F404
	for <e@80x24.org>; Sat, 10 Mar 2018 13:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeCJNBU (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 08:01:20 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52460 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeCJNBS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 08:01:18 -0500
Received: by mail-wm0-f68.google.com with SMTP id t3so8497433wmc.2
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=X5nrWR9tD3nWDVzCtv5YwBLveenG9cfYC+AWKFeZzFc=;
        b=t+u26idmeiBsYU5O670bj05/5x6UEJP974jY5TuIQPZopXEp6A99RPaUhWxWWZgJZq
         gv9GuJ+Oi24jUYhAY3xK6ZZeMOP/l5cnhxXZL1IFHCn1N3HucnOVIMz8Sa9+/dJUVi3M
         bTNgCWoYACeN1KQYiCrBY8Z3cMyzTaG/4hxvq5Jl2aZCsoGx5CzA1t9c5lnNzk1Lvo/m
         xwxI8euVdIoWU0eqOOq4BbzzQMXrGL5qYB11Xj9Q7RSUtG5izwXd02AqvU+tPoOg5USL
         ILVRTD0L+CaEJmL8qMK3nXdzmUoV/tuswN0GBLU9Tqu7Nnth8h0Vv9tUIgQb5nCboHay
         Rehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=X5nrWR9tD3nWDVzCtv5YwBLveenG9cfYC+AWKFeZzFc=;
        b=sCRC4FIouAOVQE5F+NBa1xtHyZ5wRFHEC3l8lDJGh4Pz3zCezUHjstrDFGrSZq/g2q
         DLHjnqI73qPWBbJXZBx5EuUSSBBZsxss/KUaUDuR8FEk/0ziDPRFrY0SfKnniX82eCNf
         J5vckTDwRBGT4C7hTEIDOaAKkjpanIKJ/Dpt5ugC5TD0bHucX+cpjTFi8KC4gydoBwQm
         xitRuZk9VQP2loQhGM5cvsgGT6HOZKANFq7+/N8kCKs6gdmuLIRKbm5leQmiKT38lb9C
         qAkfGWq140TM3wAi9FMRtAryayu2Td48K0iivC9qMLOuX/ah9U5arfAERJbwTAAHDEdF
         6jsw==
X-Gm-Message-State: AElRT7Fb0nwxXx4b9P7UjbcFLbcdxWx9Gzy83ANFABwc7YHMLS8/tC42
        2iMvwBKM/WA6ulXGN0G5670=
X-Google-Smtp-Source: AG47ELsIzioV0KK1e5b1nTn1ZW1dVO6UtQaIJQiuqw0rSe9seSgxehgh4+vJlFFnA/d+os/HrKTU+g==
X-Received: by 10.80.153.13 with SMTP id k13mr2997347edb.298.1520686877149;
        Sat, 10 Mar 2018 05:01:17 -0800 (PST)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id q19sm2088572edd.86.2018.03.10.05.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Mar 2018 05:01:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        jonathantanmy@google.com, bmwill@google.com, stolee@gmail.com,
        sbeller@google.com, peff@peff.net, johannes.schindelin@gmx.de
Subject: Re: Git Merge contributor summit notes
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
Date:   Sat, 10 Mar 2018 14:01:14 +0100
Message-ID: <87efksqe3p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 10 2018, Alex Vandiver jotted:

> It was great to meet some of you in person!  Some notes from the
> Contributor Summit at Git Merge are below.  Taken in haste, so
> my apologies if there are any mis-statements.

Thanks a lot for taking these notes. I've read them over and they're all
accurate per my wetware recollection. Adding some things I remember
about various discussions below where I think it may help to clarify
things a bit.

>  - Alex
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
>   "Does anyone think there's a compelling reason for git to exist?"
>     - peff
>
>
> Partial clone (Jeff Hostetler / Jonathan Tan)
> ---------------------------------------------
>  - Request that the server not send everything
>  - Motivated by getting Windows into git
>  - Also by not having to fetch large blobs that are in-tree
>  - Allows client to request a clone that excludes some set of objects, with incomplete packfiles
>  - Decoration on objects that include promise for later on-demand backfill
>  - In `master`, have a way of:
>    - omitting all blobs
>    - omitting large blobs
>    - sparse checkout specification stored on server
>  - Hook in read_object to fetch objects in bulk
>
>  - Future work:
>    - A way to fetch blobsizes for virtual checkouts
>    - Give me new blobs that this tree references relative to now
>    - Omit some subset of trees
>    - Modify other commits to exclude omitted blobs
>    - Protocol v2 may have better verbs for sparse specification, etc
>
> Questions:
>  - Reference server implementation?
>    - In git itself
>    - VSTS does not support
>  - What happens if a commit becomes unreachable?  Does promise still apply?
>    - Probably yes?
>    - If the promise is broken, probably crashes
>    - Can differentiate between promise that was made, and one that wasn't
>    => Demanding commitment from server to never GC seems like a strong promise
>  - Interactions with external object db
>    - promises include bulk fetches, as opposed to external db, which is one-at-a-time
>    - dry-run semantics to determine which objects will be needed
>    - very important for small objects, like commits/trees (which is not in `master`, only blobs)
>    - perhaps for protocol V2
>  - server has to promise more, requires some level of online operation
>    - annotate that only some refs are forever?
>    - requires enabling the "fetch any SHA" flags
>    - rebasing might require now-missing objects?
>      - No, to build on them you must have fetched them
>      - Well, building on someone else's work may mean you don't have all of them
>    - server is less aggressive about GC'ing by keeping "weak references" when there are promises?
>    - hosting requires that you be able to forcibly remove information
>  - being able to know where a reference came from?
>    - as being able to know why an object was needed, for more advanced logic
>  - Does `git grep` attempt to fetch blobs that are deferred?
>    - will always attempt to fetch
>    - one fetch per object, even!
>    - might not be true for sparse checkouts
>    - Maybe limit to skipping "binary files"?
>    - Currently sparse checkout grep "works" because grep defaults to looking at the index, not the commit
>    - Does the above behavior for grepping revisions
>    - Don't yet have a flag to exclude grep on non-fetched objects
>    - Should `git grep -L` die if it can't fetch the file?
>    - Need a config option for "should we die, or try to move on"?
>  - What's the endgame?  Only a few codepaths that are aware, or threaded through everywhere?
>    - Fallback to fetch on demand means there's an almost-reasonable fallback
>    - Better prediction with bulk fetching
>    - Are most commands going to _need_ to be sensitive to it?
>    - GVFS has a caching server in the building
>    - A few git commands have been disabled (see recent mail from Stolee); those are likely candidates for code that needs to be aware of de-hydrated objects
>  - Is there an API to know what objects are actually local?
>    - No external API
>    - GVFS has a REST API
>  - Some way to later ask about files?
>    - "virtualized filesystem"?
>    - hook to say "focus on this world of files"
>    - GVFS writes out your index currently
>  - Will this always require turning off reachability checks?
>    - Possibly
>  - Shallow clones, instead of partial?
>    - Don't download the history, just the objects
>    - More of a protocol V2 property
>    - Having all of the trees/commits make this reasonable
>  - GVFS vs this?
>    - GVFS was a first pass
>    - Now trying to mainstream productize that
>    - Goal is to remove features from GVFS and replace with this

As I understood it Microsoft deploys this in a mode where they're not
vulnerable to the caveats noted above, i.e. the server serving this up
only has branches that are fast-forwarded (and never deleted).

However, if you were to build history on a server where you're counting
on lazily getting a blob later and the server breaks that promise, we're
in a state of having corrupted the local repo (most git commands will
just fail).

Some sub-mode where you can declare that only some branches should
implicitly promise that they have lazy blobs would be useful, but it
wasn't clear to me whether such a thing would be very hard to implement.

In any case, this is something that needs active server cooperation, and
is very unlikely to be deployed by people who don't know the caveats
involved, so I for one am all for getting this in even if there's some
significant caveats like that.

> Protocol V2 (Brandon)
> [...]
>  - (peff) Time to deprecate the git anonymous protocol?
>    - Biggest pain to sneak information into
>    - Shawn/Johannes added in additional parameters after a null byte
>    - Bug; if there's anything other than host, then die
>    - But it doesn't check anything after _two_ null bytes.
>    - "Two null bytes, for protocol V2"
>    - Only in use by github and individual users
>    - Would not be too sad if daemon went away
>    - Git for Windows has interest in daemon
>    - Still interested in simple HTTP wrapper?
>    - HTTP deployment could be made eaiser
>    - Useful for unauthenticated internal push
>    - Perhaps make the daemon use HTTPS?  Because it needs to be _simple_
>    - Currently run out of inittab

I think the conclusion was that nobody cares about the git:// protocol,
but people do care about it being super easy to spin up a server, and
currently it's easiest to spin up git://, but we could also ship with
some git-daemon mode that had a stand-alone webserver (or ssh server) to
get around that.

>  - Series as currently out
>    - Only used for local operations
>    - Not confident on remote CURL
>    - Once jgit implementation is done, should be more confident
>    - e.g. authentication may be messed up
>    - only file:// is currently in production
>    - test scripts to exercise HTTP, so only thing unknown is auth
>    - May need interop tests? there is one, but not part as standard tests
>    - Dscho can set up something in VSTS infra to allow these two versions to be tested
>    - Tests should specify their versions; might be as simple as `cd ...; make` and maybe they should be in Travis

FWIW "local operations" here refers to `git clone file://` and the like
which Google apparently does a lot of with git, and is stess testing the
v2 protocol.

> [...]
>  - some hash functions are in silicon (e.g. microsoft cares)

FWIW this refers to https://en.wikipedia.org/wiki/Intel_SHA_extensions &
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0500e/CJHDEBAF.html
among others. Previous on-list discussion at
https://public-inbox.org/git/CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com/
