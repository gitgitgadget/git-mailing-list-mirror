Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00061F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeDBUgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:36:22 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:40364 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756678AbeDBUgU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:36:20 -0400
Received: by mail-wr0-f172.google.com with SMTP id n2so12195463wrj.7
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+vBvcqqP19lvA92Ht4upwivcMQvj96V9rDnlqm4wlM=;
        b=ZGe9pJohsalAcD6OJ5mio3VllRulNux+AUMkS7cQUQ7pNvPuCdh+IuoKU3YtC+Lwae
         KrGf+vaEMU/hJNekvFHB7fn20+Sr6MKABfNhKCF1+8PpQIG+iA2joQ3nZifDVGX2W+08
         5SEaYQyn5ebFVpoURye89QvOB1mtlGBfKAb8CUlc7xfoX3hL8uKl7/rDGvW1i+a9dmej
         vtx/Q+yP5sNuQ9lRqWNKqwukl5hdb1Eu7ysr4rCx/EFTAyEpisRYH7ti1CMHXc8a2z5X
         t3uqnVDQk0Co9uDqQnzc6cVPA2nJoLwCmQ4Ks/97Z7QZYKxM3DXmT+vTLGGiDw8GZPvq
         O2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+vBvcqqP19lvA92Ht4upwivcMQvj96V9rDnlqm4wlM=;
        b=BQq0I2Wgf5koDZa4Qd3vzeVOggtzOPZrAZxGYmGolWNCH97iA0fS+cVXfMhPSQUu2M
         /B4/XcvNFwrMzvFPJ/FjxJBBNaYbJuCRstCohVw5vWF2MhZsWp6sEYFgkx68BWOBG2bE
         tFOeMn/rFYYv90l9jhN6MoOlro9UUoEG9MuRR4pa/+OYpcvhN0G7CK1jf+IY5AOrdrU2
         KhHBT0uEJ7vhbLJgyflSTIhUx+10hyKHBNychbkxsBD1l5RGTk5qpH1cteTNWgBkPX+K
         n0BfLCgKSAzcgx+HKwTt3nJCqhNTRaZ55P0aX8KVkoFboNqmR+51ekx86iKBpmgR75Jo
         AdOA==
X-Gm-Message-State: AElRT7FfhUQNa12znpQdVGnJFVbuDLjU17HKiMmYCWG5U/m4BW3H6Wzi
        x2aEmCvuDoKG+tn3f4dcPm0=
X-Google-Smtp-Source: AIpwx4/8lyU6nsfKKeD/wQzl4R35HI3ajeKQbrISmWAJy6+cVnN+iESJKLuFIixlb11Eq+fvBzEXSA==
X-Received: by 10.223.226.210 with SMTP id d18mr7226366wrj.192.1522701379057;
        Mon, 02 Apr 2018 13:36:19 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 95sm1118333wrb.47.2018.04.02.13.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 13:36:18 -0700 (PDT)
Date:   Mon, 2 Apr 2018 22:39:48 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Hosam Aly Mahmoud <hosamaly6@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git stash push -u deletes untracked files
Message-ID: <20180402213944.GF2629@hank>
References: <CAJA-u1okS1GO8+mHGbz23cs0CRt7wQAPHHsnvmZnZe4ZOf2VqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJA-u1okS1GO8+mHGbz23cs0CRt7wQAPHHsnvmZnZe4ZOf2VqQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02, Hosam Aly Mahmoud wrote:
> Hi,
> 
> Using Git 2.16.3 on MacOS 10.13.3, running `git stash push
> --include-untracked` deletes the untracked files specified in its
> arguments and creates an empty stash commit.
> 
> In the example below, I create a repository with a single file and a
> single commit. Then I create two untracked files and push one of them
> to the stash. Although I get an error, an empty stash commit is
> generated and the specified file is deleted.

Thanks for your report.  This has been reported first in
https://public-inbox.org/git/349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com/,
and fixed there.  The fix wasn't merged to 'master' yet, but it is in
the 'next' branch.

Now that 2.17 was released, I'd expect this to be merged to 'master'
at some point.  If you'd like to help the fix along, it would be
awesome if you could test the current 'next' branch, and report back
whether or not the fix works for you.

> ```
> $ git init . && touch README && git commit -m "README"
> $ touch my-file my-other-file
> $ git status
> On branch master
> Untracked files:
> my-file
> my-other-file
> 
> nothing added to commit but untracked files present
> $ git stash push -u my-file
> Saved working directory and index state WIP on master: e89afc6 README
> fatal: pathspec 'my-file' did not match any files
> error: unrecognized input
> $ git status
> On branch master
> Untracked files:
> my-other-file
> 
> nothing added to commit but untracked files present
> $ git stash list
> stash@{0}: WIP on master: e89afc6 README
> $ git stash show
> $
> $ ls
> README        my-other-file
> ```
> 
> I tested this using git built from the latest commit on master at the
> time of writing (c2a499e6c31ed613a606ffdeb5bb74ab41e9a586) and got the
> same results. Could you please check it out?
> 
> 
> Thank you,
> 
> Hosam Aly
