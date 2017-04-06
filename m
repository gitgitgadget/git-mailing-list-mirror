Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9552209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbdDFIWD (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 04:22:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:65299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbdDFIWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 04:22:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQih7-1cWMYb2Yaz-00TzVp; Thu, 06
 Apr 2017 10:21:40 +0200
Date:   Thu, 6 Apr 2017 10:21:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@jeffhostetler.com, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 3/4] test-strcmp-offset: created test for
 strcmp_offset
In-Reply-To: <20170405224752.2242-1-szeder.dev@gmail.com>
Message-ID: <alpine.DEB.2.20.1704061014120.4268@virtualbox>
References: <20170405224752.2242-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-745214947-1491466900=:4268"
X-Provags-ID: V03:K0:sf6TgaSQupbREMXvGzSM7tyjozDavC9A6pbwxQL+atuoslRWKTM
 8dKEXHDW+8+8r3MS5rTewVGhyOqpDSIDQe2SPH0LaWDQL/XmLiF3Nipkk0mL+Yi6lVyk6Yu
 emIlBXXizuV3ftzA1oRyUY6WoLcQDfYhFCaW47McdfJeG0fqc/TuZZTQQGCkq+gJaqVv7CD
 wA1gE+DzrjrHndsPELKiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:spKPdEMH87c=:Ynn8jX8WSzw+1b2OMm12RA
 kebJJ6oHrxlV6bI288qdQNSiqvzVjPGAzCXi/TvgeFnXabe78bsHorOs+/c6F7OrdQSFKQ3JL
 Gk3USSM1leIYaEwGMylvorBaSm14uc/Dc1KtXq5K93PZR7xa+AxXr+uSGq6rIBdEykPvmZX6o
 /t1QeVTwhnSkFO2jqLI4WeoNHMKWZuZLb+JKw8N7Ctr9vFtbyyUVaM8Yzit/Q/FfqAf8h4DRn
 nbeozNbQLhKJXIp67DCN3pmxRpOBy67yEO3gqmMZT7MSJnnmg23+nPRHCVABCR83CrCvBxSfo
 H97U2inrqAxyuHK5A+Q/o2sjJUdS/+XbiONrkntdVkOX83fi5wGpYai2ZIEhrVTZNWGQiuk+Q
 j/tTRWFEs0v+q82EgNHX/HSOKJgXugijvwOaHuT9Sj3ga9YcdSOaQ0ge68/TkUsd3yLw7Zr9V
 td6r7MHEKKQgY9pPi1Y1DZPPEz5rnOKLlz1akUSuJ74x4YK6+ZS58CuaxXNkEEEaijNtnJA8B
 lY4Hol6odsSZnbOJ386Q9kX76+Op/HxzC1yM27LV1rf1EWRjqdoWWa0M8UtYm4ouT/iU4Ux2I
 RzGiTzgev12luItXRmADBrG8lYmuYyjjC5YwykVNGtJ5iE9lLIiX1isJBZ/UcMbYrIOggUWyz
 c9Ks5alsBqdUjFjYTGSNWlbZ/BuF2Y60Rv6A8fQfwPJoCoUdSStmn89mJZ26/KCGnWrEzWHIa
 14km8nAOSXUwqkluICP/B7n5uBTrDUCH69DgLrJBnLzJvRFS2xyGJfVGXYWZil7h6bVeY1Eq+
 k1BTBnU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-745214947-1491466900=:4268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Thu, 6 Apr 2017, SZEDER G=C3=A1bor wrote:

> I think this patch should be squashed into the previous commit;  I
> don't see any reason why the tests should be added in a different
> commit than the function they are testing.

I am of two minds there. In some cases, the newly added test demonstrates
the intended usage, and therefore makes for a nice documentation. In other
cases, the new test is large enough to stand on its own, i.e. to merit a
separate patch (also to make reviewing easier).

In this particular case, I tend to the latter: it is large enough a patch
that it is easier to review as a separate patch.

> >  t/helper/test-strcmp-offset.c | 64 +++++++++++++++++++++++++++++++++++=
++++++++
> >  t/t0065-strcmp-offset.sh      | 11 ++++++++
> >  4 files changed, 77 insertions(+)
> >  create mode 100644 t/helper/test-strcmp-offset.c
> >  create mode 100755 t/t0065-strcmp-offset.sh
>=20
> Sure, tests are good, but I have to wonder how this would scale in the
> long term, when even such simple functions would get their own
> t/helper/test-func executable and t/tNNNN-func.sh script.

True. The proliferation of executables in t/helper/ got a little out of
hand.

But there is nothing preventing us from consolidating a few of them into a
single executable, using our wonderful option parsing function with
OPT_CMDMODE to switch between the different functions.

I could see, for example, how we could consolidate all string-related
test helpers into a single one, say, test-strings:

t/helper/test-ctype.c
t/helper/test-regex.c
t/helper/test-strcmp-offset.c
t/helper/test-string-list.c
t/helper/test-line-buffer.c
t/helper/test-urlmatch-normalization.c
t/helper/test-wildmatch.c

Also, these helpers seem to be related to index handling and could go into
a new test-index helper:

t/helper/test-dump-cache-tree.c
t/helper/test-dump-split-index.c
t/helper/test-dump-untracked-cache.c
t/helper/test-index-version.c
t/helper/test-scrap-cache-tree.c

Ciao,
Johannes
--8323329-745214947-1491466900=:4268--
