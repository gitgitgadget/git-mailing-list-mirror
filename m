Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E9C1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfBHKWE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 05:22:04 -0500
Received: from elephants.elehost.com ([216.66.27.132]:46992 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHKWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:22:04 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18ALpLV055553
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 05:21:51 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet> <20190206104243.GJ10587@szeder.dev> <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet> <20190206171517.s5lskawpdodc74ui@tb-raspi4> <001501d4bf06$506b8640$f14292c0$@nexbridge.com> <20190207235726.GR10587@szeder.dev>
In-Reply-To: <20190207235726.GR10587@szeder.dev>
Subject: RE: t0025 flakey?
Date:   Fri, 8 Feb 2019 05:21:44 -0500
Message-ID: <000901d4bf98$1ab08fe0$5011afa0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJs/IuaaCkX8/5Ult+TIwKZwFHx1AHYuM18APJkJqYCro2vggHT53WuAZ/vhoukXcqPcA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 7, 2019 18:57, SZEDER Gábor wrote:
> On Thu, Feb 07, 2019 at 11:58:08AM -0500, Randall S. Becker wrote:
> > > The NonStop port has traditionally had issues with t0025, which we
> > > tended to ignore because things did work. We wrote those off as bash
> > > issues in
> > > t0025 since they seemed to be corrected when we picked up a new bash
> > > version about a year ago. I will keep monitoring this, particularly
> > > when
> > 2.21
> > > comes out.
> >
> > FYI: t0020-t0027 all passed on the NonStop port for 2.21.0-rc0 - so no
> > issues for us on this one.
> 
> Note that t0021 is very likely flaky on NonStop, too:
> 
>   https://public-inbox.org/git/20190111140408.GC840@szeder.dev/T/#u

We will keep a watch on it, thanks. t0021 has been stable on this platform for at least a year and passes for 2.21.0-rc0 as well as 2.20.0.

Cheers,
Randall

