Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B8B20193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964845AbcJ0UvR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:51:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39152 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbcJ0UvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:51:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DB26B20193;
        Thu, 27 Oct 2016 20:51:15 +0000 (UTC)
Date:   Thu, 27 Oct 2016 20:51:15 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Gavin Lambert <github@mirality.co.nz>
Subject: Re: [PATCH] git-svn: do not reuse caches memoized for a different
 architecture
Message-ID: <20161027205115.GA5706@starla>
References: <653aa0cd566a2486bbc38cfd82ddfcfdfe48271c.1477398004.git.johannes.schindelin@gmx.de>
 <20161025212357.GA8683@starla>
 <xmqqmvhp60gp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvhp60gp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Just peeking from the sideline, but the your squash looks like an
> improvement to me.

Thanks.

> Hopefully the final version after your interaction with Dscho can
> come to me via another "pull this now"?

Not sure if I'll be online the next few days,
but I've preeptively pushed the patch + squash to my repo:

The following changes since commit 2cc2e70264e0fcba04f9ef791d144bbc8b501206:

  Eleventh batch for 2.11 (2016-10-26 13:28:47 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-cache

for you to fetch changes up to a2c761ce5b7a5fd8b505b036f3509a9e6617dee8:

  git-svn: do not reuse caches memoized for a different architecture (2016-10-27 20:17:36 +0000)

----------------------------------------------------------------
Gavin Lambert (1):
      git-svn: do not reuse caches memoized for a different architecture

 perl/Git/SVN.pm | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)
