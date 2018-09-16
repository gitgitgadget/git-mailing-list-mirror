Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9F01F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeIPNSN (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 09:18:13 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33341 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeIPNSN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 09:18:13 -0400
Received: by mail-pl1-f174.google.com with SMTP id b97-v6so801495plb.0
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nhy6ZIrGIHwaOsgy222llPasbFaskAyoJk+KltZf6oc=;
        b=k0m6QDR1VPVvm8JlsHfLLX2X69VYpyXjTxdF/n0/l7bTRCdaHaSp6SLTAoiMPyMDxf
         riXNviJj9uktOJAs8zfv8tZpcCpoQp37S/pSrp/ECdWnJR38Nw0CDeT0P3f4VnVBJQ89
         8kYWw5Q4R2YTUv+GWDTCc+2KvwY+grfnF+Y6G56k122WlGmMYjanNfYsurzIDndtrJXG
         7HuPAa7a97LTDNrQk/FIS0rI8psNX2VdSEreHWVpfpB412CdEGm9bu254g1S4F7/QlfL
         IKJIg+yz78RyJ2pVKww/hB/usn1+k7Kp+bphgFmuHnsmOvXrP41cQNm6mwAk1DfMoyhL
         nbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nhy6ZIrGIHwaOsgy222llPasbFaskAyoJk+KltZf6oc=;
        b=U4m1O0OS2ElxKts+tp4lrVUwOqTyjKcVdBXi2LV4cYrssPNCU00JVed685UJKLTO5v
         mNSLtuvyUeOhgouXr3FVKo9L7F5RcspTHhHMktj7sKqgdgIUwaAmOW63T2AeyfbGjDQa
         JXb3vR3LTdP+c7b2K5FN1OhaHt0+XzvdNAsnVaCmX/E+Q4qLstVGJAUrUg2YAY6iwuWS
         4hOg65teohj6TOj7sxSrztX8Jd6CijyE3Yy/QpGbbIdiJWqd7Zyy32/iioyoOWt2IOg+
         9Oq610R/IHZjGEmvP36DK9XksJjnXTuLYP7997+NJpopzEL+og3e7qYDA3SLeeFIUg5Y
         t+VA==
X-Gm-Message-State: APzg51BDv5sdaUR8UBWHdhU84Belo8U93Rbacg7dRsltR/IkaE4oFnyI
        zdPGeAXD1yoFO6x827SdDt8OArb6HQo=
X-Google-Smtp-Source: ANB0VdbFhGAXg3ej+c56JCbr5bDJOx2G0G3uhvNZ6Saxp5SP82zUC5xDLeMpLrQoFDmOHtV95CjCVw==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr19553804pld.168.1537084568582;
        Sun, 16 Sep 2018 00:56:08 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id x23-v6sm15726141pff.9.2018.09.16.00.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 00:56:07 -0700 (PDT)
Date:   Sun, 16 Sep 2018 00:56:04 -0700
From:   David Aguilar <davvid@gmail.com>
To:     John Austin <john@astrangergravity.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, sandals@crustytoothpaste.net,
        larsxschneider@gmail.com, pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180916075604.GB18517@gmail.com>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
 <CA+AhR6crT2AoJcoGAGA0_c_XdL-0ozHUXTuDrS67tzrTvRLQZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+AhR6crT2AoJcoGAGA0_c_XdL-0ozHUXTuDrS67tzrTvRLQZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 02:13:28PM -0700, John Austin wrote:
> Hey Taylor,
> 
> Great to have your support! I think LFS has done a great job so far
> solving the large file issue. I've been working myself on strategies
> for handling binary conflicts, and particularly how to do it in a
> git-friendly way (ie. avoiding as much centralization as possible and
> playing into the commit/branching model of git). I've got to a loose
> design that I like, but it'd be good to get some feedback, as well as
> hearing what other game devs would want in a binary conflict system.
> 
> - John

Hey John, thanks for LFS, and thanks to Taylor for bringing up this topic.

Regarding file locking, the gitolite docs are insightful:
http://gitolite.com/gitolite/locking/index.html

File locking is how P4 handles binary conflicts.  It's actually
conflict prevention -- the locks prevent users from stepping
on each other without needing to actually talk to each other.

(I've always believed that this is actually a social problem
 (not a technical one) that is best served by better communication,
 but there's no doubt that having a technical guard in place is useful
 in many scenarios.)

From the POV of using Git as a P4 replacement, the locking support in
git-lfs seems like a fine solution to prevent binary conflicts.

https://github.com/git-lfs/git-lfs/wiki/File-Locking

Are there any missing features that would help improve LFS solution?


Locking is just one aspect of binary conflicts.

In a lock-free world, another aspect is tooling around dealing
with actual conflicts.  It seems like the main challenges there are
related to introspection of changes and mechanisms for combining
changes.

Combining changes is inherently file-format specific, and I suspect
that native authoring tools are best used in those scenarios.
Maybe LFS can help deal with binary conflicts by having short and sweet
ways to grab the "base", "their" and "our" versions of the conflict
files.

Example:

	git lfs checkout --theirs --to theirs.wav conflict.wav
	git lfs checkout --ours --to ours.wav conflict.wav
	git lfs checkout --base --to base.wav conflict.wav

Then the user can use {ours,theirs,base}.wav to produce the
resolved result using their usual authoring tools.

From the plumbing perspective, we already have the tools to
do this today, but they're not really user-friendly because
they require the user to use "git cat-file --filters --path=..."
and redirect the output to get at their changes.

Not sure if git-lfs is the right place for that kind of helper
wrapper command, but it's not a bad place for it either.
That said, none of these are user-friendly for non-Gits that
might be intimidated by a command-line.

Is there anything we could add to git-cola to help?

Being able to save the different conflicted index stages to
separately named files seems like an obvious feature that
would help users when confronted with a binary conflict.

With LFS and the ongoing work related to MVFS, shallow clone,
and partial checkout, the reasons to use P4 over Git are becoming
less and less compelling.  It'd be great to polish the game asset
workflows further so that we can have a cohesive approach to
doing game asset development using Git that is easy enough for
non-technical users to use and understand.

I mention git-cola because it's a Git porcelain that already has
git-lfs support and I'm very much in favor of improving workflows
related to interacting with LFS, large files, repos, and binary content.

Are there other rough edges around (large) binary files that can be improved?

One thought that comes to mind is diffing -- I imagine that we
might want to use different diff tools depending on the file format.
Currently git-difftool uses a single tool for all files, but it seems
like being able to use different tools, based on the file type, could
be helpful.  Not sure if difftool is the right place for that, but
being able to specify different tools per-file seems be useful in
that scenario.

Another avenue that could use help is documentation about suggested
workflows.  Git's core documentation talks about various
large-file-centric features in isolation, but it'd be good to have a
single user-centric document (not unlike gitworkflows) to document best
practices for dealing with large files, repos, game assets, etc.

That alone would help dispel the myth that Git is unsuitable for
large repos, large files, and binary content.
-- 
David
