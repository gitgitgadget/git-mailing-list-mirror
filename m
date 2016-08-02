Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012F41F955
	for <e@80x24.org>; Tue,  2 Aug 2016 19:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbcHBT56 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 15:57:58 -0400
Received: from mout.web.de ([212.227.15.3]:56978 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbcHBT54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 15:57:56 -0400
Received: from localhost ([24.222.202.218]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LtkCj-1b5Phc2bDx-011DK3; Tue, 02 Aug 2016 21:57:14
 +0200
Date:	Tue, 2 Aug 2016 21:56:38 +0200
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"jnareb@gmail.com" <jnareb@gmail.com>,
	"mlbright@gmail.com" <mlbright@gmail.com>,
	"e@80x24.org" <e@80x24.org>, "peff@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 03/10] pkt-line: add packet_flush_gentle()
Message-ID: <20160802195546.GA2660@atze2.lan>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-4-larsxschneider@gmail.com>
 <63231F5B-959F-4A9D-89B9-E4A42AF34AB1@web.de>
 <8FC2D283-AF8D-4643-834E-3D1927C558C0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8FC2D283-AF8D-4643-834E-3D1927C558C0@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:NGx/k9r+hMxgAQzA5zBCxmV7daoDABWAU1/dDNuiJylkNioQGAx
 o89W5eyQnF7jSn7vuXZvlX98iIbYaZ9UwnxOOa0Bxkk/ocoqqOLjJzL1aWfWrpXOMWHgIL2
 Bjw6z01aJ2G1WdJ6pvZhUdBM2ukMWTO9cS7wvtlIWUgDwr3lnLKXHtIQRARo4UP0i72ZEx/
 10jvl64abS9Wmn0G+NRhw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3DsUpL4MslM=:sbJ4B+WGDhYegDGztexjsy
 2mGEcX5o70tvGgPUYuxG7gFXuEizKIlXjiNo/cr/nxk5OOmlLHWXjj6Ytls5qFzxhDkeRtpBg
 KcW4Idm7cxh3qVI5qftiJuxE04MNO/Riq1MPF7r1BtKneOsTjYYkozNlLcSx4z5vSnXfNSfqr
 d/X+IKdvfmS0DYCcat7Vdc3XNh5fPnpn+Op8cJWwi6ieZ5f+FomrEYpPLrd9kJSNFG+1TCX4V
 8bFHuKzEJx6NWN+4uyMej/xiXnToWzf84V/EiUR+GLdX0AzElwSi5OTWCgXzKa1zh7cEO9ngq
 AsFN5nfHGXS5nFGUT+qsrqth0qz1TMLnZNntKlsoX5k3g83/yUS0dAtj4cUH3FHZjHGbNR7fP
 kRAtdBbMyYC15JjFlB+uLHsXWFB02re2FDIVVqT1kG0NzYSix4AszS1zTO1LW17kf9uLsQXMd
 pJW23tpB32tGfTszE0Nq99yvQ6DZAGo0c58//pLoM2SaC01m5wdxAtrUBqX0FEHoftvBAGWH6
 eNYzF2Pde5W19ywsT8bUXTurSY7veK/NlG8cQY8STKWkCGxQqXaFlS+7HWyvKeqKDfcAu1kgJ
 lkoJ+32Hs3QlQ07htQYL8Ur8Vz1rhLEoxq8gcDQhBmKHELywQz1oEtmMMEeNJ9G1+Yq8/qKYS
 GjEUKESy1hA+3b09/VgAONMCYk6hP2UU+oKVlageCABGu6MEKxQRJoFpTJKG3PAl0Ezp50vSM
 NBj87fM9mhE2R9MITxEj9oOkLh/p+Nf2FOmWG7EAgriQ8E7eHrCAd5B6/vU=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 31, 2016 at 11:45:08PM +0200, Lars Schneider wrote:
> 
> > On 31 Jul 2016, at 22:36, Torstem Bögershausen <tboegi@web.de> wrote:
> > 
> > 
> > 
> >> Am 29.07.2016 um 20:37 schrieb larsxschneider@gmail.com:
> >> 
> >> From: Lars Schneider <larsxschneider@gmail.com>
> >> 
> >> packet_flush() would die in case of a write error even though for some callers
> >> an error would be acceptable.
> > What happens if there is a write error ?
> > Basically the protocol is out of synch.
> > Lenght information is mixed up with payload, or the other way
> > around.
> > It may be, that the consequences of a write error are acceptable,
> > because a filter is allowed to fail.
> > What is not acceptable is a "broken" protocol.
> > The consequence schould be to close the fd and tear down all
> > resources. connected to it.
> > In our case to terminate the external filter daemon in some way,
> > and to never use this instance again.
> 
> Correct! That is exactly what is happening in kill_protocol2_filter()
> here:

Wait a second.
Is kill the same as shutdown ?
I would expect that
The process terminates itself as soon as it detects EOF.
As there is nothing more read.

Then the next question: The combination of kill & protocol in kill_protocol(),
what does it mean ?
Is it more like a graceful shutdown_protocol() ?

