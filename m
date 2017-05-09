Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728311FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbdEIM4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:56:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:60793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753905AbdEIM4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:56:14 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgszY-1dLKDO27sm-00M7I6; Tue, 09
 May 2017 14:56:06 +0200
Date:   Tue, 9 May 2017 14:56:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/21] remote.c: report error on failure to fopen()
In-Reply-To: <CACsJy8BHMk4Xe+vjDke8tVUwMYsu5HCoLHVF9tArhE6L0Hu3TQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705091455240.146734@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-14-pclouds@gmail.com> <alpine.DEB.2.20.1705031720000.3480@virtualbox> <CACsJy8BHMk4Xe+vjDke8tVUwMYsu5HCoLHVF9tArhE6L0Hu3TQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-986515764-1494334566=:146734"
X-Provags-ID: V03:K0:daL7lU+g2xcMGq9iJgMzDN2JkRoOiBJWeDhjORbXYDy3a3K83g4
 VBcUFZ54u+iVVy/GyXbo+EyS0WwPOtzcsWeGOji9B4/0Y/DmPU4I89ba/4FgahPvA9m/BNG
 gkIgBWxIeACnMrCVYSkfqJqrlMEg3YrfQxRVi1JSFX3lTrmIoPSmOelMiBUshSWdLmB1+o5
 VpDbXIaSS0ZqZlaSadQwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5eWJQYlfomg=:1e5/EUjM+y9YTP4+OzQFQa
 N/Q6p7R8QL+AR7V3gPkWe4onWRs5Ksfld+ZXMpS0K7YXaBphYjjIyj2nX/S1YjuQBX3Epb+v0
 PgQGghSfPYd0KnkeFGlDgTUiFDN9y4DhNF4bozn5MMv9amBAL0Ey91RzEdQu+VRpGihUNAsxa
 n0JxEbgXRMbrtdDvs7dFPgF9MrC3CS8Ce0aj942MGdDXCe7cAAlarS8q9jyujwgGdsMFSRZ/l
 sDXgTwH6qkNaa52jlpqZiWhGFlprCGvs+HprFcw0lL6Q05bp+gbKKo/pkXFuD9WRfBye5soYV
 cnTKiNM7ZcYcIK+XFvktUpor/wIuFLGEaXCwrvmeGPSQeYWdfyuhDQIxb+sz5DJfIZwVZnn5C
 YvNT+2weYsV5gmtF6MV/sG2T86jH1srmrx4rqx8ha8fOHGyuEY96fWLlueBY1ymwsoWE2+MZ6
 6LfmJg3z4qe5cTovNyhwj/6kommmm6VuPoveqTlWllZKKEzR33Og5DXfcqr81wZfzftJUrVtE
 7zJnA08KgapqVTM5UKZC/5bk55sgdCPE3Ugla0mCRByYvm3aWitSvyXzoI+oAkUdspm9nt5xF
 WLaYGArg3npB0w/qPDCyIjyZedWey9HnxNqHvZV6lSZ92k2sucF8tQgJJDawv7eaFwRVqDy63
 5xqAjF66zOoNhJrsqyBlMzNF01J2bxSg51aODROqI289+4jzZ0tJvUu6d55j/wlDmzl8AwLTX
 GxBQaIjRgmc48VAeWNsMMKz0eiRHePC6ANCcHzZQqhdNf48+KEDsBunXwxHNpcsc25qkK8S+z
 GMUStwl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-986515764-1494334566=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Tue, 9 May 2017, Duy Nguyen wrote:

> Sorry for super late reply. I'm slowly catching up.
>=20
> On Wed, May 3, 2017 at 10:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Duy,
> >
> >
> > On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >
> >> There's plenty of error() in this code to safely assume --quiet is not=
 a
> >> concern.
> >>
> >> t5512 needs update because if we check the path 'refs*master' (i.e. th=
e
> >> asterisk is part of the path) then we'll get an EINVAL error.
> >
> > So the first change in this patch unmasks a bug that is fixed by the
> > second patch?
>=20
> The change in read_branches_file() in this patch causes the failure.
> See the original report [1],
>=20
> [1] http://public-inbox.org/git/3a2686c2-6766-1235-001f-1b5283b5f408@kdbg=
=2Eorg/

I disagree. I do not think that the first part of the patch causes the
failure. I think the failure was always there, we just did not bother to
report (and catch) it properly.

Ciao,
Dscho
--8323329-986515764-1494334566=:146734--
