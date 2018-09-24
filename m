Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687551F453
	for <e@80x24.org>; Mon, 24 Sep 2018 19:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeIYCCn (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 22:02:43 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:45623 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIYCCn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 22:02:43 -0400
Received: by mail-io1-f43.google.com with SMTP id e12-v6so18597124iok.12
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C9YtLVMWori1HsYuatb+2eYvLzpcFmikTyHaVPpqyGY=;
        b=biqqH9LDA4wW62WXcsssXLqtavOTPn+ssbWmqRnbj055p4OiTe4YtzNhc33x5x3CnW
         q3ts3UYg0PtlDQjnRlwwhPeSVy7q7xChnZoYSiefXTDhLTzEwkOwgKtIEpWHg0HzM+dU
         mWXbzzKTZ8TgwbEcx6gxUJUNwAP5lzzkpZ7W1haC02YjPvn/pUMtOf5ZSnlrOSbj8Gu9
         wweEh5XxrFo94rRyzN1s5t9NoHtuGw4k9C1qyR33uh3m7MqUhsllhHqzzReQk9tuQbd/
         fzfzTiFKJle/6fBurUpqUYymyBpv5nTAJ/7J3nPdPMaFElxOAgFppZn4xu7yc+FtP4Ev
         flxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C9YtLVMWori1HsYuatb+2eYvLzpcFmikTyHaVPpqyGY=;
        b=fRWxCV6+kcPa7O0rOxf1uHuX4LVL1uilm5ulQ2QTx/HbYXBb2pdV0mgL8YqeS57wxR
         zspbNC3Ac+nowXqTs/rxUTz2ls6hY3O6kwqqjDyFZIBMUX0Vi9Z+OlX9z4iDTkqFdbxh
         DJPtV47U621hDK/ATZ9zUvHKCg51/E0B0DGLBlk9htt5rI3MHoj71w04Vl4xqHl4lqIy
         JBBBnHLq3c06gn7Z1t4vnTk9am6iJ2IUCEmR9337yxWSpJyxNvxmNNPxq88ZnXjz+5rD
         WLd8DO/TMh+ls4hai2SMRwKwzv7oY9Z27nclBeOHsSQmieESOaus6c0oPkJwULvjK2jJ
         ka5w==
X-Gm-Message-State: ABuFfojuEktgRhTWYoSVvcTDGi/b0rV6B08tinOIlTLxDGlQ1cqLLrP8
        jsaw2hxjuzCZmwoRCReg2bCu3A==
X-Google-Smtp-Source: ACcGV62OLv042ZtWWWMpxGCV6i2ayl3HmpIOwG5DR/WjC0AXDrCcuFUz8nHfxd++0Y8dIPMguB7Uow==
X-Received: by 2002:a6b:acc2:: with SMTP id v185-v6mr358250ioe.300.1537819132209;
        Mon, 24 Sep 2018 12:58:52 -0700 (PDT)
Received: from localhost ([75.104.69.134])
        by smtp.gmail.com with ESMTPSA id n194-v6sm773itg.14.2018.09.24.12.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:58:50 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:58:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Austin <john@astrangergravity.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        id@joeyh.name, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180924195840.GG68796@syl>
References: <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl>
 <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net>
 <8736u8kpgu.fsf@evledraar.gmail.com>
 <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
 <000501d45366$cf437060$6dca5120$@nexbridge.com>
 <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
 <20180924140122.GC68796@syl>
 <CA+AhR6cyNqPW7YvEdanv_vA=T2oLrUm2ZyMZjLLFtdx8B+dqYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AhR6cyNqPW7YvEdanv_vA=T2oLrUm2ZyMZjLLFtdx8B+dqYQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 08:34:44AM -0700, John Austin wrote:
> Perhaps git-global-graph is a decent name. GGG? G3? :). The structure
> right now in my head looks a bit like:
>
> Global Graph:
>      client - post-commit git hooks to push changes up to the GG

I'm replying to this part of the email to note that this would cause Git
LFS to have to do some extra work, since running 'git lfs install'
already writes to .git/hooks/post-commit (ironically, to detect and
unlock locks that we should have released).

I'm not immediately sure about how we'd resolve this, though I suspect
it would look like either of:

  - Git LFS knows how to install or _append_ hooks to a given location,
    should one already exist at that path on disk, or

  - git-global-graph knows how to accommodate Git LFS, and can include a
    line that calls 'git-lfs-post-commit(1)', perhaps via:

      $ git global-graph install --git-lfs=$(which git-lfs)

    or similar.

> For LFS, The main points of integration with I see are:
>     -- bundling of packages (optionally install this package with a
> normal LFS installation)
>     -- `git lfs locks` integration. ie. integration with the read-only
> control of LFS

Sounds sane to me.

> > we strictly avoid using CGo
>
> What's the main reason for this? Build system complexity?

A couple of reasons. CGO is widely considered to be (1) slow and (2)
unsafe. For our purposes, this would almost be OK, except that it makes
it impossible for me to build cross-platform binaries without the
correct compilers installed.

Today, I build Git LFS for every pair in {Windows, Darwin, Linux,
FreeBSD} x {386, amd64} by running 'make release', and using CGO would
not allow me to do that.

Transitioning from Go to CGO during each call is notoriously expensive,
and concedes many of the benefits that leads us to choose Go in the
first place. (Although now that I write much more C than Go, I don't
think I would make the same argument today ;-).)

Thanks,
Taylor
