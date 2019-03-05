Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DE120248
	for <e@80x24.org>; Tue,  5 Mar 2019 14:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfCEOFF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 09:05:05 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:60570 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCEOFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 09:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LeOJrUtcmcriWVY+UeqNuz5k+tyPliCXGU/vH0loTeE=; b=zei+CiV/6Ze2BpAUWFbyncAnX
        v5WZnhLLx4uoY3X7z189vq+1wYsMeuM8Tv0sTisi6g2Mk4ryeIn3CTTfu1vvfuCou2zr+QxJ2SqW8
        F6WmqCeA0e9r5UAHbykPJ0zbispvaPqz0CVWY5Gc/o/FFs8YlTO8HenZ8Q91gw59c+1nfLUfqkUWu
        5x/f/wPNr0c0CKSRmskx/t4O56BB3o7Z+HioPUqRintqXm2W5N3QQk3CyW8hNrMRz+avM0RDlhDao
        pnsrAKB13UPzjhHbxxi1vjotMpcg7K8PktWUq07j4hxgc6AVyA3axA33u2g/KAK+sH7sSkp6E0ns/
        +voTbOI1A==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:57942 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h1Agl-00H7W4-AE; Tue, 05 Mar 2019 09:05:02 -0500
Date:   Tue, 5 Mar 2019 09:04:56 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc/rebase: extend examples to show continuing
 branches
In-Reply-To: <xmqqr2blto3k.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1903050904350.30374@localhost.localdomain>
References: <alpine.LFD.2.21.1903050545460.24324@localhost.localdomain> <xmqqr2blto3k.fsf@gitster-ct.c.googlers.com>
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

On Tue, 5 Mar 2019, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> > Currently, all of the examples for "man git-rebase" show rebasing from
> > a branch that has had no further development, which might mislead
> > readers into thinking that that is a necessary condition for rebasing,
> > so tweak the examples to show further development on such a branch to
> > clarify that.
>
> We state the status-quo in present tense to start problem
> description, so "Currently" is a noise word you can and should omit.
>
> As I already said, at least one example that rebases a branch that
> was forked from the midpoint of another branch, so the problem
> description is already false.  If we apply this patch, do we lose
> all examples that rebase a branch that purely builds on top of the
> tip of another branch?  That would also mislead readers into
> thinking that you need to advance the base branch before you can
> rebase the forked branch ;-).

  i stand corrected. carry on. :-)

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
