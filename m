Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CB21F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbeGXXBE (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:01:04 -0400
Received: from s019.cyon.net ([149.126.4.28]:43838 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeGXXBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8D6QHYX69O7JnOYVCepKH9DyXy+u5jegVHXGIhodb00=; b=spkF45zYcWKmEP83Tv45bJivaC
        F3XBkNGKFqQQZDbUU6nFtH7O3ohC0XYM/bZLWfR3vpdAYWiW9mxSCLh8zvbwuSv1HR2mwb+ZQHGcT
        Zg9DTd1Lipq8yBy956D0HVeYhVsRKnZ/tSP/iXoxOr+gbIHDubNJtx94YdQvMhTqYi8ZQfQzz8lX1
        gpd+d0ArD6D5CLFLQ7rgm5kXsSew59MqVT47cqb95838Mp65NF/VTiJpzSr1WT1EwzGPbkCDqZ9ik
        OXYv2J7zBqzMtrXBOZI7JDH0wWvaANpCZHuSvJMdqj7L/wRiB25u314KqO6RbToJ2PSK6+9++oTeP
        CvnPxdsA==;
Received: from [10.20.10.233] (port=36360 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fi5EN-00B54M-FU; Tue, 24 Jul 2018 23:52:32 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 17BEA2034A; Tue, 24 Jul 2018 23:52:31 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 0/2] Pedantic fixes for Apple clang
Date:   Tue, 24 Jul 2018 23:52:21 +0200
Message-Id: <20180724215223.27516-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following up on my previous series bb/pedantic for gcc, here are two
fixes for pedantic compilation under MacOS 10.13.6 (High Sierra) with
the command line tools of Xcode Version 9.4.1 (9F2000).

Beat Bolli (2):
  packfile: drop a repeated enum declaration
  remote-odb: un-inline function remote_odb_reinit

 packfile.h   | 1 -
 remote-odb.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.18.0

