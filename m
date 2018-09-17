Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA221F404
	for <e@80x24.org>; Mon, 17 Sep 2018 11:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIQQ6o (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 12:58:44 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:41954 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeIQQ6o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 12:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uFpDsU7pRaIo7lVdmCdY/2Qc+Vf1imf7Bp9hX1I1vmw=; b=y6XXDsS1VkFpPlprybQIwP9Kub
        q8jufjKxGPGQL5KehUpFtaLFp+vYQ+5ba/QU0cb1mtdBpcurQOQc6tMSqRKwTCaJZ/eVnwh5Pu0y8
        FNGKa0/mW/mN7neR6B8ZguGwzsoarl1AMPDRfTyBIxpL5MhvlWu6cGAuBgqByQ9QzhcxfTx8e2ohi
        7xKi1Uz6yw17Nd63gOt1K+Iux5p9H59rChwUefXOmEX1OrR6n23IvUVgfycrwwsbzvVguTU7BtyXH
        1sYev6RyYKirsN/RGKVH3DTrpLlDebhjLjeMh7nHrY9edgaUoWORzNC1eKIN5A8rQqOBMhYwkX4+5
        bG4koc5g==;
Received: from [209.37.255.2] (port=35796 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1g1rkp-00Ek1y-34
        for git@vger.kernel.org; Mon, 17 Sep 2018 07:31:48 -0400
Date:   Mon, 17 Sep 2018 04:31:40 -0700 (PDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: diff between "--no-local" and "--no-hardlinks" for local clone?
Message-ID: <alpine.LFD.2.21.1809170429140.8299@localhost.localdomain>
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


  perusing "man git-clone" and, from the first part of the OPTIONS
section, it's not immediately obvious what the difference is between
using --no-local versus --no-hardlinks when cloning a local repo. both
seem to suggest that the local git transport mechanism will be used,
so what is the difference?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
