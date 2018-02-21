Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CD41F404
	for <e@80x24.org>; Wed, 21 Feb 2018 16:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933410AbeBUQlK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 11:41:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:40529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751977AbeBUQlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 11:41:09 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mg3h3-1f9Ffb46tB-00NPNx; Wed, 21
 Feb 2018 17:41:07 +0100
Date:   Wed, 21 Feb 2018 17:40:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Tim Mayo <Tim.Mayo@ubisense.net>
cc:     git@vger.kernel.org
Subject: RE: Stackdump from stash save on Windows 10 64-bit
In-Reply-To: <3859F9D06DD39A44AB88A072AD53704DD08EB0D4@CAM1MAIL01.ubisense.local>
Message-ID: <nycvar.QRO.7.76.6.1802211738510.60@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <3859F9D06DD39A44AB88A072AD53704DD08E9925@CAM1MAIL01.ubisense.local> <nycvar.QRO.7.76.6.1802201408190.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <3859F9D06DD39A44AB88A072AD53704DD08EB0D4@CAM1MAIL01.ubisense.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p30jZYy6GUqwvYOJJQX0FGfDa1ND5VgLi5TdQ0KQkkgMjpcJV5T
 bqgf5MAM3NhUHwLLqqmJBK/QCnC278fprmVu+es6V7uORSOyJRR0hVBWJF6vN8/CArCiJvu
 D3VFEsTtaAp+Fc2jIJ2MR5k26VsqygMTs6MQCRIy1kQKT9R1YZuu3Y6xksP3+pKag9hi80z
 w3Ca6Gd8I7JmDStXn6Bng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YoB9xbULnOU=:02uEFgetOiPpcg4Rki7WPK
 gxT4c54U3JO5FeQRn0NniVU7J5EUscUDVC68r4lxxwYnV9eF5NkLxc3xk5+Awm38etebdtMlt
 xhmNanuI0X/p/zxzkcEsvhMoRYBfDdhW91aEKqkw69Vl4qKvEIxre2/1B3P10crD5Bwzz22sk
 aljuHJMrMonrtkahJqcqlQR2G90FDPxGcjO6WRf9RhduU96qttrHqZp/JRUDJSVA8UwgOPnNi
 0LAlsLUPzo2/g/XyMSnxbcYqBuWg2ZbTQkiT9UTdxn3phm/ID8ghbRI/TBRLcXkQnuXAXOsRI
 5Dy0pAkH749/dA4MIss/311m7x1OiS95EWEm1AWgtmaPE6+Ine1opgpyDwrcWM0bulOaBHumI
 hMzfrwq5ncXk5J+/hdCPLdsIWrCFATutCqbiod7nHjxtTv1taZR2OSHcQIjN0JaE9DNCrbVy4
 nV5IfkGSB2aH8dVZIUoro3q/j4RWOcbO5rWXe6qfnHNgS/TgxLQ3MLpvXROB2Ect6mB/uGvly
 F97lo4FCJjfY8e3+WK3mbh2SVhx5y9YakrIGHn1ZSMG008tO/PO9MFAnsq8zs/emchKZHO6HO
 Mp9sDoWMBUc+3xhF0IFxzDSafPt1f3DeIdoPj0JSu8eI5tje+AxafQPbV/ZA9jjuMAyfXrXOp
 2nJo6JwRN9mYRf78LJMTe2E18DJew+60JeecfiFxwOp3bTcyw/RRzBcQVKUCjW7VmhoC5WbOq
 NT1JdeyNORZlr8vpOVpjBD0KhBXn7IPUpDESd5kPmzArIPcruUy39CxRN3SMR128Uz5h/FLBC
 u0QplpHFK7mmbuP/uaIFbs0/+dBYXmJCOFOL1jcsCvaFF3NDto=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tim,

I re-Cc:ed the Git mailing list, as I do not like the pressure of being
the only one you ask for help.

On Wed, 21 Feb 2018, Tim Mayo wrote:

>   > Can you please test with v2.16.2
> 
> Is there a built version somewhere .. or do I have to build it myself?

Yes, official Git for Windows versions are always available from
https://gitforwindows.org/: either click the big Download button (which
will download the installer right away), or click on the version in the
upper left (if you want to choose which flavor of Git for Windows you want
to download).

Ciao,
Johannes
