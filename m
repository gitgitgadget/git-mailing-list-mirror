Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82A71F404
	for <e@80x24.org>; Fri, 26 Jan 2018 14:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeAZOlv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 09:41:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:63553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeAZOlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 09:41:50 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MIMUZ-1ed8ys3wHX-004DXs; Fri, 26 Jan 2018 15:41:14 +0100
Date:   Fri, 26 Jan 2018 15:41:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Patryk Obara <patryk.obara@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] setup: recognise extensions.objectFormat
In-Reply-To: <CACsJy8BFsXAMAGYjKp8EBrepqZwgKrAtqRKyiKLOydWbpzZWWA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801261002570.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com> <CACsJy8BFsXAMAGYjKp8EBrepqZwgKrAtqRKyiKLOydWbpzZWWA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HhgIu2q+INViopPBrgIufVl0rtgk7Bcwc/xppEzgIdbPUpvPB09
 ubk6DpKoF7u83Qw+Y1/vnLKwkkoNfax2D11Nr1TaWx7bE5gNY0KNW6SQUlkCVGi0sM5gBUx
 EXHxs8BAo8bYJMzqa9CW2gLVM9YTk5GKvejS/G/3gHWIW22LsdIrTpghbyK6z5ns2oAjMVp
 7Q2x7XSO1u7XropAu4mNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ElSi+tcZPsk=:p1iQwu0jX094KIkZom63JJ
 wt/PSVM5VtqOBoQM9ICjdrKunEgHrrjWSrnB5htS16R1u/Op552Ypr842lHxIlasOUf+KswMb
 0v2rebDG5vOCTWUktG8jAPfaov358VTgAAsZUMsJlcmI6AAnkWqp9jLEY+Ts99B9afck2cJaY
 7M4FLiaQu6IPXn0OM7GnYah1kpzMEeRkLPRhpVO0aBnAuEr4INctpoWYPjcu/Xmo40Tu36s40
 QMKYOAaQKUeiP5BKLU4MnuPW1HJili+Ky4QJipFYHa9mYI/sq1nynT9I01B+rcFNoPtQ0Mlbj
 AopT40Zpfxoas0R+LtHJ1Jmg0nks8Wl9G26+WN6PrHjlRsJsGyz0KoMRR01guCVqGzV3b3+ry
 7DgaP9kUz5VLvn8FTGaI00g/gtYRkFt5IOtHFiP+WDXmCmutZiV+IbXU6X1XnuscRH/Ryq7HJ
 fTtOINOzZbYp3F5KoenujP9ki7ZSmbpt/Y8/Aat/v5ooX221e2eXb/d4o9Oq00egShstBtg0q
 mJU/vUkb+zm2/j0N1CsJ3Z8FVE8OJQYZMaYHdi/BYh6ec0z1T9G2cxWZEgkB0Vb0dDoGHZ2QE
 ryX66Y5mf1hQGF9z1MoWiOpzP9k+FIMGJo3wdC7v5XkkayUIQT7D4YGl2HMZpUSpbwTlJ08Hi
 yXJPsEXP8rvYzIhIdY8znVNfE7L4IEI1fvNtEBumxMLBotzz4seCMWSweBwC8rgGrjzjP2Fvu
 lh99R8+blkrWAojwuxfWukzUWRMHlic3E/fVulEmN7pzQABC/Z7V6gz0etBP2UEauwlRgXcnU
 WyaY7sy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Thu, 25 Jan 2018, Duy Nguyen wrote:

> On Wed, Jan 24, 2018 at 8:09 PM, Patryk Obara <patryk.obara@gmail.com> wrote:
> > This extension selects which hashing algorithm from vtable should be
> > used for reading and writing objects in the object store.  At the moment
> > supports only single value (sha-1).
> >
> > In case value of objectFormat is an unknown hashing algorithm, Git
> > command will fail with following message:
> >
> >   fatal: unknown repository extensions found:
> >           objectformat = <value>
> >
> > To indicate, that this specific objectFormat value is not recognised.
> >
> > The objectFormat extension is not allowed in repository marked as
> > version 0 to prevent any possibility of accidentally writing a NewHash
> > object in the sha-1 object store. This extension behaviour is different
> > than preciousObjects extension (which is allowed in repo version 0).
> 
> This config is so sensitive I wonder if we should forbid changing it
> via git-config. You can't simply change this and expect anything to
> work anyway.

I don't think it makes sense to forbid `git config` from changing these
values, as it is all-too-easy to change them via `git config -e` *anyway*.
And we already have the repositoryFormat precedent with the exact same
issue.

In my opinion, it would only complicate the code, for very little (if at
all noticable) benefit.

Ciao,
Dscho
