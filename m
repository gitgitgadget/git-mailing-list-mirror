Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3BC20193
	for <e@80x24.org>; Wed,  2 Nov 2016 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756580AbcKBUy5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 16:54:57 -0400
Received: from mout.web.de ([212.227.15.14]:64341 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756290AbcKBUy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 16:54:56 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M3jof-1ctBJ02G6T-00rEip; Wed, 02 Nov 2016 21:54:39
 +0100
Date:   Wed, 2 Nov 2016 20:54:37 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] t0021: fix filehandle usage on older perl
Message-ID: <20161102205437.GA6951@tb-raspi>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
 <20161102182301.hezruhtuhra6uoft@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102182301.hezruhtuhra6uoft@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:zOQVpxNjMYe//64YEPTb4PqqCTysS06sRBJFPDcYIMkt4QlOuEB
 EIoP71CO2X4c1438UYcTxedz7JVDahipQ9RH6dfzNTPgQlYCbFqVE4TXpKn4ananGo9PJX9
 Fqv2jYyVTR3lzG8BId/msZHIzQodkuX1ZLx/NX5kNev7Pu2auKq5nTV2yYOSW/8v1QGlGvr
 JuTAVZLrqw97mxsXXQA6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qsNLK30H8K8=:FzRR0Mm0HxpMzKpr4XzM81
 YOOARfdNDePgHEnbYiLTvAx6cgrqT4ZqrvzOyusaX/zDBt4BPABwUMS59j7kx0m6tVGVYUnI0
 o5vM+680FS9pHKKDGpilD9fO9g4VwySALAkMVwyvu7XeAPfZmiTmUzxoHZ9l0DdN801hhdCbH
 zCgCj7SUhTTTJENB+0nw2ZcFYYCBwKBhuoK3mXPOb0pw4aQs8Bq2LujxgpL5A8Wu6hoUd2zjR
 54JDp+5zNhnBML4ucg3v9/AnYnEPZkfodF4lQQPT0a6R90JflZDWf4CYBXcURqlPwJ+P2ccDk
 02cJ2FAJCkvUsSWQXo+PHKy/Selvjj7Ms7CHbq+urZ2VO7K0ZxOTrrre1DZheu6ZydhAnAX5O
 hCjsvG4OmwyuITg4jE1vUxm88VvIhG4MNY0yehHZd3og0yzks4yvL+0o15xAme24chbIkxCuV
 ySCAm9ScNXuQEkgnjpjdkmWf25/6bWh4dj2zRyXpTjoR3fNLaP2sO9QVsun28aqk3LqCJSstP
 pfyE3dYLwPhUmPsgBQ0+GDpiSWquR6icAX/zCWuOZxx7X2bcMcluIMbDN8OPGBtaJnO0jVJDq
 GNgZg79Ljy0pb1l0Xx388VPbUtjSr86qY7Y03Cc+hKX/GqqlX5yDGANRKZQQX/K/Ben2oCITF
 Dn0BZbsdNDaVSHa/G9KlvCympPMBltQuU0cXnM9mVd83Yq/qQuOsfSsR4NmdHggvfc5rQGVMf
 0vVCMVGQd3AqYDITBoT4RosZbiKrcIloWrFcQEfGLaHnBolGVyEQDq1JhlI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> +use IO::File;

That did the trick (the J6T version work as well)

Thanks for the fast responses.
