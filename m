Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_40,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B94C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B5C61493
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhFOOka (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:40:30 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.210]:43071 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbhFOOka (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Jun 2021 10:40:30 -0400
X-Greylist: delayed 1307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 10:40:29 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 73327400C9C5E
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:16:37 -0500 (CDT)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id t9rplm3YEMGeEt9rplWYeY; Tue, 15 Jun 2021 09:16:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mJ2398p6At7lXUpdi5Sn44mtmfXLJPGjsOI18tjIK8Q=; b=Yjpb1vZiAVPpdInNuFrr+YJlaU
        UZFC01yqPNgWEWYcJipx2TWtQmti5ZW0i0J/XmKiD7NNVUdAta1V5qzEY0alGdWnbL8ICc8MlHgJN
        YjsHJkoZEtNwfWTVJQx2UYw6g;
Received: from pool-96-233-64-159.bstnma.fios.verizon.net ([96.233.64.159]:40516 helo=pdslaptop.home.arpa)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <paul@mad-scientist.net>)
        id 1lt9rp-0024hC-3t
        for git@vger.kernel.org; Tue, 15 Jun 2021 08:16:37 -0600
Message-ID: <88d70774f702f32b6618c626f44b1f216e03c297.camel@mad-scientist.net>
Subject: Re: [PATCH 2/2] comments: avoid using the gender of our users
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Tue, 15 Jun 2021 10:16:36 -0400
In-Reply-To: <94ce6d7d-f923-edb3-12f5-4b11149c9f6f@gmail.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
         <20210611202819.47077-3-felipe.contreras@gmail.com>
         <94ce6d7d-f923-edb3-12f5-4b11149c9f6f@gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 96.233.64.159
X-Source-L: No
X-Exim-ID: 1lt9rp-0024hC-3t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-96-233-64-159.bstnma.fios.verizon.net (pdslaptop.home.arpa) [96.233.64.159]:40516
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2021-06-15 at 09:31 -0400, Derrick Stolee wrote:
>   but sometimes a few slip by due to habit.

Or perhaps just, "but sometimes a few slip by" ?

No need to suggest a reason IMO.

