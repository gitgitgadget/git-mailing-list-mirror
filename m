Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20650C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94072073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgC3Qjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:39:44 -0400
Received: from cpanel7.indieserve.net ([199.212.143.8]:39599 "EHLO
        cpanel7.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgC3Qjo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:39:44 -0400
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:46136 helo=localhost.localdomain)
        by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1jIxRu-00GenY-VE; Mon, 30 Mar 2020 12:39:43 -0400
Date:   Mon, 30 Mar 2020 12:39:40 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why "Not currently on any branch" but no "HEAD detached"?
In-Reply-To: <xmqq8sjhajp2.fsf@gitster.c.googlers.com>
Message-ID: <alpine.LFD.2.21.2003301238040.15750@localhost.localdomain>
References: <alpine.LFD.2.21.2003301211330.14880@localhost.localdomain> <xmqq8sjhajp2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 30 Mar 2020, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >   probably a silly question (and probably related to using an old
> > version of git), but on a ubuntu 16.04.6 dev system, i used google's
> > "repo" tool to check out a bunch of git repos, and when i pop into
> > those git repos and run "git status", i see:
> >
> >   # Not currently on any branch
> >   nothing to commit, working tree clean
> >
> > i'm used to seeing "HEAD detached at <something>" ... is the above
> > just an older style of the same message, given that this system uses
> > git 2.9.2? or is there something else going on here?
>
> b397ea48 (status: show more info than "currently not on any branch",
> 2013-03-13) is the culprit.  We used to just say the HEAD was
> detached, but for the past 7 years or so, when we know the last
> branch we were on before detaching, we report the name of the
> branch.

  got it, thanks.

rday
