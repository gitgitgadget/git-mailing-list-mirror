Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9431F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeCZVqv (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:46:51 -0400
Received: from giant.haxx.se ([80.67.6.50]:45002 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbeCZVqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:46:49 -0400
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id w2QLkjh2023474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Mar 2018 23:46:45 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id w2QLkjEs023469;
        Mon, 26 Mar 2018 23:46:45 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Mon, 26 Mar 2018 23:46:45 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     Loganaden Velvindron <logan@hackers.mu>, git@vger.kernel.org
Subject: Re: [PATCH v3] Allow use of TLS 1.3
In-Reply-To: <nycvar.QRO.7.76.6.1803262336070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Message-ID: <alpine.DEB.2.20.1803262340320.25724@tvnag.unkk.fr>
References: <20180326092423.GA7521@voidlinux> <nycvar.QRO.7.76.6.1803262336070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 26 Mar 2018, Johannes Schindelin wrote:

> Can we *please* also add that OpenSSL 1.1.* is required (or that cURL is 
> built with NSS or BoringSSL as the TLS backend)?

We might consider adding a way to extract that info from curl to make that 
work really good for you. There are now six TLS libraries that support TLS 1.3 
and it might be hard for git to figure out the exact situation for each 
library and keep track of these moving targets...

-- 

  / daniel.haxx.se
