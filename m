Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F159E20248
	for <e@80x24.org>; Wed,  6 Mar 2019 14:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfCFOot (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 09:44:49 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:44404 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfCFOos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 09:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mZgux1IWy5PDcjlIHvMcq5Blc41ZEI3BDlEq9fBJqv0=; b=LyiF2tUbxpyzTLwj95iDLxv1bp
        HrL24aCxIBvj25xHp6VcO26oBlaQ6KZzgKM3D/ImnNuZ4bs8Lnf27UlZDc7O7WpEtOqJ8hZcJCtoK
        akzB9VTCWSOuE2zl1n7R0OqRF5yN6y+8THA8burZoy3yRPeCCXKkb1rdnzHDY1HBH4O4U5JIdkrKj
        lsQ19Sg9N0SfjFtgNR+56njbU1n+4ckNh2kpD3VrIf62mKKp11CovnJgIy89Ngu1UeMXjRmw3WcQs
        hQMkJ/wG3cHNiWKWGrvEysByLHxBFV2GsveLB+A8O18eUGnNp25FWTzIWp+7lAwxrhS03pkMPCilz
        6iFQ3EjA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:50222 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h1Xmn-003yiX-F7
        for git@vger.kernel.org; Wed, 06 Mar 2019 09:44:46 -0500
Date:   Wed, 6 Mar 2019 09:44:44 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: did we ever resolve what "known to Git" should mean?
Message-ID: <alpine.LFD.2.21.1903060940470.6367@localhost.localdomain>
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


  going back to a couple threads:

https://marc.info/?l=git&m=151048015116473&w=2
https://marc.info/?l=git&m=152690160605723&w=2

and i'm going to try to clarify what (if anything) was decided
regarding the internally inconsistent phrase "known to Git." junio's
take on this here:

https://marc.info/?l=git&m=152695527902711&w=2

was to banish the phrase entirely in favour of some combination of
"tracked" and/or "added to the index."

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
