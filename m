Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803B91F731
	for <e@80x24.org>; Sat, 10 Aug 2019 22:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfHJW1I (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 18:27:08 -0400
Received: from giant.haxx.se ([80.67.6.50]:34924 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfHJW1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 18:27:08 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Aug 2019 18:27:07 EDT
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id x7AMHERj003005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 00:17:14 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id x7AMHEcY003000;
        Sun, 11 Aug 2019 00:17:14 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Sun, 11 Aug 2019 00:17:14 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     =?ISO-8859-15?Q?Carlo_Marcelo_Arenas_Bel=F3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, l.s.r@web.de, Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
In-Reply-To: <20190810220251.3684-1-carenas@gmail.com>
Message-ID: <alpine.DEB.2.20.1908110011490.26798@tvnag.unkk.fr>
References: <20190810220251.3684-1-carenas@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1129329158-1378160962-1565475342=:26798"
Content-ID: <alpine.DEB.2.20.1908110016350.26798@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1129329158-1378160962-1565475342=:26798
Content-Type: text/plain; CHARSET=ISO-8859-15; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.20.1908110016351.26798@tvnag.unkk.fr>

On Sat, 10 Aug 2019, Carlo Marcelo Arenas Belón wrote:

> tested in macOS 10.14.6 with the system provided cURL (7.54.0)
> and latest (7.65.3) and while the API used should be added starting around
> 7.12.0 (mid 2014).

Let me just gently point out that 7.12.0 was relased mid *2004*, see 
https://curl.haxx.se/docs/releases.html

-- 

  / daniel.haxx.se
--1129329158-1378160962-1565475342=:26798--
