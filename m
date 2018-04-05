Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B605B1F42D
	for <e@80x24.org>; Thu,  5 Apr 2018 19:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeDEToW (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:44:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33858 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752843AbeDEToW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:44:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D1FFD1F404;
        Thu,  5 Apr 2018 19:44:21 +0000 (UTC)
Date:   Thu, 5 Apr 2018 19:44:21 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] git-svn: allow empty email-address using authors-prog
 and authors-file
Message-ID: <20180405194421.GA25243@80x24.org>
References: <20180320220743.GA17234@whir>
 <20180324102046.8840-1-asheiduk@gmail.com>
 <20180405075113.3y6a5nadijswt7pm@untitled>
 <e2234113-52cf-1443-5abb-70a595037f30@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2234113-52cf-1443-5abb-70a595037f30@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> wrote:
> Am 05.04.2018 um 09:51 schrieb Eric Wong:
> > Can you confirm it's OK for you?  Thanks.
> 
> Looks good, works for me.
> 
> Do you squash this patch with with my commit or do you need a reroll?

Nope, no need to reroll.  Pushed to my repo for Junio.  Thanks all.

The following changes since commit 468165c1d8a442994a825f3684528361727cd8c0:

  Git 2.17 (2018-04-02 10:13:35 -0700)

are available in the Git repository at:

  git://bogomips.org/git-svn.git svn/authors-prog-2

for you to fetch changes up to cb427e9eb0243fe7a1a22ea3bd0a46b7410c0bf3:

  git-svn: allow empty email-address using authors-prog and authors-file (2018-04-05 19:22:06 +0000)

----------------------------------------------------------------
Andreas Heiduk (2):
      git-svn: search --authors-prog in PATH too
      git-svn: allow empty email-address using authors-prog and authors-file

 Documentation/git-svn.txt       | 13 ++++++++++---
 git-svn.perl                    |  3 ++-
 perl/Git/SVN.pm                 | 13 ++++++-------
 t/t9130-git-svn-authors-file.sh | 14 ++++++++++++++
 t/t9138-git-svn-authors-prog.sh | 26 +++++++++++++++++++++++++-
 5 files changed, 57 insertions(+), 12 deletions(-)
