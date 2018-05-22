Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5981F51C
	for <e@80x24.org>; Tue, 22 May 2018 15:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeEVPGm (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 11:06:42 -0400
Received: from giant.haxx.se ([80.67.6.50]:51008 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeEVPGm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 11:06:42 -0400
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id w4MF6d8B001709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 May 2018 17:06:39 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id w4MF6dEV001704;
        Tue, 22 May 2018 17:06:39 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Tue, 22 May 2018 17:06:39 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Suganthi <suga18@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [curl PATCH 2/2] ignore SIGPIPE during curl_multi_cleanup
In-Reply-To: <CAG4qzjti3MRXZ_Kofbb8b6whwDw7Se8g1VAe0mcU4ZdiWRfxpQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1805221702490.6210@tvnag.unkk.fr>
References: <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net> <52922A22.2090109@googlemail.com> <20131125063945.GA16313@sigill.intra.peff.net>
 <alpine.DEB.2.00.1311250815150.27300@tvnag.unkk.fr> <20131125143213.GA22642@sigill.intra.peff.net> <20131125144321.GA23779@sigill.intra.peff.net> <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr> <1526984799739-0.post@n2.nabble.com>
 <alpine.DEB.2.20.1805221248110.6210@tvnag.unkk.fr> <CAG4qzjti3MRXZ_Kofbb8b6whwDw7Se8g1VAe0mcU4ZdiWRfxpQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 May 2018, Suganthi wrote:

> We may not be able to upgrade to 7.60.0 any soon, Is the fix present in 7.45 
> , in this sequence of code. Please let me know.

I don't know.

I can't recall any SIGPIPE problems in recent days in libcurl, which is why I 
believe this problem doesn't exist anymore. libcurl 7.45.0 is 2.5 years and 
1500+ bug fixes old after all. My casual searches for a curl problem like this 
- fixed in 7.45.0 or later - also failed.

-- 

  / daniel.haxx.se
