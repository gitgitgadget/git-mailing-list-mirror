Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C979C1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 11:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbcH2LIz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 07:08:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:57529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932713AbcH2LIz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 07:08:55 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MSv6D-1bUnmc3bC1-00RoWi; Mon, 29 Aug 2016 13:08:31
 +0200
Date:   Mon, 29 Aug 2016 13:08:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/22] sequencer: introduce a helper to read files written
 by scripts
In-Reply-To: <1472464060.4265.27.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1608291307560.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>  <c0c7caa40a452ed9328c21302e4399562d40ec12.1472457609.git.johannes.schindelin@gmx.de> <1472464060.4265.27.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-336853332-1472468911=:129229"
X-Provags-ID: V03:K0:RwSMG8LWM4YyU8sR3OXdb/kXM+7l7ZaiwcOYJWrPOIJOWbpAzbn
 lSgor7Zr/LaW7BUspYTilciqiR/01Dl8L/mUJi5CmndpZ2uaVjHfMgt9I5G8MT0GxAboiVk
 IJoofknA8gMsA60LSxC/8Am9xm1YtRZk07Xhnh8SHwOU0FvzYYKwInQQ1QdfN8vW1ctQCGZ
 od5Viz50r+E3c0N5CEiGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5qt91VFe0us=:0WENOVtI/ViRLbH2GKC7ID
 U5wdvCPeiWsZiKgK4uj260FUtjdMQOJu3JZrzIiOyn8R5GrNPAOvoAmQD5Y6GNQlPggDfxNqe
 MRgEjuAf3cmRrFNdxGHMh2wWpXllC7Hofp2lQLCQGOnJ/dEnfRgCx4HAmAdrUsgAZUSn8o9P3
 IzHEdZAjyAlNNtnnY6ML2R2thLFDfrBsj4BfLZB1svxQHrN2KXYPSX9e2pQTpcgBWvZ9B7yfc
 9xh0U2BQRh/r4hIear2FJ+sSfeXMr9GKNQ07lLKuCSuz/kSBmCMWAysC2/GPTMAjUGTb2kVLU
 4l16GN9Yuw567mn6nXDpWg+RDe5oozJ6ju+bCU9Ef2pw9AIZ+q4udA03GFpNj7Qu5DPpv0SD1
 jHZTZfBh0DWnN4/+FKz2XtjgwRWgW2kYsNqW+2eIKORULxt0k9+Vbs3gEuPczMaKye4jUBHQz
 vy1KTWH5R+Cxg/635TxMZV5cW9lAxAaqxIGdwSjlgbMTme+xbHKp98j7lVTw8TuvGfCYlCnwI
 wgNB9ScSZ+EndZ8m29jVGbJYIOtsMNulVcKt90IZrlfhfRVM1rmyfYQn5jCKljBnP69XNUGcU
 XX7PX2cn4w8TQofj5lFrtjOMXzsWNZ5PsFVx7HkejJfDSwWBWTUCLpm6x7zECjfjho3Ct93NA
 QYBvW3Crwvti2HrYBfFzq1kBKmmysXu+8guIdWedNceoKYWksl7nO+N2S6vEKRiHcYuGR9Stp
 4x9PhqYj/WM+upupCWe2+/Ys7Y1kOsijf3a2PG580DY4Eop+jPx7HGXyFJWYEqZHgNi9QuXLe
 dAnlLbY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-336853332-1472468911=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Mon, 29 Aug 2016, Dennis Kaarsemaker wrote:

> On ma, 2016-08-29 at 10:06 +0200, Johannes Schindelin wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (strbuf_read_file(buf, pa=
th, 0) < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0warning_errno("could not read '%s'", path);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (buf->len > orig_len && b=
uf->buf[buf->len - 1] =3D=3D '\n') {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (--buf->len > orig_len && buf->buf[buf->len - 1]
> > =3D=3D '\r')
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--buf-=
>len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0buf->buf[buf->len] =3D '\0';
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> Why not use open + strbuf_getline instead of hand-rolling a newline
> eradicator?

Because strbuf_getline() erases the strbuf instead of appending to it
(which is what we sometimes need when converting shell scripts to C).

Ciao,
Dscho
--8323329-336853332-1472468911=:129229--
