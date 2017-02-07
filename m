Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07EF1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 22:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932387AbdBGWta (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 17:49:30 -0500
Received: from havoc.proulx.com ([96.88.95.61]:56196 "EHLO havoc.proulx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932122AbdBGWt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 17:49:29 -0500
Received: from joseki.proulx.com (localhost [127.0.0.1])
        by havoc.proulx.com (Postfix) with ESMTP id E873074A
        for <git@vger.kernel.org>; Tue,  7 Feb 2017 15:49:27 -0700 (MST)
Received: from hysteria.proulx.com (hysteria.proulx.com [192.168.230.119])
        by joseki.proulx.com (Postfix) with ESMTP id B3D3A21241
        for <git@vger.kernel.org>; Tue,  7 Feb 2017 15:49:27 -0700 (MST)
Received: by hysteria.proulx.com (Postfix, from userid 1000)
        id A1BF22DC5F; Tue,  7 Feb 2017 15:49:27 -0700 (MST)
Date:   Tue, 7 Feb 2017 15:49:27 -0700
From:   Bob Proulx <bob@proulx.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git-daemon shallow checkout fail
Message-ID: <20170207154512329677197@bob.proulx.com>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
References: <20170129002932.GA19359@dismay.proulx.com>
 <20170130172730.x5guphyqf5fsfi7m@sigill.intra.peff.net>
 <CACsJy8DED9WRr_T6g43bxHUGQYVnfaTx15hqSGiiajvi0TxtuA@mail.gmail.com>
 <20170206171225215133282@bob.proulx.com>
 <20170206174000357620972@bob.proulx.com>
 <CACsJy8D_X7u+kttu=ZD734u6nhR=wjMh0m99RBvm0_FOW74pWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D_X7u+kttu=ZD734u6nhR=wjMh0m99RBvm0_FOW74pWA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen wrote:
> I wonder if we should make this "git/1.9.1" information more visible. We could
> 
> 1) Always print it when cloning
> 2) Print it when cloning with -v (printing all capabilities with -v
> might not be a bad idea)
> 3) Include it in error messages when clone/fetch fails

I don't think I would want to see it all of the time.  It isn't needed
all of the time.  But having it printable upon demand is nice.  Being
able to use GIT_TRACE_PACKET=1 worked very well.  The only thing I
needed was to know it was available so that I could use it.  I am not
sure where that is documented.

Therefore if and only if a change was made I would vote for printing
only under --verbose or other explicit other information option.  I
would not add it to the normal operation output.

Bob
