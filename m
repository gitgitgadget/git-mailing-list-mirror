Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18BA20970
	for <e@80x24.org>; Sat,  8 Apr 2017 15:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdDHPDK (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 11:03:10 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:33140 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbdDHPDI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 11:03:08 -0400
Received: from [192.168.42.152] (dslb-188-102-145-188.188.102.pools.vodafone-ip.de [188.102.145.188])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 8DE53303528;
        Sat,  8 Apr 2017 17:03:06 +0200 (CEST)
To:     peff@peff.net (Jeff King), jacob.keller@gmail.com (Jacob Keller)
Cc:     matt@mattmccutchen.net (Matt McCutchen), git@vger.kernel.org (git)
In-Reply-To: <20170408093133.acilrs5lc3kxzpmu@sigill.intra.peff.net>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Sat, 8 Apr 2017 17:03:06 +0200
Message-ID: <1n469ch.1maczdmz3p8f2M%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:

> I think Matt's point is just that the default, to use origin/branch, is
> unsafe. It's convenient when you don't have extra fetches, but that
> convenience may not be worth the potential surprise.

I don't think "surprise" is the right word here. The point of
--force-with-lease is to provide a guarantee, so if you can't trust the
guarantee, it makes the feature rather pointless.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
