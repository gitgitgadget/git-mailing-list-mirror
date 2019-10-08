Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD491F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 06:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfJHGYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 02:24:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54461 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfJHGYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 02:24:54 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHivV-00059f-9X; Tue, 08 Oct 2019 08:24:53 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHivU-0002Mu-MN; Tue, 08 Oct 2019 08:24:52 +0200
Date:   Tue, 8 Oct 2019 08:24:52 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        entwicklung@pengutronix.de
Subject: Re: Regression in v2.23
Message-ID: <20191008062452.fdueej5clof7r2m5@pengutronix.de>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de>
 <20191007134831.GA74671@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191007134831.GA74671@cat>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Thomas,

On Mon, Oct 07, 2019 at 02:48:31PM +0100, Thomas Gummerer wrote:
> I can hopefully do some more testing and write automated tests later
> today or tomorrow.  In the meantime it would be awesome if you could
> confirm if this patch fixes the problem you were seeing.

I assume you already tested on my constructed example from the report. I
just tested on the original and there is works fine, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
