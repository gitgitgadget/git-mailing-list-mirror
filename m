Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABF1211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 12:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLBMIu (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 07:08:50 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:60580 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbeLBMIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 07:08:49 -0500
X-Greylist: delayed 1077 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2018 07:08:49 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uJ1dB4LmFL/RuPDA5PPQIzZwKBSqvSSKcqpkmm70XlA=; b=ug75hJjI/LSevRD+6ziXwl1rNW
        Zn7D0hv2jObbh2/8hKwu/2Uh2S68fGrNKD18pqEpdsXl3c3SAnB2PNdLqe8cmzSiPTRsGtom81BPS
        0Gc2KO9UEbykHoT4w+1d6WeXdNJHxEUpQLM3aE6CdohqnJN1EgBonDChi3KIC220ujSJ3ilk6Qg2+
        p8sCJaD6hKMTWgd0/5zS49va9yW6aRf1MUIUwmcLKkYt3IqHFl6h/Z/vhM2ybLr8+hocFwcmbx51B
        15YdLB8CaroGr4Oiov3+xAKltKWyOp3nOXD0ygAZLhgdqPtL4y4GKekPS24it0ZRccO4h8KJwKEZ1
        nuDh3E7Q==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:53652 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gTQGu-0000Xl-P2
        for git@vger.kernel.org; Sun, 02 Dec 2018 06:50:49 -0500
Date:   Sun, 2 Dec 2018 06:50:47 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: easy way to demonstrate length of colliding SHA-1 prefixes?
Message-ID: <alpine.LFD.2.21.1812020647440.32023@localhost.localdomain>
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


  as part of an upcoming git class i'm delivering, i thought it would
be amusing to demonstrate the maximum length of colliding SHA-1
prefixes in a repository (in my case, i use the linux kernel git repo
for most of my examples).

  is there a way to display the objects in the object database that
clash in the longest object name SHA-1 prefix; i mean, short of
manually listing all object names, running that through cut and sort
and uniq and ... you get the idea.

  is there a cute way to do that? thanks.

rday
