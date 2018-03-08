Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEBB1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 23:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbeCHXdI (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 18:33:08 -0500
Received: from smtp1.cs.stanford.edu ([171.64.64.25]:38186 "EHLO
        smtp1.cs.Stanford.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCHXdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 18:33:08 -0500
X-Greylist: delayed 1621 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2018 18:33:08 EST
Received: from theory.stanford.edu ([171.64.78.10]:43114)
        by smtp1.cs.Stanford.EDU with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <csilvers@CS.Stanford.EDU>)
        id 1eu4by-0001EZ-7z; Thu, 08 Mar 2018 15:06:10 -0800
Received: from csilvers by theory.stanford.edu with local (Exim 4.90_1)
        (envelope-from <csilvers@CS.Stanford.EDU>)
        id 1eu4bJ-0007k0-71; Thu, 08 Mar 2018 15:05:29 -0800
From:   csilvers <csilvers@cs.stanford.edu>
To:     Jeff King <peff@peff.net>
CC:     avarab@gmail.com, jrnieder@gmail.com, drizzd@aon.at,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
In-reply-to: <20180303051516.GE27689@sigill.intra.peff.net> (message from Jeff
        King on Sat, 3 Mar 2018 00:15:16 -0500)
Subject: Re: [PATCH 0/4] Speed up git tag --contains
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <E1ea4Ui-0005qJ-3s@theory.stanford.edu> <20180303051516.GE27689@sigill.intra.peff.net>
Message-Id: <E1eu4bJ-0007k0-71@theory.stanford.edu>
Date:   Thu, 08 Mar 2018 15:05:29 -0800
X-Scan-Signature: 58355bea2820b4cf9b9c8322cdf0b49d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

} I had a few proposals over the years, but I won't even bother to dig
} them up, because there's quite recent and promising work in this
} area from Derrick Stolee:

It sounds like the best thing to do is to wait for this, then.

We managed to convert a bunch of our branches to tags, so our
immediate problem has been resolved.  But I'm sure it will come up
again as more branches are created...

carig
