Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15ECD1F406
	for <e@80x24.org>; Wed, 20 Dec 2017 02:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdLTCak (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 21:30:40 -0500
Received: from dogben.com ([172.104.80.166]:45490 "EHLO dogben.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752829AbdLTCaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 21:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dogben.com;
         s=main; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eFQn03TbpIXK1Wt/zAz42doOIItAPQtaRLII8V2y8g0=; b=SptAKYSn3eqHubdntv/grW7ggb
        r4Ge6BDPsam7mwlkw42TQ5xSOdmotAPEFJJiDQAy78956SNB+sVt5SVBgvHmz9H5aCJEPIEuwR+4p
        nDNRNQo9NZ8Hmus4bWOZKIUw656XoB8L/wDMXnvQzKzYMojK8ELFZ0mySQ3m6qHBpP+S2q10hqzf0
        eME0GuIIYJwx/F6DMGi2Q9fGh9/2F8wDZ86wuhMBdMei47oqGlbXZsi6mhEvFAEivEEesakMA+ZUm
        HZZ7XJBhv7cm7bSSzF/7vO73gnC/gqoHFLOTilN3Y4hJ6bzs1nyl4tq0PRJscrCpCYgQv6LXV16GR
        gy+VevUQ==;
Received: from dogben.com ([2400:8902::f03c:91ff:febc:5721] helo=v4.dogben.com)
        by dogben.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_RC4)
        (envelope-from <wsy@dogben.com>)
        id 1eRU9U-0002eh-Gc; Wed, 20 Dec 2017 02:30:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Dec 2017 10:30:34 +0800
From:   Wei Shuyu <wsy@dogben.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: support CURLPROXY_HTTPS
In-Reply-To: <a572179929e666e4e598930ec774c4db@dogben.com>
References: <20171219172401.5263-1-wsy@dogben.com>
 <20171219205807.GC240141@aiede.mtv.corp.google.com>
 <a572179929e666e4e598930ec774c4db@dogben.com>
Message-ID: <a67c7c12ddbf3389dcc45ca09b4c5247@dogben.com>
X-Sender: wsy@dogben.com
User-Agent: Roundcube Webmail/1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-12-20 10:22, Wei Shuyu wrote:

> CURLPROXY_HTTPS is intended for run-time detection. I don't think it's 
> a
> good idea to use it with #ifdef.

s/CURLPROXY_HTTPS/CURL_VERSION_HTTPS_PROXY/
