Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE6520285
	for <e@80x24.org>; Thu, 24 Aug 2017 14:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbdHXOKS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 10:10:18 -0400
Received: from giant.haxx.se ([80.67.6.50]:59022 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbdHXOKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 10:10:17 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Aug 2017 10:10:17 EDT
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id v7OE2JoS001988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2017 16:02:19 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id v7OE2JAn001983;
        Thu, 24 Aug 2017 16:02:19 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Thu, 24 Aug 2017 16:02:19 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Jeff King <peff@peff.net>
cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
In-Reply-To: <20170824135331.27wtwicjuoiyremx@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1708241554520.5192@tvnag.unkk.fr>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com> <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net> <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de> <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
 <e11d4449-8377-dbd7-3ad5-441baf7446b6@morey-chaisemartin.com> <20170824135331.27wtwicjuoiyremx@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 24 Aug 2017, Jeff King wrote:

>> I opened a bug upstream and they already fixed this. 
>> https://github.com/curl/curl/pull/1820
>
> Cool! That's much faster than I had expected. :)

Your wish is our command! =)

-- 

  / daniel.haxx.se (who landed the IMAP PREAUTH fix in curl)
