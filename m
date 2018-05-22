Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975A01F42D
	for <e@80x24.org>; Tue, 22 May 2018 10:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeEVKuF (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 06:50:05 -0400
Received: from giant.haxx.se ([80.67.6.50]:33897 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeEVKuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 06:50:04 -0400
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id w4MAo1Tu019313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 May 2018 12:50:01 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id w4MAo1P9019299;
        Tue, 22 May 2018 12:50:01 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Tue, 22 May 2018 12:50:01 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     curlUser <suga18@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [curl PATCH 2/2] ignore SIGPIPE during curl_multi_cleanup
In-Reply-To: <1526984799739-0.post@n2.nabble.com>
Message-ID: <alpine.DEB.2.20.1805221248110.6210@tvnag.unkk.fr>
References: <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net> <52922A22.2090109@googlemail.com> <20131125063945.GA16313@sigill.intra.peff.net>
 <alpine.DEB.2.00.1311250815150.27300@tvnag.unkk.fr> <20131125143213.GA22642@sigill.intra.peff.net> <20131125144321.GA23779@sigill.intra.peff.net> <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr> <1526984799739-0.post@n2.nabble.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 May 2018, curlUser wrote:

> Again SIGPIPE is seen with curl version 7.45.0 with multi interface.
> Backtrace shows :

...

> Looks like SIGPIPE_IGNORE to be added in prune_dead connections or in 
> disconnect_if_dead? Can anyone comment on this.

I'm pretty sure this issue isn't present in any recent libcurl versions, but 
if you can reproduce it with 7.60.0, I'll be very interested.

-- 

  / daniel.haxx.se
