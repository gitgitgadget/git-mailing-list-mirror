Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CCA203BD
	for <e@80x24.org>; Wed, 26 Oct 2016 20:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934543AbcJZUCu (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 16:02:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40862 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932244AbcJZUCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 16:02:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 86CDE2022A;
        Wed, 26 Oct 2016 20:02:48 +0000 (UTC)
Date:   Wed, 26 Oct 2016 20:02:48 +0000
From:   Eric Wong <e@80x24.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Mathieu Arnold <mat@FreeBSD.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-svn: implement "git worktree" awareness
Message-ID: <20161026200248.GA28105@starla>
References: <20161013205555.GA599@dcvr>
 <20161014014623.15223-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161014014623.15223-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> +Cc Jakub since gitweb could probably take advantage of get_record
> from the first patch, too.  I'm not completely sure about the API
> for this, though.

Jakub: ping?

+Cc: Junio, too.  I'm hoping to have this in 2.11.

> The following changes since commit 3cdd5d19178a54d2e51b5098d43b57571241d0ab:
> 
>   Sync with maint (2016-10-11 14:55:48 -0700)
> 
> are available in the git repository at:
> 
>   git://bogomips.org/git-svn.git svn-wt
> 
> for you to fetch changes up to 112423eb905cf28c9445781a7647ba590d597ab3:
> 
>   git-svn: "git worktree" awareness (2016-10-14 01:36:12 +0000)
> 
> ----------------------------------------------------------------
> Eric Wong (2):
>       git-svn: reduce scope of input record separator change
>       git-svn: "git worktree" awareness
> 
>  git-svn.perl              | 13 +++++++------
>  perl/Git.pm               | 16 +++++++++++++++-
>  perl/Git/SVN.pm           | 24 +++++++++++++++---------
>  perl/Git/SVN/Editor.pm    | 12 +++++-------
>  perl/Git/SVN/Fetcher.pm   | 15 +++++----------
>  perl/Git/SVN/Migration.pm | 37 ++++++++++++++++++++++---------------
>  6 files changed, 69 insertions(+), 48 deletions(-)
