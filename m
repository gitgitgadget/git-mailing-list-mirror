Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74F01F453
	for <e@80x24.org>; Thu, 31 Jan 2019 10:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfAaKMW (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 05:12:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57061 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfAaKMW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 05:12:22 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <rhi@pengutronix.de>)
        id 1gp9KX-0006lF-5s; Thu, 31 Jan 2019 11:12:21 +0100
Received: from rhi by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <rhi@pengutronix.de>)
        id 1gp9KU-0005PO-Ok; Thu, 31 Jan 2019 11:12:18 +0100
Date:   Thu, 31 Jan 2019 11:12:18 +0100
From:   Roland Hieber <rhi@pengutronix.de>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] reflog: specify default pretty format in config
Message-ID: <20190131101218.d6aebwuaxdmyjxoj@pengutronix.de>
References: <20190130144744.3248-1-rhi@pengutronix.de>
 <361643257.4118832.1548872569575.JavaMail.zimbra@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <361643257.4118832.1548872569575.JavaMail.zimbra@matthieu-moy.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:11:43 up 9 days, 21:24, 65 users,  load average: 0.16, 0.19, 0.18
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 07:22:49PM +0100, Matthieu Moy wrote:
> Roland Hieber <rhi@pengutronix.de> writes:
> 
> > The output of git-reflog is currently only customizable by calling
> > reflog with --pretty=... or overriding the default "oneline" pretty
> > format in the configuration.
> 
> Sounds like a good idea to me, but the patch needs a bit more work:

Thanks for the review! I'll follow up with a v2.

 - Roland

-- 
Roland Hieber                     | r.hieber@pengutronix.de     |
Pengutronix e.K.                  | https://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim | Phone: +49-5121-206917-5086 |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |
