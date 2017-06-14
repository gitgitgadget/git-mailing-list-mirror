Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6C31FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 01:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbdFNBM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 21:12:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40094 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752854AbdFNBM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 21:12:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 443A31FA7B;
        Wed, 14 Jun 2017 01:12:56 +0000 (UTC)
Date:   Wed, 14 Jun 2017 01:12:56 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] public-inbox.org/git/ search updates for diffs
Message-ID: <20170614011256.GA30257@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all,

https://public-inbox.org/git/_/text/help has a few new prefixes
which might help improve searching:

        dfn:     match filename from diff
        dfa:     match diff removed (-) lines
        dfb:     match diff added (+) lines
        dfhh:    match diff hunk header context (usually a function name)
        dfctx:   match diff context lines
        dfpre:   match pre-image git blob ID
        dfpost:  match post-image git blob ID
        dfblob:  match either pre or post-image git blob ID

The blob ID searches should work down to 7 characters right now.

I updated the xapian indices in place ( "public-inbox-index --reindex" ),
so it should've happened without a service interruption.

Probably a couple more changes on the way this month depending
on my schedule and workload on other stuff.
