Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827EC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A7604DC
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhHYXBm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 25 Aug 2021 19:01:42 -0400
Received: from shark2.2a.pl ([213.77.90.2]:55198 "EHLO shark.2a.pl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231535AbhHYXBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:01:42 -0400
Received: from wrasse.2a.pl (wrasse.2a.pl [213.77.90.7])
        by shark.2a.pl (Postfix) with ESMTP id 798BC175080B;
        Thu, 26 Aug 2021 01:00:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 2a.pl
Received: from shark.2a.pl ([213.77.90.2])
        by wrasse.2a.pl (wrasse.2a.pl [213.77.90.7]) (amavisd-new, port 10024)
        with ESMTP id o3iXtwu6-xID; Thu, 26 Aug 2021 01:00:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.1.26])
        by shark.2a.pl (Postfix) with ESMTPSA id 3E12A1750809;
        Thu, 26 Aug 2021 01:00:47 +0200 (CEST)
From:   Krzysztof =?utf-8?B?xbtlbGVjaG93c2tp?= <giecrilj@stegny.2a.pl>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
Date:   Thu, 26 Aug 2021 01:00:44 +0200
Message-ID: <1790169.Z4XVHNUiN4@localhost.localdomain>
In-Reply-To: <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain> <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dnia środa, 25 sierpnia 2021 02:57:47 CEST Jeff King pisze:
> As far as what you're trying to accomplish, HTML-escaping isn't
> something Git supports. You'll have to run the output through an
> external escaping mechanism.

Have you looked at the format?  It is a HTML fragment with placeholders to be 
filled by git log.  I cannot run the output through an external escaping 
mechanism because it will kill the markup that is already there.

Chris




