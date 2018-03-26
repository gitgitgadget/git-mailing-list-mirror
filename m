Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15C91F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCZWOy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:14:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:52321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbeCZWOx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:14:53 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWTSA-1f3E4c4866-00Xcng; Tue, 27
 Mar 2018 00:14:45 +0200
Date:   Tue, 27 Mar 2018 00:14:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/36] t/helper: add an empty test-tool program
In-Reply-To: <CACsJy8Dz87YHiA48m_X7OmJXioKorUDNSyPy250jaqU7xt1JXQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803270007550.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com> <20180324074505.19100-2-pclouds@gmail.com> <nycvar.QRO.7.76.6.1803261722350.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CACsJy8Dz87YHiA48m_X7OmJXioKorUDNSyPy250jaqU7xt1JXQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-700398765-1522102485=:77"
X-Provags-ID: V03:K0:OSJ1var6nJ+4yLJOoSkIh0oeyYNbOgobg8EiOus+V7lipT5b97+
 boMNzG8OvHJdNPxlL6XQhVexFF1QUu2diOOsxv8qA4c+QuxJQuhC72Gdkx347RaFYPO91ee
 lY+T3YMjF44Gu2nckqRtxGNA4BH1mVjxenGcAUVSANLyQinmGVnag+Ap8O4MZ63AzvFP7U1
 KCprU37tfkaeTxtlviMSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vvp7kisAKAM=:tmLhkEuk1O/NRX69xrqKw7
 haw56GuDGgkTNAWD+XeaYKeptptfxKrD6ev3t8mJlhUQXIcJAhyWq7ihzetWilywVMquk0oAw
 1w4Z22wL372kvLn1dbKAhcdmzRDSrPcVGk5NXWMBIBfanqUlHf4KcJ9gZ45teFvqmZiDsRDYM
 Y8tIBY/r9OdmJaZkrJxErDdLEiAZCiM2Bl6m09XGfXnFtohkosMH26wWUb7gRVuPjddljZ8hx
 ejFAvfXK8N6klE6XPxy2aDj1MoZSYGQSURxeTeT6MZS4AoPVqExNYjJT9mn0wDQ0LfIiMWd7Y
 127k739S87XcqBJB6hqLjZNcNIYBa96+FqqLY/mCz36PryFZD201h3Y2ZYlM8BavQTmo315eG
 cFnm9aqWHeotkXwX/3N+0MaU0spBeu0NO6ZhJZZ2wOGEMO/CVxm7sP3Kq2xLoZKX4b6tvtXrh
 k5zwUNvulE8KXQTtVkIwFBPillcl8f+ymd6zgYk+x/5RvoBfPcALKaMy0nKc5AK65IPRTTMZW
 xyz8f1T7wWD435CVyapxtXjdjd/kSkqqpHIU6pbuuR7bU3QaeYP/9smQpB1FU0b09YWlGaP7P
 1J/Hp7avuS/uVpjRGV6SECiK1qtiRaEgY/G2yrAnDmQSRn7DWigHSxQSh4rcpw0GVY71sEq61
 17yKF0LQTvcEUTQoAa5t7l86e7GGMUhP4DPb+8IOB2T5Y+HFae1b05nJhJXHGixNEPkT2slWh
 AlPyDYnsWChnT/XkQpChAWzj3nyHhAiZwdrrxO/jbQhXEOPr3vCQOi5zcqXXJrG+58jcFmzbJ
 fxC+g1KUmE5ugxzF1oqGUG/NYvmca3yZU+vqXaeRFR22QG20LINgAbXj5Yc290XWH885cpv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-700398765-1522102485=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Mon, 26 Mar 2018, Duy Nguyen wrote:

> On Mon, Mar 26, 2018 at 5:27 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 24 Mar 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >
> >> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> >> new file mode 100644
> >> index 0000000000..c730f718ca
> >> --- /dev/null
> >> +++ b/t/helper/test-tool.c
> >> @@ -0,0 +1,27 @@
> >> +#include "git-compat-util.h"
> >> +#include "test-tool.h"
> >> +
> >> +struct test_cmd {
> >> +     const char *name;
> >> +     int (*main)(int argc, const char **argv);
> >
> > This makes the build fail on Windows, as we override `main` in
> > compat/mingw.h:
>=20
> Sigh.. not complaining, but I wish somebody tries to compile git with
> wine (and automate it in travis). This way we could at least cover the
> compilation part for all major platforms. Probably too small for a
> GSoC (and making the test suite pass with wine may be too large for
> GSoC)

We do have Continuous Testing of maint, master, next & pu.

However, it seems that something is off, as
ba5bec9589e9eefe2446044657963e25b7c8d88e is reported as fine on Windows:
https://travis-ci.org/git/git/jobs/358260023 (while there is clearly a red
X next to that commit in
https://github.com/git/git/commits/ba5bec9589e9eefe2446044657963e25b7c8d88e=
,
that X is due to a hiccup on macOS).

It seems that the good-trees feature for Travis does not quite work as
intended. G=C3=A1bor?

Ciao,
Dscho
--8323329-700398765-1522102485=:77--
