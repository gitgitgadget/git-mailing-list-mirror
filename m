Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08F61F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbeFAV5n (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:57:43 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:36992 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFAV5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nomDj+HhJhrF9huEL7wxevMFYwwLERUy8dD4FlaGFa0=; b=CIPA/dnlSrSVtm6iVmFWCpc96
        x1SgL79ozejPtG4cpCxbC6bT9qyKBvLzmpaddQXb/ckWsuLV1Shj5Cjsm6mQ0L5VH4PHO7N4gDs86
        Jofqm7GwXMQD7OL9amvTKIKuntBy4EzmEhOakeBFLmOi9TR/ZJT6Cj6+eALSIHiPigWq4ugrNYX9D
        1byi2iZr/Uc3z2ZkIIy3opfZpVaTOGNxUuTxpx5YOdMjeX6Vo6V/C5EzK/K9CNGGEoOy5+VQCxxUH
        EfjI44PcO1BVugHs8FH8HewU/Ut5p4hab71Dsug3753MiHz3Ukq5ym4Eoj/MQfEsDmRSfR6qnRiJS
        Cs95eveMA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:35580 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fOs3J-00CEYn-60; Fri, 01 Jun 2018 17:57:42 -0400
Date:   Fri, 1 Jun 2018 17:55:38 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
In-Reply-To: <20180601210731.GA20974@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1806011754510.14826@localhost.localdomain>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain> <20180601210731.GA20974@sigill.intra.peff.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 1 Jun 2018, Jeff King wrote:

> This is mentioned later:
>
>   There is also a deprecated [section.subsection] syntax. With this
>   syntax, the subsection name is converted to lower-case and is also
>   compared case sensitively. These subsection names follow the same
>   restrictions as section names.

> This has been deprecated since 2011. Maybe it's time to finally get
> rid of it.

  seven years seems sufficient for deprecation.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
