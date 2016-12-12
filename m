Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C1C1FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 11:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbcLLLNV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 06:13:21 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55242 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbcLLLNV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 06:13:21 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B30C31FF76;
        Mon, 12 Dec 2016 11:13:20 +0000 (UTC)
Date:   Mon, 12 Dec 2016 11:13:20 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PULL] minor git-svn updates (probably for 2.11.x)
Message-ID: <20161212111320.GA25451@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following changes since commit 8d7a455ed52e2a96debc080dfc011b6bb00db5d2:

  Start post 2.11 cycle (2016-12-05 11:31:47 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to 1b7edec78b754a1e901c164a4bf4e94bff96ed7b:

  git-svn: document useLogAuthor and addAuthorFrom config keys (2016-12-12 11:09:29 +0000)

----------------------------------------------------------------
Eric Wong (2):
      git-svn: allow "0" in SVN path components
      git-svn: document useLogAuthor and addAuthorFrom config keys

 Documentation/git-svn.txt | 8 +++++++-
 perl/Git/SVN/Ra.pm        | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)
