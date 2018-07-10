Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507981F6AC
	for <e@80x24.org>; Tue, 10 Jul 2018 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeGJACt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 20:02:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46111 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeGJACq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 20:02:46 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so6744568pld.13
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbjxxOHnSqA81TLIjNDQVSDGz5MIs8sBV69Zy1gDUGw=;
        b=p0YrKWxsFTrXDGLrVZy06Uc+zKYMHYbRRbhCjSCV8ofSiaz0q9g37HF+AOBO3OmT34
         vWvdv0AzaruKkSRed1pFHBoTcCQDqI+4JbLRE9/iOoWgsy49DUp0u1qP9sZRqm9mmPuk
         jwz2Dfw7tg0GDG3dpGsejdtQQDJibNbwR3yGmTugAUtnAa/2Ze4kxGcaODUwrwBFAeO9
         GS/tt5zpLECL83/004MziutPJgZbD+6qic2y4nRSx25H8CejSY3taIq+ggwwBWe3jhHs
         CXmWE+rjBTVfnFB5aoboQnueoOyTC2UU7qHAwoz94CG4k7mGn4PYgj41yQq3betWWW2i
         r2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbjxxOHnSqA81TLIjNDQVSDGz5MIs8sBV69Zy1gDUGw=;
        b=d656ImXE9PuMNv8WGeZp4+l0Z1jC252PfSCDkKBwBbbP9R55Kl6yF6A3A11Z4d/56y
         cluYkzCihIw3zR+SsLIGLY95nq/MnFPSnPYqgaFxbuA5OjWPoG9nh3/GkK43dbGUDbGO
         ZBHRWraoZjCJSZCfBqeWCRWxXBigAPQ9tQpemo/7iv8mSS4ICQTVvnFA8zxFVfJdzGmE
         wGMoNrXlociHwUALQG6AVhamD6Qx+IBxnRbxki9jW3C6vAtNHChj3+jCdVBzY1GLUVgq
         31WLzf5LzgjwGIpz7+ySJvChFi/gDTE/i95n6XqY7v0vOPnZjmCUK/9Emmyd7ehCXY8A
         VzcA==
X-Gm-Message-State: APt69E1d1WH6YYK8gbGqltVChD+ZgWNZsVu6zgYLep4Zp/UbJcWl15Mr
        NVtP4N+lpTpjA/byQSTm/j4=
X-Google-Smtp-Source: AAOMgpeYq/oHjtd/epNVbBercrC7tAJmDCQAUObSrbW+nEG2xmzjWXwX4Qx4BcVSJINNBkpQCEUbhg==
X-Received: by 2002:a17:902:8604:: with SMTP id f4-v6mr22132244plo.4.1531180965919;
        Mon, 09 Jul 2018 17:02:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m11-v6sm29678054pfk.42.2018.07.09.17.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:02:45 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:02:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lin Terry <terrylin.developer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: I can do past and feature commits. It is a bug?
Message-ID: <20180710000243.GK14196@aiede.svl.corp.google.com>
References: <CACNAd2RB4GqfrfbqViX5Jwtpcsm64uQ2uU4K4W+AVR0y5d96gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACNAd2RB4GqfrfbqViX5Jwtpcsm64uQ2uU4K4W+AVR0y5d96gA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+the public git mailing list, git-security@googlegroups.com -> bcc
Hi,

Lin Terry wrote:

> I can do past and feature commits. It is a bug?
>
> Check out my gitgub page.
> https://github.com/terrylinooo
>
> You can see a LOVE, they are past commits I commited yesterday.

The ability to set the author and committer date freely is an
intentional capability.  See the 'Commit Information' section of "git
help commit-tree", for example.

If you'd like the ability to prove that an object was pushed by a
particular person at a particular time, you might like the push
certificates feature.  The pusher is authenticated using a GPG
signature; the push time can be recorded by the server in its
pre-receive or post-receive hook (so you still have to trust the
server for that).  See the description of --signed in "git help push"
and of hooks in "git help receive-pack" for more details on that
subject.

Thanks and hope that helps,
Jonathan
