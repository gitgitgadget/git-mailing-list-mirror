Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041A620248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfC2NEZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:04:25 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:54348 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfC2NEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NzEMw+TINbUYfZE4sAdAYO3JphJ5vBB223kwJtlkURc=; b=DgnWtaR01STfcpIycg4jCUB0U
        zEncGpvRSVUlqT5vWHXdF3M3UqQiGoTy8VSZtivDxV8xcPiXVUqNcl9OEHK3cRl4oPcwNigdPJ3nz
        p0hQCONSyh9T48C9Q3b5pVtENQEAqLGCCoN0ydQepTT4awijT5+C1DQhdQcTgZBMKAfg3n2EO+Tdn
        6mzMGbnTZDGiE1a4LBXDNmSrau5sCNdf9jA2foVuXBYU9SymYX5xtzvYN+mfAAywCwqMUh2NZZ7h7
        /7NxY/AZSpupldZETaVCitmLla1eeuKopkuMG9kfzXXT3s2Ky1PaxrGl0aUzdxSbBgn7G2Ea6g7Pe
        chiiFlV9w==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.114.104.32]:54852 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h9rBF-0007WY-Sn; Fri, 29 Mar 2019 09:04:22 -0400
Date:   Fri, 29 Mar 2019 09:04:20 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Peter Toye <git@ptoye.com>
cc:     git@vger.kernel.org
Subject: Re: A puzzling omission from the Git book
In-Reply-To: <373066205.20190329125548@ptoye.com>
Message-ID: <alpine.LFD.2.21.1903290903430.14340@localhost.localdomain>
References: <373066205.20190329125548@ptoye.com>
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

On Fri, 29 Mar 2019, Peter Toye wrote:

> I'm looking for a way of comparing the files in two branches.
> According to Stack Overflow there's a git diff command but I can't
> see any reference to it in the book. Am I being more than usually
> thick?

  it should be just

  $ git diff <branch1> <branch2> -- <filename>

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
