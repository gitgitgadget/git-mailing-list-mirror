Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A111F454
	for <e@80x24.org>; Fri, 18 Jan 2019 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfARWbr (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:31:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43570 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbfARWbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:31:47 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 529251F453;
        Fri, 18 Jan 2019 22:31:47 +0000 (UTC)
Date:   Fri, 18 Jan 2019 22:31:47 +0000
From:   Eric Wong <e@80x24.org>
To:     Steve Keller <keller.steve@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: How to convert SVN tags to git tags?
Message-ID: <20190118223147.bcmyh4g7rxancgii@dcvr>
References: <trinity-9f702373-ab1b-4c3e-9418-894ab0a6ef5a-1547815808777@3c-app-gmx-bs22>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <trinity-9f702373-ab1b-4c3e-9418-894ab0a6ef5a-1547815808777@3c-app-gmx-bs22>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steve Keller <keller.steve@gmx.de> wrote:
> After converting from SVN to git using git svn init + git svn fetch,
> my SVN tags appear as remote branches in git.  I find many suggestions
> to convert these to git tags by calling git tag -a <tag-name> <branch-name>
> but this gives something like this

Hi Steve, instead of an annotated tag ("-a"), you can use a
lightweight tag by omitting the "-a".

Fwiw, I chose to map SVN "tags" to remote branches in git since
some projects I followed back in the day had moving tags in SVN.
