Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9732018E
	for <e@80x24.org>; Sat,  9 Jul 2016 23:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933178AbcGIXZG (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 19:25:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38804 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbcGIXZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 19:25:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E602018E;
	Sat,  9 Jul 2016 23:25:03 +0000 (UTC)
Date:	Sat, 9 Jul 2016 23:25:03 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Jacob Godserv <jacobgodserv@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christopher Layne <clayne@anodized.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
Message-ID: <20160709232503.GA8505@dcvr.yhbt.net>
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> * ew/svn-bad-ref (2016-07-06) 1 commit
>  - git-svn: warn instead of dying when commit data is missing

>  I'm likely to discard this, favouring a direct pull request from
>  the subsystem maintainer directly going to 'master'.

Pushed with your sign-off added, along with Christopher's patch.

I was hoping to work on the Apache 2.4 test suite fixes Michael
started working on last year this week, maybe next (or very soon)
since most of my machines are finally upgraded to Debian Jessie.

The following changes since commit cf4c2cfe52be5bd973a4838f73a35d3959ce2f43:

  Second batch of topics for 2.10 (2016-06-27 10:07:08 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to 2af7da9f8fb68337030630d88c19db512189babc:

  git-svn: warn instead of dying when commit data is missing (2016-07-09 22:53:54 +0000)

----------------------------------------------------------------
Christopher Layne (1):
      git-svn: clone: Fail on missing url argument

Eric Wong (1):
      git-svn: warn instead of dying when commit data is missing

 git-svn.perl    | 5 ++++-
 perl/Git/SVN.pm | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)
