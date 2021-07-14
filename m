Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_50,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC852C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 10:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36DC610A7
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 10:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhGNKiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 06:38:09 -0400
Received: from gateway5.unifiedlayer.com ([74.220.208.104]:44323 "EHLO
        gateway5.unifiedlayer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbhGNKiI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 06:38:08 -0400
X-Greylist: delayed 1279 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2021 06:38:08 EDT
Received: from cm1.websitewelcome.com (unknown [192.185.0.102])
        by gateway5.unifiedlayer.com (Postfix) with ESMTP id 67B02200C7C9C
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:13:56 -0500 (CDT)
Received: from caprica.seoboxes.com ([129.121.177.193])
        by cmsmtp with ESMTP
        id 3btsmKSnblNqD3btsmwQpz; Wed, 14 Jul 2021 05:13:56 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=wizztraffic.com; s=default; h=MIME-Version:Content-Type:Subject:To:From:
        Message-ID:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GgTriFiMqdUzimAw853EAs/E/hiZk2UINw9u5IlUtw8=; b=Jwayqoa1yuDwp4AQ1HnrAIxZzi
        1JLmx2D821oxWVrwsq4YKJOXGJEOfDJhaq22jCs1i3FfvnWTirefH0Yi1e375L7n1ivgSFs7uvuKB
        yDIOuUNqMF47gjIKalonbv3aoU+gNVaEg17NM/rK6l/8IBjJNzHKAXVb3uqhA+jKqLXeQPSerkZqf
        1d+F5yvDTxRZBmoVBW2mzlPT1pk4Q2B7EYvg/xJsheJZ6WErJU1RFR3wmOA1XGRZEg0KpIUk8HotL
        IYdJq4ARQqQhAJ60JJKBKo7+fMtZBGFVtxXQLgmEsdKu6eGorYWL/yLYdjnNweuzt5tCaMCcT6ZV7
        MrHpR3sA==;
Received: from [::1] (port=53260 helo=caprica.seoboxes.com)
        by caprica.seoboxes.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <james@wizztraffic.com>)
        id 1m3btr-002a82-EC; Wed, 14 Jul 2021 05:13:55 -0500
Received: from 49.37.158.85 ([49.37.158.85]) by caprica.seoboxes.com (Horde
 Framework) with HTTPS; Wed, 14 Jul 2021 05:13:55 -0500
Date:   Wed, 14 Jul 2021 05:13:55 -0500
Message-ID: <20210714051355.Horde.f9sOdkVcvLfubnUw6YN7TLy@caprica.seoboxes.com>
From:   james@wizztraffic.com
To:     git@vger.kernel.org, majordomo@vger.kernel.org,
        michael@physprac.com, will@willdeacon.co.uk
Subject: Article Order on your site
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - caprica.seoboxes.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - wizztraffic.com
X-BWhitelist: no
X-Source-IP: ::1
X-Source-L: No
X-Exim-ID: 1m3btr-002a82-EC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (caprica.seoboxes.com) [::1]:53260
X-Source-Auth: james@wizztraffic.com
X-Email-Count: 4
X-Source-Cap: d2l6enRyYWZmaWM7Y2FzaW5vb247Y2FwcmljYS5zZW9ib3hlcy5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hello,

Sorry to chase, I was wondering if you had a chance to go through my  
previous email.

We are interested to post ad content on your site git.wiki.kernel.org.  
We will provide relevant quality content that includes sports betting.  
If it possible on your site we will pay you for this kind of service.  
How much you charge for the guest article?

We hopefully look forward to hearing back from you."



