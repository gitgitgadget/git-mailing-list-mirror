Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B79720986
	for <e@80x24.org>; Mon, 10 Oct 2016 15:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbcJJPLU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 11:11:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33176 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbcJJPLU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 11:11:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4A4E720986;
        Mon, 10 Oct 2016 15:11:18 +0000 (UTC)
Date:   Mon, 10 Oct 2016 15:11:18 +0000
From:   Eric Wong <e@80x24.org>
To:     Ian Kelling <ian@iankelling.org>
Cc:     git@vger.kernel.org
Subject: Re: How to watch a mailing list & repo for patches which affect a
 certain area of code?
Message-ID: <20161010151118.GA19486@starla>
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Kelling <ian@iankelling.org> wrote:
> I've got patches in various projects, and I don't have time to keep up
> with the mailing list, but I'd like to help out with maintenance of that
> code, or the functions/files it touches. People don't cc me. I figure I
> could filter the list, test patches submitted, commits made, mentions of
> files/functions, build filters based on the code I have in the repo even
> if it's been moved or changed subsequently. I'm wondering what other
> people have implemented already for automation around this, or general
> thoughts. Web search is not showing me much.

For the mailing list, you can try following an Atom feed for
any specific search query.
https://public-inbox.org/git/?q=FILE_OR_FUNCTION&x=A
(the "x=A" makes it an Atom feed)

It's all still a work-in-progress but there'll be better
filename and diff handling in public-inbox soon.


It's all AGPL and the data is only sourced from this mailing
list, so 100% reproducible as I'm incapable of running a
reliable server :>   Clone instructions at the bottom of
https://public-inbox.org/git/
