Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084DD1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 22:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeCYW67 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 18:58:59 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37439 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeCYW66 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 18:58:58 -0400
Received: by mail-wm0-f41.google.com with SMTP id r131so5332321wmb.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FZIBJBPcFWlKJgrwRy2Gg7svGEBax00KPXsI/otmOmo=;
        b=lGYB4r+1A6WkanhmbJ9evnj0zRwJVptfI1kYDLvR2difwNGaHiouVP112nxFIcrJYj
         aQVJbjacKmZH/7k4Ldw0wVoyqCCkBPSclgji1nqWYjLXXBBIpXQqnfc5/F+QJQ2IuY1a
         pdryhodsQIOiZ5RdgwwCrz3KaaKgcbrsQLsJMzQcC5Dv+s229OCGv1jR4AeeqkonC4h7
         oE9WbuUrZRqbj5S2Di2VhyU7l+YYXwVSRAv5bmgYS4k5+T7I2yUuaqmYkpuFD7p1eu4M
         tGTBTa239l5QL90Kye9zO/F2J9lu83DLhLFQ65lt4n0nW2fHHfd0NgijKWf9OeuOp39m
         4Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FZIBJBPcFWlKJgrwRy2Gg7svGEBax00KPXsI/otmOmo=;
        b=bLWjNbJpQUCs9m/ZeV7WSylRSIhr0u4MofnQsVP/CKrDX1pOEjDPOTyABgy+r/cfdN
         xLQN3rDjg3Gukau+Fn8TSTbs7NcbdovVmaDqI9U3kHV8VDO9BbW3SC5cIOMF+BqsijUW
         7smZErMWO2SOwnWemxJ/hVQ1xxVCOe1u9jibWxi/Gfs+pzrgIPN9tpdV/dIgETs5YSy0
         UbcnFLm8okjLO5QWhv3LhwmOYa7fxExtSUrBj22LdgGQaaZdOaLblWYPrn9xRRBz06fx
         508skroQTRZ0eNcBxq49rkaJnUyERzMBoHhMYDKF2/v5TtjYUYOCWa7CbfnSYlhiyMIc
         +Kgg==
X-Gm-Message-State: AElRT7HlCVPfe7yD100yp2hINS1NyOWf7l+ljgWNUZJX7UZA3yb5dXok
        Sa8hQmugu/+oo1QACASP/tw=
X-Google-Smtp-Source: AG47ELt7H9Nh+kw+T5YTqt4xdlg87eGZI604pmugZpLkEBJc+Vq5PhkwEQwcvJ1SDezJyupEEErwnA==
X-Received: by 10.80.210.215 with SMTP id q23mr15552531edg.294.1522018737316;
        Sun, 25 Mar 2018 15:58:57 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id t11sm8229839edh.46.2018.03.25.15.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 15:58:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        jonathantanmy@google.com, bmwill@google.com, stolee@gmail.com,
        sbeller@google.com, peff@peff.net, johannes.schindelin@gmx.de,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git Merge contributor summit notes
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
Date:   Mon, 26 Mar 2018 00:58:54 +0200
Message-ID: <874ll3yd75.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 10 2018, Alex Vandiver wrote:

> New hash (Stefan, etc)
> ----------------------
>  - discussed on the mailing list
>  - actual plan checked in to Documentation/technical/hash-function-transition.txt
>  - lots of work renaming
>  - any actual work with the transition plan?
>  - local conversion first; fetch/push have translation table
>  - like git-svn
>  - also modified pack and index format to have lookup/translation efficiently
>  - brian's series to eliminate SHA1 strings from the codebase
>  - testsuite is not working well because hardcoded SHA1 values
>  - flip a bit in the sha1 computation and see what breaks in the testsuite
>  - will also need a way to do the conversion itself; traverse and write out new version
>  - without that, can start new repos, but not work on old ones
>  - on-disk formats will need to change -- something to keep in mind with new index work
>  - documentation describes packfile and index formats
>  - what time frame are we talking?
>  - public perception question
>  - signing commits doesn't help (just signs commit object) unless you "recursive sign"
>  - switched to SHA1dc; we detect and reject known collision technique
>  - do it now because it takes too long if we start when the collision drops
>  - always call it "new hash" to reduce bikeshedding
>  - is translation table a backdoor? has it been reviewed by crypto folks?
>    - no, but everything gets translated
>  - meant to avoid a flag day for entire repositories
>  - linus can decide to upgrade to newhash; if pushes to server that is not newhash aware, that's fine
>  - will need a wire protocol change
>  - v2 might add a capability for newhash
>  - "now that you mention md5, it's a good idea"
>  - can use md5 to test the conversion
>  - is there a technical reason for why not /n/ hashes?
>  - the slow step goes away as people converge to the new hash
>  - beneficial to make up some fake hash function for testing
>  - is there a plan on how we decide which hash function?
>  - trust junio to merge commits when appropriate
>  - conservancy committee explicitly does not make code decisions
>  - waiting will just give better data
>  - some hash functions are in silicon (e.g. microsoft cares)
>  - any movement in libgit2 / jgit?
>    - basic stuff for libgit2; same testsuite problems
>    - no work in jgit
>  - most optimistic forecast?
>    - could be done in 1-2y
>  - submodules with one hash function?
>    - unable to convert project unless all submodules are converted
>    - OO-ing is not a prereq

Late reply, but one thing I brought up at the time is that we'll want to
keep this code around even after the NewHash migration at least for
testing purposes, should we ever need to move to NewNewHash.

It occurred to me recently that once we have such a layer it could be
(ab)used with some relatively minor changes to do any arbitrary
local-to-remote object content translation, unless I've missed something
(but I just re-read hash-function-transition.txt now...).

E.g. having a SHA-1 (or NewHash) local repo, but interfacing with a
remote server so that you upload a GPG encrypted version of all your
blobs, and have your trees reference those blobs.

Because we'd be doing arbitrary translations for all of
commits/trees/blobs this could go further than other bolted-on
encryption solutions for Git. E.g. paths in trees could be encrypted
too, as well as all the content of the commit object that isn't parent
info & the like (but that would have different hashes).

Basically clean/smudge filters on steroids, but for every object in the
repo. Anyone who got a hold of it would still see the shape of the repo
& approximate content size, but other than that it wouldn't be more info
than they'd get via `fast-export --anonymize` now.

I mainly find it interesting because presents an intersection between a
feature we might want to offer anyway, and something that would stress
the hash transition codepath going forward, to make sure it hasn't all
bitrotted by the time we'll need NewHash->NewNewHash.

Git hosting providers would hate it, but they should probably be
charging users by how much Michael Haggerty's git-sizer tool hates their
repo anyway :)
