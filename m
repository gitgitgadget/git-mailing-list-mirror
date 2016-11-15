Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886032042F
	for <e@80x24.org>; Tue, 15 Nov 2016 12:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932916AbcKOMH0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 07:07:26 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:56414 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932388AbcKOMHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 07:07:25 -0500
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c6cWH-0007NJ-4Z; Tue, 15 Nov 2016 13:07:21 +0100
Date:   Tue, 15 Nov 2016 13:07:18 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161115120718.GA7854@book.hvoigt.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
 <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
 <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 09:22:51AM +0100, Lars Schneider wrote:
> To all macOS users on the list:
> Does anyone execute the tests with GIT_TEST_HTTPD enabled successfully?

Nope. The following tests fail for me on master: 5539, 5540, 5541, 5542,
5550, 5551, 5561, 5812.

Cheers Heiko
