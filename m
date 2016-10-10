Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC06120989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbcJJRxU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:53:20 -0400
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:56065 "HELO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752963AbcJJRxS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Oct 2016 13:53:18 -0400
Received: (qmail 32378 invoked by uid 0); 10 Oct 2016 17:52:28 -0000
Received: from unknown (HELO cmgw3) (10.0.90.84)
  by gproxy8.mail.unifiedlayer.com with SMTP; 10 Oct 2016 17:52:28 -0000
Received: from box531.bluehost.com ([74.220.219.131])
        by cmgw3 with 
        id ttsQ1t00p2qhmhE01tsTae; Mon, 10 Oct 2016 11:52:28 -0600
X-Authority-Analysis: v=2.1 cv=KLfJUj1o c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=CH0kA5CcgfcA:10 a=D2PNT0XgWV_Vb4ERK7cA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID;
         bh=rRn0lBlhk0JDmcmlLgb9y9xcAqBzn7crwhf68IH3BrY=; b=DYqECmyq2yej7qfWldSOxxjpo
        lT5YsZP+9SWuFu/W/5uxpI13zFUagKz7FDwYlFsq9iAG84p85vpqXc7dwBeykAsBl79pLU1WyY3Qw
        uiJV5jxP15YmELp4j7gejx3f4c;
Received: from pool-173-76-103-154.bstnma.fios.verizon.net ([173.76.103.154]:34632 helo=homebase)
        by box531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.86_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1btekS-0003io-NW; Mon, 10 Oct 2016 11:52:24 -0600
Message-ID: <1476121942.15746.99.camel@mad-scientist.net>
Subject: Re: git merge deletes my changes
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Eduard Egorov <Eduard.Egorov@icl-services.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Date:   Mon, 10 Oct 2016 13:52:22 -0400
In-Reply-To: <AM4PR03MB1636EA0DEB4C8095F04AB92ADBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
References: <AM4PR03MB1636BE3423E2BC4F0E998159DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
         <AM4PR03MB1636EA0DEB4C8095F04AB92ADBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
Organization: Please remain calm: I may be mad but I am a professional --
 Mad Scientist
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5-0ubuntu1~ubuntu16.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box531.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 173.76.103.154
X-Exim-ID: 1btekS-0003io-NW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-173-76-103-154.bstnma.fios.verizon.net (homebase) [173.76.103.154]:34632
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTMxLmJsdWVob3N0LmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-10-10 at 10:19 +0000, Eduard Egorov wrote:
> # ~/gitbuild/git-2.10.1/git merge -s subtree --squash ceph_ansible
> 
> Can somebody confirm this please? Doesn't "merge -s subtree" really
> merges branches?

I think possibly you're not fully understanding what the --squash flag
does... that's what's causing your issue here, not the "-s" option.

A squash merge takes the commits that would be merged from the origin
branch and squashes them into a single patch and applies them to the
current branch as a new commit... but this new commit is not a merge
commit (that is, when you look at it with "git show" etc. the commit
will have only one parent, not two--or more--parents like a normal merge
commit).

Basically, it's syntactic sugar for a diff plus patch operation plus
some Git goodness wrapped around it to make it easier to use.

But ultimately once you're done, Git has no idea that this new commit
has any relationship whatsoever to the origin branch.  So the next time
you merge, Git doesn't know that there was a previous merge and it will
try to merge everything from scratch rather than starting at the
previous common merge point.

So either you'll have to use a normal, non-squash merge, or else you'll
have to tell Git by hand what the previous common merge point was (as
Jeff King's excellent email suggests).  Or else, you'll have to live
with this behavior.
