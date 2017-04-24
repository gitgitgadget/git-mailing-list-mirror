Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3855207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 14:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169557AbdDXOBQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 10:01:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:55295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1169447AbdDXOBO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 10:01:14 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTO3f-1caypH0O8N-00SQem; Mon, 24
 Apr 2017 16:01:00 +0200
Date:   Mon, 24 Apr 2017 16:00:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v4 0/9] Introduce timestamp_t for timestamps
In-Reply-To: <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704241559460.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de>        <cover.1492771484.git.johannes.schindelin@gmx.de> <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1179823167-1493042460=:3480"
X-Provags-ID: V03:K0:+4eqBHtvVVuEpk6XXkKF7HkPKfV/PqjJBk8c8547ibOhvIppyNP
 BY+bz1H0U54AcpLp28eAPjH3cW0qPJ7DC/ORPlak4cvf0sP6Q65awybtG7S2g7R+Fei/xwI
 xRi4lA4MkDYIYEd11mH5ZOKfv66R9OFdDv3H0yd7hKDKJIOg4V2Pq7fm6ol5dzrft/8FEf5
 Kfg7jR/CTdEEdMaTqr8FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6bwWV9Kf6HY=:pegGVL+goQcqNfolUL00ii
 M/FwDnQFagAmJ4Gc6JYPfHHhDsifJ043ceWrmHEkDZZim9ZwkH1w9Zy2vP7+R3aNgUHR9Lxwy
 L47imQk/QYsJIv9/eWTsaZan9M6EUiLvqcNjy6etMUAr1ogqKqEIPZg2AcfUqByHOptltZ2ZK
 i36swzh4l2Ajy/CzN51HswBsbKKVHenm+lPnlc3S3mLGY3NrUhLIR85rSkU5Ocf2L5UNRoblE
 gko5jej3k9N1zpfmootL6KdtzmLaACgbqxOPSEQQe+uBc2MtM3exbDZxQ0W2ADQ363tX6f4cW
 /tOBkX5QDHUxX7LZ+Vt+evogPX3+3Bsp9uSbsy/6aXyN6t7X0TnHuqHFJd/Dah6IYMkd8hTin
 wena+rmk05DQ5twN7lwF4Q/XhM+V5nyABJFwRaWJzeTfS8E6pjbbiuD8eXN8ck9vvitnu50Vv
 yaNERriN5NiHYN72r2hiVHPW2SeqoeRQft/11fF0VAS72wfpZE9WDNo5leXArjUvbd6M+q6oA
 1+dLCFTbI9PWgPFH7OSPMPex0UQgGh3h4ObLzw477u8sQ9WG0iCwAEKSr/3FD3FkEC88oUJhL
 wl+Ciu9suWT0NNnL0q4NBAlkB4tGNie4E/EE8N2A30rThIr7NMhXn3wDDHP3ZdTZJLwrC51Ix
 CBWVZDFwnMauEsvtbZCF9rc+9dhmizY8DYVBqgpW1ygcXMmFr/Q94g+GYLGrZXuzJovSILUw8
 dhEaoF6zJhhNRJy/qcMlXjvx5cyeu9uwa76lVkM5lzqVpwRBjvpKuJfTJrzB7khC6UGMi9GBe
 B2KfR1l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1179823167-1493042460=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Sun, 23 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > Changes since v3:
> >
> > - fixed the fix in archive-zip.c that tried to report a too large
> >   timestamp (and would have reported the uninitialized time_t instead)
> >
> > - adjusted the so-far forgotten each_reflog() function (that was
> >   introduced after v1, in 80f2a6097c4 (t/helper: add test-ref-store to
> >   test ref-store functions, 2017-03-26)) to use timestamp_t and PRItime=
,
> >   too
> >
> > - removed the date_overflows() check from time_to_tm(), as it calls
> >   gm_time_t() which already performs that check
> >
> > - the date_overflows() check in show_ident_date() was removed, as we do
> >   not know at that point yet whether we use the system functions to
> >   render the date or not (and there would not be a problem in the latte=
r
> >   case)
>=20
> Assuming that the list consensus is to go with a separate
> timestamp_t (for that added Cc for those whose comments I saw in an
> earlier round), the patches looked mostly good (I didn't read with
> fine toothed comb the largest one 6/8 to see if there were
> inadvertent or missed conversions from ulong to timestamp_t,
> though), modulo a few minor "huh?" comments I sent separately.

Dang, I forgot to Cc: Peff and Ren=C3=A9... And I sent out v5 before adding
them, sorry!

Ciao,
Dscho
--8323329-1179823167-1493042460=:3480--
