Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFCFC2018F
	for <e@80x24.org>; Sun, 17 Jul 2016 23:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbcGQXUi (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 19:20:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55838 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbcGQXUh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 19:20:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64272018F;
	Sun, 17 Jul 2016 23:20:35 +0000 (UTC)
Date:	Sun, 17 Jul 2016 23:20:35 +0000
From:	Eric Wong <e@80x24.org>
To:	Alexandre Bique <bique.alexandre@gmail.com>
Cc:	git@vger.kernel.org, Ioannis Kappas <Ioannis.Kappas@rbs.com>
Subject: Re: git-svn dies all the time
Message-ID: <20160717232035.GC8569@starla>
References: <CAP737oJOGzcgd547R4Qyo832LtGQPZhLtCPS5tr3F8Ot+pxH7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP737oJOGzcgd547R4Qyo832LtGQPZhLtCPS5tr3F8Ot+pxH7w@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Alexandre Bique <bique.alexandre@gmail.com> wrote:
> Hi,
> 
> I did by mistake report the bug here:
> 
> https://github.com/git/git-scm.com/issues/807#issuecomment-233200404
> 
> In short this is a backtrace of git svn rebase crashing in perl, and
> likely because of an out of memory issue. It crashed on my laptop but
> not on my desktop (4G of RAM vs 16G of RAM).

This might be the same bug in SVN Ioannis (cc-ed) told us about
a few weeks ago:

https://public-inbox.org/git/0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net/T/

Curious, which version of SVN bindings are you using?
("git svn --version" should tell you)
