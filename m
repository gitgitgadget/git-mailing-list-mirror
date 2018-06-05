Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5728B1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 11:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeFELgt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 07:36:49 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:37616 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeFELgs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 07:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CFXL1ehngD9zjgji8SGNH/onDPuqUKCBm1WGcVITiNU=; b=Un9fFDa5FyFdnB8ffQx1jcw4p
        Knqz39L5hjQlCm1aFkvfTBmsFCeYfJy5MRNfQhvOykIjn0LHNEvQyW/aQsEdFu1FAcrvOBuj+Spu/
        rgrRHSoYeH7AUiLYD6+nnrEQCbf8jAxg9aSw0pt2nrNuxRbZcg911KDJJyMfL1IvH/GDjoaGwmJzl
        B4421kRY9aecho5bOkRIGTVR+ItpXlR/yU6rYTYaKpKhazdX9YGEr4gEJddR5p28clf+rJ+Tbkpw3
        zhgNS5cbFjmqwy2Gh/GTFnrSTfSQmMY0zrY8cfEK4bFxkvckhqJFp1hBhTTU6rqqTiS2lIF3P4ZbK
        xJqw3v9Bw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:57508 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fQAGc-000RL6-BT; Tue, 05 Jun 2018 07:36:47 -0400
Date:   Tue, 5 Jun 2018 07:34:35 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH] t3200-branch.sh: use "--set-upstream-to" in test
In-Reply-To: <20180605112446.17016-1-szeder.dev@gmail.com>
Message-ID: <alpine.LFD.2.21.1806050734070.11943@localhost.localdomain>
References: <alpine.LFD.2.21.1806050712270.10467@localhost.localdomain> <20180605112446.17016-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1057657054-1528198477=:11943"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1057657054-1528198477=:11943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 Jun 2018, SZEDER Gábor wrote:

> > Change deprecated "--set-upstream" branch option to
> > preferred "--set-upstream-to".
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> >   i'm assuming this should use "--set-upstream-to" as do all the
> > others.
>
> I don't think so, see 52668846ea (builtin/branch: stop supporting
> the "--set-upstream" option, 2017-08-17).

  yes, you're right, i didn't look at the context enough. my bad.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-1057657054-1528198477=:11943--
