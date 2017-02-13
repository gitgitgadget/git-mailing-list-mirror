Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5FE1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 17:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbdBMRQl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 12:16:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:60368 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751703AbdBMRQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 12:16:40 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVNDK-1cuHmw2aSs-00YfcO; Mon, 13
 Feb 2017 18:16:16 +0100
Date:   Mon, 13 Feb 2017 18:16:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
In-Reply-To: <31bb0b9f-d498-24b3-57d5-9f34cb8e3914@kdbg.org>
Message-ID: <alpine.DEB.2.20.1702131815351.3496@virtualbox>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de> <xmqqbmublyo0.fsf@gitster.mtv.corp.google.com> <31bb0b9f-d498-24b3-57d5-9f34cb8e3914@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W2BRjve6KY9R7bACLB0LZ3SadgPkuYFnvuXYA6YKBmZJY6PF5XV
 EsCpQ2H2/UYHIopMKyaKGi0fZbfNHWjAd2kaCYMpIf24NWsmRIndmilDhBbm+vlJ/YFdfqK
 sC8x2xv8woWufa74XlWzSq5/jUkZQd8cA69rJ6Y8kv/76u7nsx9jZPPDrGJqxS3mUhzd83r
 gNE3OIDDcqTuT6y1YP68A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dy0f1CGDY9g=:B6aFKpCyVUj2qhjWEYv4B+
 +Y3ECNcAoeWM1+mwAGWfKVZIEurQLgxheqDpmFxTz1aqkFzSasUE83ktBk+SPNsXAEJaTZ5Xr
 52VZWpCoesyPg5BWRdGe5Vfll/pvf+i6bly4Y3YpD2jTmTFA0J3nmzcZ/fL97O50PTBV7PkjS
 EN4/J1r2dcFuRWbWxethhWE0gCiXwVftr7Ylzl4JdT36MKaLhlmrEyHrpF+Ahe/cYepa5zTIl
 QIovFIob7d2/F1nZ7JL5OjFVGuTFop46wv4bBcatkMGqQQZls7hJduLvdLOmm6LLZ83PBqu/a
 hq9VM7uYJje67YERwu+C1Y0pou4CxasI/IVEpdseSfHHYOXFgzqEpC33j0E5bnZaT9ysmiKcc
 A8tTu3KAdKjh6NDiF13YK8h54egzplvWyz1Wsm+sn4bIuW32XlA1F71whEWWpTLKpMglLaOk4
 hNl19DHqQcI0BR/JzNUNCpIdcMQU6SeiwKm9j5Cgr7NHzcHPgiPU652lgY2/51d1jFhc4m3Ea
 DmdSGmmX53i23tvs8db241iAFaGRCEnkpVjrF27W7lqnG+TFjw/yMgA5CXmVcJKA05C4Xn1KQ
 NTylsmB7c2LWL5LsiwLVoHPnCK2ssnzfgNaLCeyVG1bFZAS2yZQ+IeQlcJ8O7JKGb3naTnWai
 2m8cErnJv9vLhLiHAY3bakwB9ay+v0PnHt4WU6FNFbv+XnN+ExPsbZ3La8RveMwVhw4zvMDXg
 Ec+ZLAVUUib+nvB/NEVAK06t3JzJGZOTc9/W8F41O7YSYiy4AEdSHWfuwDCdWhuxL+e/sFB9A
 yywKeLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sat, 11 Feb 2017, Johannes Sixt wrote:

> Am 10.02.2017 um 00:41 schrieb Junio C Hamano:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> > > From: Jeff Hostetler <jeffhost@microsoft.com>
> > >
> > > Use OpenSSL's SHA-1 routines rather than builtin block-sha1
> > > routines.  This improves performance on SHA1 operations on Intel
> > > processors.
> > > ...
> > >
> > > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> >
> > Nice.  Will queue as jh/mingw-openssl-sha1 topic; it is a bit too
> > late for today's integration cycle to be merged to 'next', but let's
> > have this by the end of the week in 'master'.
> 
> Please don't rush this through. I didn't have a chance to cross-check the
> patch; it will have to wait for Monday. I would like to address Peff's
> concerns about additional runtime dependencies.

I never meant this to be fast-tracked into git.git. We have all the time
in our lives to get this in, as Git for Windows already carries this patch
for a while, and shall continue to do so.

Ciao,
Dscho
