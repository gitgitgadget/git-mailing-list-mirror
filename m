Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A72C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FED2073E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD3TOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:14:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57514 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD3TOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:14:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6D46A1F9E0;
        Thu, 30 Apr 2020 19:14:43 +0000 (UTC)
Date:   Thu, 30 Apr 2020 19:14:43 +0000
From:   Eric Wong <e@yhbt.net>
To:     chaya shetty <chaya.s1010@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git svn clone throws Svndiff data contains backward-sliding
 source view error
Message-ID: <20200430191443.GA13725@dcvr>
References: <CAM9H1uHoB1AQ_z+qrr2a0BXZpB_c=qg4kXVqB1QcnXyhQkAEBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM9H1uHoB1AQ_z+qrr2a0BXZpB_c=qg4kXVqB1QcnXyhQkAEBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

chaya shetty <chaya.s1010@gmail.com> wrote:
> Hi team,
> 
> I am trying to migrate my SVN project to git, using simple git svn
> clone command. The conversion stops at some revision with error:
>  0 [main] perl 2287 cygwin_exception::open_stackdumpfile: Dumping
> stack trace to perl.exe.stackdump
> 
> So, I tried to resume the migration using git svn fetch. It runs for
> few minutes and again stops with the below error:
> Svndiff data contains backward-sliding source view: Svndiff has
> backwards-sliding source views at C:/Program
> Files/Git/mingw64/share/perl5/Git/SVN/Ra.pm line 312.

That looks like an error thrown from the SVN libraries which
git-svn uses.  Perhaps contacting SVN developers can help,
since it's nothing I've seen before.

I also have no idea about the quality of libsvn, Perl, or
git-svn on cygwin or any Windows builds.  Would you happen to
have a Linux or *BSD machine to try "git svn clone" on?

Thanks
