Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F540211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 04:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeLDEU7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 23:20:59 -0500
Received: from www.dnalounge.com ([3.16.178.106]:53192 "EHLO
        cerebrum.dnalounge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDEU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 23:20:59 -0500
Received: from [10.0.1.2] (70-36-236-109.dsl.static.fusionbroadband.com [70.36.236.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cerebrum.dnalounge.com (Postfix) with ESMTPSA id 9334BE49;
        Mon,  3 Dec 2018 20:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jwz.org; s=mail;
        t=1543897258; bh=jFEuga5zcYHbqMbmj4dLseigeL8xih5IMitFSj3n0Zg=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=fMc0B3y88JGn6O4R64w1/rHBgtBgCLNak0OgR0949RpQSiIW0sGyFn0VToxzCe9hG
         klQ59kcwEDivVkHEAdogd7bsE0TafV1zjltBCZQP91BRC9CPyrj6pHJX8jJ9EZ8hxl
         QwKQEZ2RFSCV3H6IMaXnwl9JzaaSIKYRgXWucI1Q=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: sharedrepository=group not working
From:   Jamie Zawinski <jwz@jwz.org>
In-Reply-To: <53C59F2A-6D97-45F9-AF86-E255F6777E7F@jwz.org>
Date:   Mon, 3 Dec 2018 20:20:57 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1C20022B-666C-4E55-B8F7-43DDA9EBA107@jwz.org>
References: <F9365CBF-3D2D-4A05-AC0D-4604067B5826@jwz.org>
 <20181204040903.GA17059@sigill.intra.peff.net>
 <53C59F2A-6D97-45F9-AF86-E255F6777E7F@jwz.org>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 3, 2018, at 8:19 PM, Jamie Zawinski <jwz@jwz.org> wrote:
> 
> (Oh, I didn't check what umask was, but it should have been 022...)

Typo, I mean to say 002.

--
Jamie Zawinski      https://www.jwz.org/      https://www.dnalounge.com/

