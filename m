Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F852209A9
	for <e@80x24.org>; Fri, 14 Oct 2016 01:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756421AbcJNBrF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 21:47:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51334 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753233AbcJNBrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 21:47:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 30E7D209A9;
        Fri, 14 Oct 2016 01:46:27 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Mathieu Arnold <mat@FreeBSD.org>
Cc:     =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH 0/2] git-svn: implement "git worktree" awareness
Date:   Fri, 14 Oct 2016 01:46:21 +0000
Message-Id: <20161014014623.15223-1-e@80x24.org>
In-Reply-To: <20161013205555.GA599@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc Jakub since gitweb could probably take advantage of get_record
from the first patch, too.  I'm not completely sure about the API
for this, though.

The following changes since commit 3cdd5d19178a54d2e51b5098d43b57571241d0ab:

  Sync with maint (2016-10-11 14:55:48 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-wt

for you to fetch changes up to 112423eb905cf28c9445781a7647ba590d597ab3:

  git-svn: "git worktree" awareness (2016-10-14 01:36:12 +0000)

----------------------------------------------------------------
Eric Wong (2):
      git-svn: reduce scope of input record separator change
      git-svn: "git worktree" awareness

 git-svn.perl              | 13 +++++++------
 perl/Git.pm               | 16 +++++++++++++++-
 perl/Git/SVN.pm           | 24 +++++++++++++++---------
 perl/Git/SVN/Editor.pm    | 12 +++++-------
 perl/Git/SVN/Fetcher.pm   | 15 +++++----------
 perl/Git/SVN/Migration.pm | 37 ++++++++++++++++++++++---------------
 6 files changed, 69 insertions(+), 48 deletions(-)
-- 
EW

