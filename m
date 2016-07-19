Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E641FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 15:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbcGSPUj (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 11:20:39 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:11671 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbcGSPUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 11:20:38 -0400
Received: from nad.dad.org (m206-54.dsl.tsoft.com [198.144.206.54])
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTP id u6JFKUM3026844;
	Tue, 19 Jul 2016 08:20:30 -0700 (PDT)
	(envelope-from norm@dad.org)
Message-Id: <201607191520.u6JFKUM3026844@shell1.rawbw.com>
X-Authentication-Warning: shell1.rawbw.com: Host m206-54.dsl.tsoft.com [198.144.206.54] claimed to be nad.dad.org
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:	git@vger.kernel.org, norm@dad.org
Subject: Re: Question: Getting 'git diff' to generate /usr/bin/diff output
In-reply-to: Your message of "Sun, 17 Jul 2016 09:46:51 +0200."
             <alpine.DEB.2.20.1607170942580.28832@virtualbox>
Reply-To: Norman Shapiro <norm@dad.org>
From:	norm@dad.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19396.1468941629.1@nad.dad.org>
Date:	Tue, 19 Jul 2016 08:20:29 -0700
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>A better method might be to use the `git difftool` command, e.g.
>
>git difftool -x diff

Something like:

git difftool --no-prompt --extcmd=diff

or like:

git difftool --no-prompt --extcmd="diff -b" "$@"

works great for me. Thank you very much indeed!

    Norman Shapiro
