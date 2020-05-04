Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16FCC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5BB20663
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgEDRnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:43:18 -0400
Received: from cpanel7.indieserve.net ([199.212.143.8]:44523 "EHLO
        cpanel7.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgEDRnS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 13:43:18 -0400
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:52816 helo=localhost.localdomain)
        by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1jVf7c-00E0Lx-Uc; Mon, 04 May 2020 13:43:17 -0400
Date:   Mon, 4 May 2020 13:43:15 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Simon Pieters <simon@bocoup.com>
cc:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.2005041340480.220155@localhost.localdomain>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
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

On Mon, 4 May 2020, Simon Pieters wrote:

> "master" is an offensive term, as it can be interpreted as being
> slavery-origin terminology. See
> https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_concerns
>
> The Python programming language, and various other projects, have
> taken a stance and moved away from offensive terminology including
> "master". See https://bugs.python.org/issue34605
>
> When different projects using git decide to move away from "master"
> as the name of their main branch, inconsistency ensues between
> projects. See https://github.com/desktop/desktop/issues/6478 (and
> "Related Issues and Projects").
>
> To avoid offensive terminology and to avoid further inconsistency, I
> think git should use a different branch name than "master" when
> initiating a repo. I don't have a strong opinion, but I like "main"
> since it shares the first two characters and it's shorter.

  please, no ... this is just massive and unnecessary churn, and it
opens up a ridiculous can of worms. if you change this, then of course
you will have to reword everything related to data buses that are
defined to work on a "master-slave" basis. and would you have to stop
describing your competence in a particular field as having attained a
"mastery" of the subject matter?

  this is just a bad idea.

rday
