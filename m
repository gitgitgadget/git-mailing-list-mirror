Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CBE1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbdA3QXY (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:23:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:64645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932474AbdA3QXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:23:21 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzLJR-1cTc1G2Utt-014U0Q; Mon, 30
 Jan 2017 17:16:15 +0100
Date:   Mon, 30 Jan 2017 17:16:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] graph: use SWAP macro
In-Reply-To: <af5a7205-7703-f5ad-4ea2-b20ab4c01c80@web.de>
Message-ID: <alpine.DEB.2.20.1701301714450.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <af5a7205-7703-f5ad-4ea2-b20ab4c01c80@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-596184923-1485792975=:3469"
X-Provags-ID: V03:K0:7SN/mwSWNoF7nZYRTSmJdlKiaZPwTnnIIehQxeZpTHLHjx4aauN
 NhqwgKK1BO/84FNVTp2D1cb3J0VoswmIzwJ21n26V4jpttRVxZxgvhClLhIK7MEMhL7Da2g
 PREvP7eU+bw5EVKe2odTJE5JlTII7JCspc5M3Mm6EqmVsb9BJT84xwqq9UgY7bo3V2PHuOA
 Yt4kclh+YtEuvtA1ycMEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vHNKK1RVPAo=:MKke9w97BhPNx2501lm/8h
 NWt3jqU7p3bgJTXfEsSWf/qt9oJfndMbX81DB7xY9iA9+jdEgVmtH80i1GSD7ZqyPq0lsVsh0
 nfwe/a7x3a43e6o3OpmDQ4NTy5TaRYTZ2Tn/cL9eDouTE5CQGMwrSBgpVy6RJEvNZzLWeqnrr
 vWOop2K2kdQ8zMqdW5DXhXnULNjdJpB3lYWzsciNpPuCOeNDWp+G4EUZJ03PqP8K9NZyYlTdn
 SlbfRePwQ54tpbWNQ2XaWubHDVRAaRNgb5R/wUwBMbKsDIaXT+zS7z5Sf0kcB/CdQgimTWa69
 HUGZdhG+vlSP5FBxpYNoJHlrYo+aCW9+9YwjA3hhFRG8GR455S2Rug9Fekpjvmpmm57lQMlOf
 H3i4nkC9LBYwZkXLuxdWyupXxw2FIfMphmwHtMI4HoChfQUQwWeay3ZSfcgHoLsBsV8p2srkM
 qLZt4DdCXS6EHiSKiBBTvGNNlK1F4ZjX6AOUxntHEEl8GLVtXmPZjhYhJbleR/mq8SyRqJzF5
 NTp9LHY73TYos/mjnX1PH1vUKv+wIPDDa8k9zMMm7BN0AZlOUtu/G7yjUsHLEEHS55Dnmhtt2
 MO7qMai0yUOyV94a0awlI02tzdX7sRX1XJvu84EoTwDyu/rIn/C6EkZTagCAWHKuC3WobbvHw
 yJzkb+v36lC43vQdziS1Uw+6gWA6KVouVvRDnRYCWQo0xWleQB/01BMHQB9yk5iBSuu9GDCo9
 VSTS3gHj4/AyiW06y/Sj10u/IVSRekwDMf/0AY+5ca3iOb9hDPgWTDykjlYtS1toiNbsN06FO
 cgT5ucbIlrTjrzXVDjVWNjq26upUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-596184923-1485792975=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Exchange the values of graph->columns and graph->new_columns using the
> macro SWAP instead of hand-rolled code.  The result is shorter and
> easier to read.
>=20
> This transformation was not done by the semantic patch swap.cocci
> because there's an unrelated statement between the second and the last
> step of the exchange, so it didn't match the expected pattern.

Is it really true that Coccinelle cannot be told to look for a code block
that declares a variable that is then used *only* in the lines we want to
match and replace?

I never used the tool, and a quick web search did not clarify the picture,
either...

Ciao,
Dscho
--8323329-596184923-1485792975=:3469--
