Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_CHARSET_FARAWAY,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3705C1F42D
	for <e@80x24.org>; Mon, 28 May 2018 13:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939056AbeE1NCA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 09:02:00 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:37060 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939011AbeE1NBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 09:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZJrn5DykxoU6cSloBKxkrb5JWplaAdS6znW9nunCulI=; b=0vQ/s1fpDNHJwjDSBINX3w+kwP
        WmtAN2RWqVz28tceEurnClOcYkzZod2bvkBHjYrg1abc1r2/1PljGMMsjfipEDsqk9pdo9vh3K9jr
        0etAOqBqCF0/KG6LZQjXzzPUYR/s/o/e2OLYjLfnlpS5BbYghvjLedLood/GDTaU089GDezMIz+oH
        qBvMQbbBbEjIyvsA7ZYzc8sXD3MxmXsfCbm2MCH1Idd1AjBHVCSfcSZ8FCUWIwx/fO8nXCBXc1qFz
        l7mjDHDAxxBCyQSQleTagwkHtwuu6iGTigyxvmku5A1U/02pKVem5TV8IVHPYMp3xR4VihBYVNvFE
        w1LfNyfw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:44760 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fNHmZ-0029Q4-Oe
        for git@vger.kernel.org; Mon, 28 May 2018 09:01:53 -0400
Date:   Mon, 28 May 2018 09:00:00 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: does a new repo actually *need* default template content?
Message-ID: <alpine.LFD.2.21.1805280836140.10191@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1444446328-1527512403=:10191"
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1444446328-1527512403=:10191
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT


  (apologies for more pedantic nitpickery, just little things i'm
running across in my travels. aside: i actually teach git courses, so
it's a bit embarrassing that i don't know some of this stuff. *sigh*.)

  running on fully-updated fedora 28 system:

  $ git --version
  git version 2.17.0
  $

  is there anything in /usr/share/git-core/templates/ that is actually
*essential* when initializing a new repo? this is what's in my
directory by that name:

  ÜÄÄ branches
  ÜÄÄ description
  ÜÄÄ hooks
  Åöö ÜÄÄ applypatch-msg.sample
  Åöö ÜÄÄ commit-msg.sample
  Åöö ÜÄÄ fsmonitor-watchman.sample
  Åöö ÜÄÄ post-update.sample
  Åöö ÜÄÄ pre-applypatch.sample
  Åöö ÜÄÄ pre-commit.sample
  Åöö ÜÄÄ prepare-commit-msg.sample
  Åöö ÜÄÄ pre-push.sample
  Åöö ÜÄÄ pre-rebase.sample
  Åöö ÜÄÄ pre-receive.sample
  Åöö ÑÄÄ update.sample
  ÑÄÄ info
      ÑÄÄ exclude

but none of that above looks critically important.

  "man gitrepository-layout" describes the "branches" directory as
"slightly deprecated", the default description file has a generic
"Unnamed repository" message but, hey, so does the git source code
repo itself, the hooks are all "commented out", and the info/exclude
file effectively has no content, so i'm guessing that nothing there
actually needs to be used to populate a new repo via "git init",
correct?

  under the circumstances, then, should it be a viable option to
initialize a new repo while specifying you want *no* initial template
content? it appears you can do that just by specifying a bogus
template directory (or even /dev/null) with "--template=", but that
generates a "warning" -- does a selection like that even merit a
"warning" if it's clear that's what i'm trying to do?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-1444446328-1527512403=:10191--
