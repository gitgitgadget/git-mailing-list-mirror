Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13F820C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbdFLVxz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:53:55 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35878 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdFLVxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:53:55 -0400
Received: by mail-pg0-f43.google.com with SMTP id a70so50553974pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Et6rrXyArDkLNCVrVGEfZ+GWjBmTtzMH+PZrH2Slt8=;
        b=AbBLSuZCGNTsXmecEXOfH9iw4wxaJseDRYvZh/R5Zq9k2JOIGXVTUt2OFskAPW6OK1
         3r6FcM0UUxWmbIQ1PkUaVMcrETrqKiwFdR+M3MTdzwBfb75ZAMt3AqgxbKz/MDjZZb40
         sOrO2q1zpiTYSbgkDw1fLTeK3KQpgKzfy7ia/vbB1iXSsWXljeaB5TxxRfog1TA9SOfo
         SVMzYU4XSlmAsIN0NyGdtbwc1v+Bjxa23pIrX8xDuT7iYg3sstPH4UdYQHZsZLBZNyFr
         hODTV+40L4QY0HCu5qlFaoRT3UAArhCAuaFlHx8okPb9y0bIPkxO86BG9x4NLyYdF7t4
         AF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Et6rrXyArDkLNCVrVGEfZ+GWjBmTtzMH+PZrH2Slt8=;
        b=FokyN6W0VNPATF+nA5U2xqLoWV5vIDCesT3HQwIS0HUi+7Gj27CBIkHRfdXloc7pBk
         egMBAp9NiQXS6OZsDGu1yOelqQbXc4FG+oCitt+MUA+OMIN7KLyWocsbt3ZXCKlJqLaC
         oWuWYCeQkwHYqIUW/0qmO0UGHwZhIkYu885xY7210c81oFlL5h3SFhMLytBYcS0TbZcR
         OocPZuDHaFlVX1YvWVH5Z+/KEwfYs0QQkaUOURh6AwC/3gtC8sonpzqWs/pZJ7gX71cp
         Cruyrl1bZp6f8deLuyBe0PJbpyLMkKuvhCpx3BMMqzHnPnkjyZ1sPAn2dndqYDGL1dGW
         VCNA==
X-Gm-Message-State: AODbwcCO9kq2tcyKvqliSoscc2InzkbHwi5Fndl+MqJLt6XT2z5soFRW
        IbilUXwu9VlEt548
X-Received: by 10.84.199.194 with SMTP id d2mr22545256plh.221.1497304434230;
        Mon, 12 Jun 2017 14:53:54 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id 84sm19065965pfq.125.2017.06.12.14.53.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 14:53:53 -0700 (PDT)
Date:   Mon, 12 Jun 2017 14:53:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] config.h
Message-ID: <20170612215352.GE154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612214502.xynyfswj2ipf25ah@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612214502.xynyfswj2ipf25ah@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12, Jeff King wrote:
> On Mon, Jun 12, 2017 at 02:34:02PM -0700, Brandon Williams wrote:
> 
> > After some discussion I realized that my 'repository object' series was getting
> > to be rather long and increase in scope.  So I've decided to break off these
> > couple patches into their own series so they can be reviewed more easily.  This
> > should also let them be merged in faster as I suspect it'll take a while for my
> > 'repository object' series to be reviewed thourouly and these couple patches
> > could result in a lot of merge conflicts as it touches a lot of files.
> > 
> > Brandon Williams (4):
> >   config: create config.h
> >   config: remove git_config_iter
> >   config: don't include config.h by default
> >   config: don't implicitly use gitdir
> 
> These all seem reasonable to me. Patch 3 made me shrug a little, because
> it seems like the majority of C files end up including it anyway. I
> suspect you could break config.h down into two files: the few things
> that everybody needs (git_config() and the few parsing functions needed
> in callbacks) and the ones for commands that actually manipulate the
> config.
> 
> That would reduce the surface area of the module that most callers look
> at, but I don't think there's a huge benefit to doing so (mostly it just
> makes re-compiling faster by decreasing the chance that a dependent
> header has changed for each file).

Yes, ultimately I think it would be a good thing to break config.c down
into at least 2 more files (the file parsing logic and the config_set
logic) but that can be done at a later point.  I started looking at
doing that now but that logic is a little more entangled than I thought
it was.

Thanks for taking a look Jeff!

-- 
Brandon Williams
