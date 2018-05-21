Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFCE1F51C
	for <e@80x24.org>; Mon, 21 May 2018 15:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeEUPun (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 11:50:43 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:55784 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeEUPuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 11:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NoNUYy0ZcLMSZIf5nsTAwA/ODRnEWFYQcuAntOM+AZ8=; b=V4nBc9VuoHLZnk0BHkS6EdKEd
        kuMQeBqzwmB1T+ELqABybDIxVCY5d6Ie3mXnMqdk4IS16YFdBHE6ZYX5VtAbkPTF9CgvYgLwBI+Rt
        yZ6SqSdgq/BdGPooCWgMegtOWLwgVZPOpLxErFwpSEjnEZe9ComS3fae+/59XMS7VcuWD92oPs0Xz
        xiT+Gmiz80Emc/dVr5jcYxQ9qhX3fS+WFg1MWbG93lT6j+RDUGCc9KUt4yhjoK7JSoiUFuSw9XUTc
        R2/9ba/hyS8+IrRRY9euJ6ZgtBZ8KDBvz37LcByMFxEr2hGgYQISPQSBudWVaTxi51f2MXxGM/lpM
        W6VFro1Ig==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:51974 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKn51-00GFHM-SV; Mon, 21 May 2018 11:50:37 -0400
Date:   Mon, 21 May 2018 11:49:04 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
In-Reply-To: <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805211148340.17797@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
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

On Mon, 21 May 2018, Elijah Newren wrote:

> Hi Robert,
>
> On Mon, May 21, 2018 at 4:18 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   updating my git courseware and, since some man pages refer to files
> > "known to git", i just want to make sure i understand precisely which
> > files those are. AIUI, they would include:
> >
> >   * tracked files
> >   * ignored files
> >   * new files which have been staged but not yet committed
> >
> > is that it? are there others?
>
> Doesn't the first category of yours include the third?  I always
> read 'tracked' as 'in the index'.

 you're right, i was being redundant.

rday
