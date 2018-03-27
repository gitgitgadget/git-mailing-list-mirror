Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACF11F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeC0QND (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:13:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:52111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbeC0QNC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:13:02 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2tXS-1ejsIL1m4M-00si69; Tue, 27
 Mar 2018 18:12:55 +0200
Date:   Tue, 27 Mar 2018 18:12:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v2 00/36] Combine t/helper binaries into a single one
In-Reply-To: <xmqqtvt1a5kg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803271812430.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1803271558380.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqtvt1a5kg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l8eVu1TWseBNEDJEE7RmrX6lXaCjjI1EXw3AGQEvmmHxYeznt6V
 HJSm4u6FmopxdJ8TULBgl1cTG2an7KKpce5S1mdRS7idPL1/moG3avpw2m4DnOG5PcoEgtT
 zFrlpukLZFRmOlapMucB0sK0+SdM5HyRRJ4fwVtinNBj7iwpraGUn3czI+bgVEmfh7c/YJK
 QkFzj7DX8BSHmLopJtnig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ec9fg+FHZSI=:EAAqTkcQJ9q+osc1+ZNiF1
 29iyCO15cEAXkWFpqLSHXjyOvjqgkcWCihoO3gjuVUyJ37baU9VqYWd53UuPhwXFTS5yS7xwp
 AfzTAxBd8uymNRxCkR0V91F2zmVpASHctsa6q2kV8pbsSke7+kKPFRDzTlKUPnud8GVq8yujO
 A0w8P3ePR41aP5sIzlfQWlWlFGnQLG5FhrGbNRpEo6VTNGXxX7GEEcxF2juGHx2J6Frta1vak
 /XmuB7AhY0Kf98IeR8aqsYW/i4MZUCG3dLCgFci3iODueqlFchaaARSJr714rIsH7Z81EB+go
 UhLOz91dEgdFBzmcU14wkRaxSQOK6uvGhW9f17kLpsSLHbWr+2OyD5W3DQa0EMx5ACePj8KDS
 CJzsqOcegJoiJhTPA7isHA0OOroDpLbTSc7cAz6+pXA08D2xUI1hQF0Lsn0p5OhZSBsV1TxRs
 2+JL64nFmtpCs7utDTQpQOLup/eVPL2n4JXXn/D1bgkA9MUVvZt1DY/0FU8QEmeD8/1A22f1x
 +GalTGxQCN2Dh9VsdO+fBkkPF3k1M6jNMJwN3G76knu85roW0Kyf/zEQl04GBDPYvjj+17Fnx
 6S3uh5vOCxJyMjtVv+i82x/sCZd7JjSDQDbcjOHdMEyEDsdOB323noXNbD4r5x6yvVODU5n6t
 uqK4ebKFdjQ2hyQsdyHnXzPcE7F7sNSdqc8d8lnT8P++8f5JGwZmg5qUmyk4H4DGTvyIfDUay
 nJPYyCzyZ64XM0sTaEMiJuuXjLo3bd3blHe3cL1A6bBxBVZ0zcv75DzlHdIOI8J8a1vGCPCRS
 IRNz4rT29gGGYhFHEnwnrs8uZrr50yp0HuyOUgHhfi/+x4t20LY/zmCAcn+7b1dRd9d20dD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This iteration, with the SQUASH??? I proposed (and that Junio will
> > hopefully pick up soon), works well on Windows.
> 
> Thanks; is that the "call it fn, as main is macro-ed away by us?"
> change?

Precisely.

Thanks,
Dscho
