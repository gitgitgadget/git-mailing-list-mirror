Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5597207F8
	for <e@80x24.org>; Wed,  3 May 2017 15:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdECPUA (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:20:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:64408 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdECPT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:19:59 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfGo0-1dpx8L39JI-00onfI; Wed, 03
 May 2017 17:19:45 +0200
Date:   Wed, 3 May 2017 17:19:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 10/21] log: report errno on failure to fopen() a
 file
In-Reply-To: <20170503101706.9223-11-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031717210.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-11-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-958195891-1493824785=:3480"
X-Provags-ID: V03:K0:Qco1B9a1C3vdGIK7vl4oKIAU+ekaDtR01aF+RxYz3U1twCFDEf1
 20p+gkHavJ6TvIViwQwdzqmF/wkugWTVBID9KY8x7B6BqHfNWnnhtJdaYmUs9ozyBO9c+OD
 QFBXOR6DUoOhY0nesKTDw3zgGFC7Tug+GrE8/NShB5t6HfsxDOxwsSPa7zD5JuLItXhveuS
 14Lv86VJ6JspK2GE7YIDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aJgiPCgOHfs=:+RDfClEG04h7u9EBxki9R9
 zwGcj/jtr0kWrCVeCjnv4vbQJ8p/AXvWBEKa2TkeYDgLyNa6BQyidGc6x8Tid8lHv14p0rXAe
 DMuIyBlaC6H43y5TcebFE+XESb3UiXvCpp35MBqkEuPpAqhvXyMhx4sjvNjSLtehLYhoK45uc
 hadY+iGLuc1FWfOmPPe3VYpm6ueDcAoSYU/Qdqez+VL/Pm4T1VDrcg6hqZWp+xbaGz28x3SiG
 zQNLBlvTkW9ZvBlUywvKhaTCDZNKRctPt3XHCz4JJDe6G+UJv01lLqUr07At6THu0klObqx2B
 VSioFozoV+ud1uY8+/sWS1CGPCDVxd1Bb5zzboz9brzzH/+i6E/XXhi744CrjPTm9NtvoS7Ga
 bqQiGeiZLNmYSBZAZE5JXcwV8bs/lyUcC4QNYvTYDj6+jb21dnZq1x9a9FKkgGk3OfFPQ9wL9
 X0x45WKiKD/Xn0Er7PhfDAxD/nveMvhc57SjYFoVqKlTmBrA5L+MsG8WG0nVEYQhBoM1usiTx
 pj//Vj9ve+M1bi6pBkYW4+7+S3iH4kAi7JF0xKyjq0QkGkHox5zXAGD+gysEL3z4bptY8t4Yo
 tBAHHPY7fmRALk5AiGPEu9EwJ/rt2HYVG+ktVvnRbAc5AoiKUV1rbienVlJlDm8MARowiX1oA
 B0JKRUZ7+XwW6skP66Nji/9zTyzwm/C2GuXqfgph0rrLqTUv0dQwLKLalYjYyvI8KqpEpYjpA
 v9q4NN6G0N1KHHPz7JLmwgF2fIq+zfQB6aY+QGs6Q+IvHSce7RptQCCcjNLW4TJjEekQ6ux0j
 TSq4ays
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-958195891-1493824785=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

I do think that this merits a one-line explanation why you do not use
fopen_or_warn() here.

> diff --git a/builtin/log.c b/builtin/log.c
> index b3b10cc1ed..26d6a3cf14 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -858,7 +858,8 @@ static int open_next_file(struct commit *commit, cons=
t char *subject,
>  =09=09printf("%s\n", filename.buf + outdir_offset);
> =20
>  =09if ((rev->diffopt.file =3D fopen(filename.buf, "w")) =3D=3D NULL)
> -=09=09return error(_("Cannot open patch file %s"), filename.buf);
> +=09=09return error_errno(_("Cannot open patch file %s"),
> +=09=09=09=09   filename.buf);
> =20
>  =09strbuf_release(&filename);

The patches before and after this one all convert fopen() to
fopen_or_warn(). If you *must* separate those into individual patches
(which just makes this patch series unnecessarily bloated, if you ask me),
you should at least group them a bit better so that the patch series tells
more of a consistent story rather than jumping back and forth like a
hyperactive four-year-old telling you about her latest adventure.

Ciao,
Dscho
--8323329-958195891-1493824785=:3480--
