Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA5B1F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIOWAa (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 18:00:30 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:33998 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeIOWA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 18:00:29 -0400
Received: by mail-io1-f51.google.com with SMTP id c22-v6so8421196iob.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Mi19K9/dyyn8eJ2fk57LCFcKjl5IQ/l7WYdZ0tk8a0=;
        b=cYsnmHFIbKXVZHd1Ztx0mHQXtPHqaseKkNpB90imDHhOjAvzllzYz2m2HMhky4DPyJ
         UPIXAkTSYKn5ltSj8h4hyep4kzEduaVUqUAEbdI2dgI83DqG1y7aaxVGMaiO3myKzn6a
         07DqKrbuhe7mvpTiNhokab8kCZ4dPXChTtCgN0s0+tTf4pqgJt5+7dtEwsAsYcjfKEU5
         WC0W544o19BjVPiKg03NDY80/opJHb+2KqdvAbCfO5XRcKHHHFLrdvRefwi76r9krgCs
         2yjSTiccAC2YB1Kq+f4bH2a0LDmj1cqE5+EZPK/uKkAPa9O0ivx6d3qJIZlgwzc6QBHs
         xVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Mi19K9/dyyn8eJ2fk57LCFcKjl5IQ/l7WYdZ0tk8a0=;
        b=a2CnTsSuARRTFcgJIHQ4uHsdSbbxGjfxa8tWIPArBYLQr0JKjpVv1JxQ7026xqe+XB
         HFIYa2I0ZgViDtqE3xxHuCj3LkV5ZXDJza5XrMx1xdLoaH9tnBf/FtP6mOJ05FoOvp9Y
         ChevUeHvbohyq4OmXXQClXEAysZHC/xx8yTdvUZW3NQ1cB+vwAuw3lkEtY63jTZK+Xik
         zH9TWStx0NBEivvLEKpVybwZ80OKeGM2FNCv8FCRWGDtEM56iZMYsybcItOt7aG1apaX
         QpqU4keTzTZBBa+gpplsY69MBPsVOMGJTdE3aXEOCSmMKaOErQbGT55raSB8EEoKsQjT
         701g==
X-Gm-Message-State: APzg51CIQJUDSRvzNdxk8bVKROHqfbkjtEurx/KUJR1Khg2zfH0NqhkM
        aCXOajvcAMex8TvT9ccp8BtY1w==
X-Google-Smtp-Source: ANB0VdYzt3KCgah1pi6hEJPXu8ZWCLPI8uYfTAzDPDhf+caGebU4ZJVKz3F5UrToEh4N23uIgj1iZQ==
X-Received: by 2002:a6b:25d2:: with SMTP id l201-v6mr14743125iol.115.1537029654921;
        Sat, 15 Sep 2018 09:40:54 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id w8-v6sm3206340iom.15.2018.09.15.09.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:40:53 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Sat, 15 Sep 2018 12:40:52 -0400
To:     John Austin <john@astrangergravity.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, sandals@crustytoothpaste.net,
        larsxschneider@gmail.com, pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180915164052.GA88932@syl>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
 <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 02:09:12PM -0700, John Austin wrote:
> I've been working myself on strategies for handling binary conflicts,
> and particularly how to do it in a git-friendly way (ie. avoiding as
> much centralization as possible and playing into the commit/branching
> model of git).

Git LFS handles conflict resolution and merging over binary files with
two primary mechanisms: (1) file locking, and (2) use of a merge-tool.

  1. is the most "non-Git-friendly" solution, since it requires the use
     of a centralized Git LFS server (to be run alongside your remote
     repository) and that every clone phones home to make sure that they
     are OK to acquire a lock.

     The workflow that we expect is that users will run 'git lfs lock
     /path/to/file' any time they want to make a change to an
     unmeregeable file, and that this call first checks to make sure
     that they are the only person who would hold the lock.

     We also periodically "sync" the state of locks locally with those
     on the remote, namely during the post-merge, post-commit, and
     post-checkout hook(s).

     Users are expected to perform the 'git lfs unlock /path/to/file'
     anytime they "merge" their changes back into master, but the
     thought is that servers could be taught to automatically do this
     upon the remote detecting the merge.

  2. is a more it-friendly approach, i.e., that the 'git mergetool'
     builtin does work with files tracked under Git LFS, i.e., that both
     sides of the merge are filtered so that the mergetool can resolve
     the changes in the large files instead of the textual pointers.


> I've got to a loose design that I like, but it'd be good to get some
> feedback, as well as hearing what other game devs would want in a
> binary conflict system.

Please do share, and I would be happy to provide feedback (and make
proposals to integrate favorable parts of your ideas into Git LFS).

Thanks,
Taylor
