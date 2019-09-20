Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F0F1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389707AbfITRIO (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:08:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44674 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbfITRIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:08:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so9441728qth.11
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xlcLmNBQJ0tBpPmPHk59NVTPBqZwlLrc5uoJ2QBHLbg=;
        b=FmLCWihW1xQV8h9sNQAdiz62LoCZraUEofBNmj4m7yGM2DgWwjUKlxYzFnFeqhklnD
         gmONvAMqTZjfn3D4heFqwdhh7wTQDY4nl+xPonP+SFLLxRnhysUAN5GHkDm4m0sYJMC8
         wGHjKQcTjorrhULYEAyE5E8MhovhGK7EmiGS7UKd8d0dVMN0um1yZTgYBzrR/4NkmxWl
         iSgCjcLA2jdVxFAk87bqa1yrnG4ew2xPTjO7lPz7oPtrD5JjDszqtXylO2NrgiU6xKqd
         ws9OpL7tTDIdrSjaZSg9ubLcmzfqQcqbFpOTurB/ltP6FoM1jNAeK/5IGvDRefhNyXRv
         n4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xlcLmNBQJ0tBpPmPHk59NVTPBqZwlLrc5uoJ2QBHLbg=;
        b=Yz6jkqJlb/yUfBj09aVuZhqA59WnungSveWRHPYbbp8p6xtcYZCMcVvp52LmtQDGFL
         pOEetq5xwL62VH2V+eUB6Smb37oErvSsDSsHdUej8Klolo+ZkUX8Ca/efsCCptgTka1U
         ZQclGsT/C9LajriOpSGlZSTmkDk6Tptlu1y+igse0tMW2YCbk+oP7I6y9H7X9tQYydq1
         1CkfTRjLt2AvufEGNMLVtHHHv4ulUY8YbxlIwqiCN/GXs97JYqy4xkbV2GAQtwCYtwS6
         A0woHulVRla02NJJI8syp5Ulq1KsOSN7Z96/H49SB95S6CE0T1al9Hj4j3exiTqHXWng
         ngRA==
X-Gm-Message-State: APjAAAVPXP/vboeFg2vQm/DCcBLKWdBS/O3LeRsPxgR1AfR5lQHlDqI7
        hnqlOnEdLklpRO+1dYZq4AyUZoCuc+8B5g==
X-Google-Smtp-Source: APXvYqzlVdmE3pG4Y2+5LfnjIewLKP/WI2wB/XJl+5CU7AmvWPb4V3iqzMqDJBFRd7CZPLnz8iQqDQ==
X-Received: by 2002:ac8:474c:: with SMTP id k12mr4487821qtp.319.1568999293172;
        Fri, 20 Sep 2019 10:08:13 -0700 (PDT)
Received: from localhost (adamsmorganips06.a.subnet.rcn.com. [66.44.93.133])
        by smtp.gmail.com with ESMTPSA id c16sm1224386qkg.131.2019.09.20.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 10:08:12 -0700 (PDT)
Date:   Fri, 20 Sep 2019 13:08:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
Message-ID: <20190920170811.GA62895@syl.local>
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 18, 2019 at 03:33:15PM -0700, Junio C Hamano wrote:
> * tb/commit-graph-harden (2019-09-09) 3 commits
>  - commit-graph.c: handle corrupt/missing trees
>  - commit-graph.c: handle commit parsing errors
>  - t/t5318: introduce failing 'git commit-graph write' tests
>
>  The code to parse and use the commit-graph file has been made more
>  robust against corrupted input.
>
>  Will merge to 'next'.

Thanks for moving my topic along. This was found while generating
commit-graph files on all repositories hosted on GitHub, and some
corrupt repositories triggered the behavior.

We've been running this patch since a few days before I submitted it to
the mailing list without issue, and it certainly does squash the issue
I originally found.

> * jk/disable-commit-graph-during-upload-pack (2019-09-12) 2 commits
>  - upload-pack: disable commit graph more gently for shallow traversal
>  - commit-graph: bump DIE_ON_LOAD check to actual load-time
>
>  The "upload-pack" (the counterpart of "git fetch") needs to disable
>  commit-graph when responding to a shallow clone/fetch request, but
>  the way this was done made Git panic, which has been corrected.
>
>  Will merge to 'next'.

This one has a similar origin story, and has also been running at GitHub
for a few weeks. Happily, it does as it advertises and makes the
commit-graph process faster.

> * jk/partial-clone-sparse-blob (2019-09-16) 4 commits
>  - list-objects-filter: use empty string instead of NULL for sparse "base"
>  - list-objects-filter: give a more specific error sparse parsing error
>  - list-objects-filter: delay parsing of sparse oid
>  - t5616: test cloning/fetching with sparse:oid=<oid> filter
>
>  The name of the blob object that stores the filter specification
>  for sparse cloning/fetching was interpreted in a wrong place in the
>  code, causing Git to abort.
>
>  Will merge to 'next'.

A previous version of this series is running at GitHub, too, and also
without issue.

Thanks,
Taylor
