Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569051F42D
	for <e@80x24.org>; Fri, 25 May 2018 03:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754950AbeEYDjz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 23:39:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39781 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeEYDjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 23:39:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so1845253plt.6
        for <git@vger.kernel.org>; Thu, 24 May 2018 20:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rvJ6sHrUwaVrwlelSgN1azb61GBhj++Jm++2+TiXMSs=;
        b=XOBYmWsXJzv5bMwRyAZeBHz9JMdMHVjBbkYHa2LYBAzsjUpzzK7w/JLsMs37AqTY/O
         oTqrVWJlAe7rNpmKeFunFUHQYe5vuRpScO/l8nvq4T+Mv6J+1OrJbSBwojKhFr/k4W7L
         QX4w0QGXbzwmrWMn8gIj/Fyz5kkWICrDho/U+vgDrXz6+OPhvMETC//SbcI+4VoKXuWK
         0W4qFIsN3bnnWvdC5IOgejKcOeB7y8oqVWHGaAdk/JiD1RdFQpzURTpZ1NgxIMt4R21q
         YnQksBaJNqtYbccVD66GSw5OT0HgvYDIGMcPbilR+tDhPxAbzjR+D09MR72IqgEawuYx
         fWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rvJ6sHrUwaVrwlelSgN1azb61GBhj++Jm++2+TiXMSs=;
        b=Svate2I2wONSl6Nx1dyD7FumWGO6QeIUF8cD3EH8T35xL/uPWa2dvvNtEdMaII6X1k
         zss1oSQUjBLCAqwPYsyUCWrlzF/oCF9ch4qXcIni78dcIl0TKbI3Nso+OiUePgs9ynCn
         pK2jGjxXhA2tmuhlJLYsw1QNa8tWUjS2ez7pdBxwHhsUOq9q39IR/wsECXGYQjUk8pox
         ipvhVuYIq7XJxdCHt+67EMT0gep43gjj9VFX4XNz7yjlFnR1R1kIpCJGpZKxZK2nrbaL
         fPUimNgF60Iq4EHcHTNYVKcTyCav2YWsjokfVpNpkv0LIMdZj37kDk2Sk1Deippqm3Jd
         2/CQ==
X-Gm-Message-State: ALKqPwegswJEp0Mn1cdc41Pev4wQ6EbzuAMoW6yklXdoqViZaQ7qO06e
        oaO+4CCjhRpHeLucN2YZxHM=
X-Google-Smtp-Source: AB8JxZpUKrfdBB+n33bynL58GIVRoZwAWDQ574R6KnDd8TMp/6848IdEo1YmuRvc03NTbCQub8BR1w==
X-Received: by 2002:a17:902:20e5:: with SMTP id v34-v6mr773729plg.127.1527219592993;
        Thu, 24 May 2018 20:39:52 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f13-v6sm30948362pgs.84.2018.05.24.20.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 20:39:51 -0700 (PDT)
Date:   Thu, 24 May 2018 20:39:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: turn --ita-invisible-in-index on by default
Message-ID: <20180525033942.GA234191@aiede.svl.corp.google.com>
References: <20180513175438.32152-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180513175438.32152-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

Nguyễn Thái Ngọc Duy wrote:

> Due to the implementation detail of intent-to-add entries. The current
> "git diff" (i.e. no treeish or --cached argument) would show the
> changes in the i-t-a file, but it does not mark the file as new, while
> "diff --cached" would mark the file as new while showing its content
> as empty.
>
> One evidence of the current output being wrong is that, the output
> from "git diff" (with ita entries) cannot be applied because it
> assumes empty files exist before applying.
>
> Turning on --ita-invisible-in-index [1] [2] would fix this.

I'm having a lot of trouble understanding the above.  Part of my
confusion may be grammatical: for example, the first sentence is a
sentence fragment.  Another part is that the commit message doesn't tell
me a story: what does the user try to do and fail that is not possible
without this?  What is the intention or effect behind the commits
mentioned that leads to them being cited?

To put it another way, the basic aspects I look for in a commit message
are:

 - the motivation behind the change (a wrong behavior, a task that isn't
   possible, some excessive complexity, or whatever).  The reader
   doesn't know your motivation so their default attitude will be to
   assume that nothing should change

 - a little more detail about the why and how behind the current
   behavior, to put the proposed in context.  This makes it easier for
   the reader to understand how the change will affect users of that
   behavior that don't necessarily have the same motivation.

   An example illustrating the behavior can work well here.

 - any interesting details of implementation or alternatives considered
   that can make the patch easier to read now that the motivation is out
   of the way.

 - a word or two on what this makes possible

I'm having trouble pulling apart these pieces in this commit message.
Can you give an example of a command's output before and after this change
so I can understand better why it's a good one?

> This option is on by default in git-status [1] but we need more fixup
> in rename detection code [3]. Luckily we don't need to do anything
> else for the rename detection code in diff.c (wt-status.c uses a
> customized one).
>
> [1] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
>     in index" - 2016-10-24)
> [2] b42b451919 (diff: add --ita-[in]visible-in-index - 2016-10-24)
> [3] bc3dca07f4 (Merge branch 'nd/ita-wt-renames-in-status' - 2018-01-23)
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/diff.c          |  7 +++++++
>  t/t2203-add-intent.sh   | 37 ++++++++++++++++++++++++++++++-------
>  t/t4011-diff-symlink.sh | 10 ++++++----
>  3 files changed, 43 insertions(+), 11 deletions(-)

This flips the default as announced but I'm not sure yet whether it's
a good thing.  After all, an intent-to-add entry is a real entry in
the index; why wouldn't it show up in "git diff --cached"?

Is the idea that it shouldn't show up there because "git commit" would
not include the intent-to-add entry?  That makes some sense to me.

What does the endgame look like?  Would we flip the default to
--ita-invisible and then remove the option?

Context is that an internal script does something like

	echo 'This file is added!' >added
	git add --intent-to-add added
	git diff --name-only --no-renames --diff-filter=A master

to list added files and started failing with this patch (in "next").
Arguably the script should use diff-index for a stronger stability
guarantee.  Should the script use --ita-visible as a futureproofing
measure as well?

Actually, why is this "git diff" output changing at all, given that
the script doesn't pass --cached?  I would expect "git diff" to show
the ITA entry because it affects the result of "git commit -a".

Thanks,
Jonathan
