Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911131F404
	for <e@80x24.org>; Thu,  4 Jan 2018 21:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeADVgA (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 16:36:00 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:51006 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751952AbeADVf7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Jan 2018 16:35:59 -0500
Received: from cmgw3 (unknown [10.0.90.84])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 2550B1E0C19
        for <git@vger.kernel.org>; Thu,  4 Jan 2018 14:35:59 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw3 with 
        id uMbv1w00i0QvKlu01MbyDb; Thu, 04 Jan 2018 14:35:59 -0700
X-Authority-Analysis: v=2.2 cv=XM9AcUpE c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=RgaUWeydRksA:10 a=NWsfIfihjtjy2bSpYMoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IIev3IfjeM1aCDLsHKSJTMN9XkRVOQ3bZQqp//y/Tmg=; b=KF9u/yD1kDPDUIPLoVs65t08RA
        wmAz9h8PWrrNsI3I1QpJ5YXEPTC5fFNn8WNgJhw/2cC9h15Io2jp/khsBmh8J91P+zVokIojcQT1u
        UbESrZU6Gw9ux9FDjnzegFYVh;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:59482 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <paul@mad-scientist.net>)
        id 1eXDB5-004L9M-Gw; Thu, 04 Jan 2018 14:35:55 -0700
Message-ID: <1515101753.2717.690.camel@mad-scientist.net>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Date:   Thu, 04 Jan 2018 16:35:53 -0500
In-Reply-To: <20180104201804.GE2641@hank>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
         <1514567611.3270.28.camel@mad-scientist.net> <20180104201804.GE2641@hank>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 74.104.137.100
X-Exim-ID: 1eXDB5-004L9M-Gw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:59482
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2018-01-04 at 20:18 +0000, Thomas Gummerer wrote:
> On 12/29, Paul Smith wrote:
> > On Thu, 2017-12-28 at 20:30 -0800, Junio C Hamano wrote:
> > >   * The way "git worktree add" determines what branch to create
> > > from where and checkout in the new worktree has been updated a
> > > bit.
> > 
> > Does this include the enhancements published a few weeks ago to
> > allow worktrees to be created directly from remote branches without
> > first checking out the branch locally? I'm really looking forward
> > to that change...
> 
> Yes, this release will include that.  It would be awesome if you
> could test the rc, now is the best time to scream if something about
> it is not as you'd expect :)

OK, I pulled and built this locally, and indeed the straightforward
"git worktree add <path> <branch>" works just as I'd hoped!  Nice!

I'll play with it more and let you know if I hit issues.
