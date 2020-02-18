Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FFAC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D8024649
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBRRcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:32:17 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60733 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRRcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 12:32:17 -0500
X-Originating-IP: 103.227.96.73
Received: from localhost (unknown [103.227.96.73])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 03C9FFF804;
        Tue, 18 Feb 2020 17:32:14 +0000 (UTC)
Date:   Tue, 18 Feb 2020 23:02:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <JonathanG@iqmetrix.com>,
        Robert Luberda <robert@debian.org>
Subject: Re: [PATCH] git-gui: add missing close bracket
Message-ID: <20200218173209.zxv2uwym7xba4enw@yadavpratyush.com>
References: <20200217161056.10864-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217161056.10864-1-me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/02/20 09:40PM, Pratyush Yadav wrote:
> In d9c6469 (git-gui: update status bar to track operations, 2019-12-01),
> the status bar was refactored to allow multiple overlapping operations.
> 
> Since the refactor changed the status bar interface, all callsites had
> to be refactored to use the new interface. During that refactoring, this
> closing bracket was missed. This leads to an error message popping up
> when doing 'Branch->Reset...'.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

Merged.

-- 
Regards,
Pratyush Yadav
