Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325611FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 00:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbdFNAww (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 20:52:52 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33627 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdFNAwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 20:52:51 -0400
Received: by mail-pg0-f45.google.com with SMTP id f185so67678720pgc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DaMdPGl/2HyWA0s1aOIT7Kzg/OhWD2NoPjI042H3GaA=;
        b=YG9emtqLBtVYFiu0wux0ArhBJP4viSFHjFF/40bFl1XmwULBDqK/2n/Y87if0v1AsQ
         b2r/R4LPpUku+7bA1bplPU6tA8IKwZysmgeGAks85PnyeOnJI/SSLltamHgJJ+CykyOt
         lvbJm9/IULI1aWlivhsCu0P1sCI/lE9RRuFb715BrhsffRvm/jYKxMdpObXbTcKgnOlB
         oC55t/k7Tt5JMi0qDhUHmgksVoG6rLMzRg9z9mcQMqzVdlhM6XiITrzxKT8J7zmrymLn
         /WIo2XZXj90S+9JCATjxmTU3TSHRShUrOyZKTBjfLIl+WJFI2TIZstHQsvARfM/31cJ8
         5HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DaMdPGl/2HyWA0s1aOIT7Kzg/OhWD2NoPjI042H3GaA=;
        b=C4BIXyFHLmy/FMvJxM3KEPk/UzxEGkz/YxHKNmtA1Q0UzLHWz5ga/vQf4zQkY5l+Q3
         UBicAeNR9D2uzcUcSMASmSkKFn1416hWpzvF+erpf/ArTLbjQLFQvcHqyEix/Gk5qEUh
         grR5t6AYT7PV9tO3kVmYwiRZSgfizqDPj/DrSX+nPxaiQlnjq14Ew5CbEJ4sssL9grf6
         Ucell/PrNLrPrPrDym1VHGrTV3QIN9Euvb/PkM51sgNb8TXg6YvOedh61MbxpiVMB98m
         WLSWlOf/wsDKSD1E1xrLPEZ0U43qjEWl9w4tQsM3688sdRnv1ugauObCp3nJHx94DaHy
         ldSQ==
X-Gm-Message-State: AKS2vOxpu2lK6nfVbM/P9FkRIC5UiGKR8ZZze5X/VtmMXQJMaVap4j4N
        hwgiC36CJ56DubWxnhY=
X-Received: by 10.84.177.164 with SMTP id x33mr2092722plb.43.1497401570565;
        Tue, 13 Jun 2017 17:52:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id d66sm8295162pfb.38.2017.06.13.17.52.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 17:52:49 -0700 (PDT)
Date:   Tue, 13 Jun 2017 17:52:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2017, #04; Tue, 13)
Message-ID: <20170614005247.GT133952@aiede.mtv.corp.google.com>
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jun 13, 2017 at 02:40:16PM -0700, Junio C Hamano wrote:

> * sb/submodule-blanket-recursive (2017-06-01) 9 commits
>   (merged to 'next' on 2017-06-04 at 418bb03032)
>  + builtin/fetch.c: respect 'submodule.recurse' option
>  + builtin/push.c: respect 'submodule.recurse' option
>  + builtin/grep.c: respect 'submodule.recurse' option
>  + Introduce 'submodule.recurse' option for worktree manipulators
>  + submodule loading: separate code path for .gitmodules and config overlay
>  + reset/checkout/read-tree: unify config callback for submodule recursion
>  + submodule test invocation: only pass additional arguments
>  + submodule recursing: do not write a config variable twice
>  + Merge branch 'ab/grep-preparatory-cleanup' into sb/submodule-blanket-recursive
>
>  Many commands learned to pay attention to submodule.recurse
>  configuration.

Yay!

>  It is not known if a simple "yes/no" is sufficient in the longer
>  term, and what should happen when --recurse-submodules option starts
>  taking "recurse into them how?" parameter, though.

Any pointers for where this has been discussed, if anywhere (e.g. was
it in the thread
http://public-inbox.org/git/20170526191017.19155-1-sbeller@google.com)?
I'm hoping that we can make the defaults work well enough that a
simple "true/false" becomes sufficient.

Perhaps this is something that the documentation at
http://public-inbox.org/git/20170607185354.10050-1-sbeller@google.com
can go into, since it is an opinionated piece of documentation that
describes commonalities between submodule-related commands and how
they are meant to fit into a user's daily life.

[...]
> * bw/config-h (2017-06-13) 4 commits
>  - config: don't implicitly use gitdir
>  - config: don't include config.h by default
>  - config: remove git_config_iter
>  - config: create config.h
>
>  Code clean-up.

Patches 1-3 are good to go IMHO.

Patch 4 in pu is marked with my Reviewed-by.  I think it's getting
there but not there yet.  Did some script pull the tag from my reply
to the cover letter?  (I'm asking so that if so I can cooperate better
with such a script in the future and avoid false positive
Reviewed-bys.)

[...]
> * jk/warn-add-gitlink (2017-06-13) 2 commits
>  - t: move "git add submodule" into test blocks
>  - add: warn when adding an embedded repository
>
>  Using "git add d/i/r" when d/i/r is the top of the working tree of
>  a separate repository would create a gitlink in the index, which
>  would appear as a not-quite-initialized submodule to others.  We
>  learned to give warnings when this happens.

Note to self that we may want to put a note about this (and more
generally about the git-series style of caller that creates a GITLINK
entry that is not for a submodule) in the document being written at
http://public-inbox.org/git/20170607185354.10050-1-sbeller@google.com
or in some other document like gitrepository-layout.txt.

[...]
> * ls/github (2017-06-13) 1 commit
>  - Configure Git contribution guidelines for github.com
>
>  Help contributors that visit us at GitHub.
>
>  Will merge to 'next'.

\o/ Thank you.

[...]
> --------------------------------------------------
> [Stalled]
>
> * mg/status-in-progress-info (2017-05-10) 2 commits
>  - status --short --inprogress: spell it as --in-progress
>  - status: show in-progress info for short status
>
>  "git status" learns an option to report various operations
>  (e.g. "merging") that the user is in the middle of.
>
>  cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>

Thanks for the poke.  This looks a quite nice change, but I agree with
you about its current state.

Regards,
Jonathan
