Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879771F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeCWVyx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:54:53 -0400
Received: from giant.haxx.se ([80.67.6.50]:59996 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752066AbeCWVyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:54:46 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2018 17:54:45 EDT
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id w2NLlfte016040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Mar 2018 22:47:41 +0100
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id w2NLlfEE016030;
        Fri, 23 Mar 2018 22:47:41 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Fri, 23 Mar 2018 22:47:41 +0100 (CET)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Loganaden Velvindron <logan@hackers.mu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Allow use of TLS 1.3
In-Reply-To: <20180323193435.GA21971@voidlinux>
Message-ID: <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
References: <20180323193435.GA21971@voidlinux>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 23 Mar 2018, Loganaden Velvindron wrote:

> +#ifdef CURL_SSLVERSION_TLSv1_3
> +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
> +#endif

Unfortunately, CURL_SSLVERSION_TLSv1_3 is an enum so this construct won't 
work.

Also, let me just point out that 7.52.0 is 0x073400 in hex and not the one 
used for the first version of this patch.

-- 

  / daniel.haxx.se
