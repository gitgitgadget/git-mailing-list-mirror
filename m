Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F9D1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfH0K4k (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:56:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44891 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbfH0K4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:56:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2Z9T-0004P8-5Z; Tue, 27 Aug 2019 12:56:39 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2Z9S-0003gd-KO; Tue, 27 Aug 2019 12:56:38 +0200
Date:   Tue, 27 Aug 2019 12:56:38 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827105638.2og6vwvqtzkkqn5p@pengutronix.de>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
 <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de>
 <20190827094407.GV20404@szeder.dev>
 <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
 <20190827103309.GA8571@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827103309.GA8571@szeder.dev>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Aug 27, 2019 at 12:33:09PM +0200, SZEDER Gábor wrote:
> On Tue, Aug 27, 2019 at 12:04:27PM +0200, Uwe Kleine-König wrote:
> > I'm a bit surprised that the default for --decorate depends on the
> > output being a terminal.
> 
> Decorations (and colors as well) are for humans, and humans read the
> terminal.

I agree for colors only. Changing the actually provided information
depending on output being a terminal is IMHO at least surprising.

> > Thanks for your help, I will think about what I want to do. Just using
> > --no-decorate will work, but isn't nice either. Will test if just
> > throwing away all those tags from linux-next will make this already
> > better.
> 
> Note that you can disable decorations by setting the 'log.decorate'
> configuration variable to false.

Being able to configure --decorate-refs= and --decorate-refs-exclude= in
the config would be nice ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
