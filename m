Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069891F859
	for <e@80x24.org>; Wed, 24 Aug 2016 08:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbcHXIAR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 04:00:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:55942 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754040AbcHXIAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 04:00:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lomql-1ax4wj2GYl-00gntf; Wed, 24 Aug 2016 10:00:10
 +0200
Date:   Wed, 24 Aug 2016 10:00:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
In-Reply-To: <0ee82126-3fae-723a-ab89-b5794c4abc74@web.de>
Message-ID: <alpine.DEB.2.20.1608240958070.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de> <20160819085700.GA23254@tb-raspi> <alpine.DEB.2.20.1608191656080.4924@virtualbox>
 <0ee82126-3fae-723a-ab89-b5794c4abc74@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-784864794-1472025610=:4924"
X-Provags-ID: V03:K0:LBMqdEEQ8lXK4vI2PPdGClciTACj5CVJfyF8qaS7hZx8Fk2iYBQ
 AOQx9faFuLh9A9POy7Q69hq2pfCj3pwgNAULpXmC9rMh6CIxnD7Mtksc8VtC0iT/8oSwr3Z
 e+kH0jlKdWMfFeDzBzJXVNE59tWkI1tlRyOznkgLJaHarn0P3jGnE7taFD/7fT7VRL8cZKN
 HxurrPX3AIxGqokt+xq+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3i+prGTEm9Q=:+XFdumfM0sQvQq0opgjniQ
 5S0WkY0eNkKvqg2scEbk1zjwcyusvLBLyOnpuK0Z1+bFgq+WXjWPshCB7r39kkGOCpVHlusco
 W0ebqImPH/vpXrM84/St4rIXRH/OwpnvbzoN0ZgQomNZfvEsApkvsVYmrtfytt0s335iy3yw8
 AtJ20sJgUyGra7E2xvZt1pW3gCsdY+DmGQoTQ3M+85l8OZwCLDb44/j3zY1fxwpFyLRUurEjX
 /nRhrmCqKwVYX40eLlatYTYC6mo3YP14w51B+FpaIc5TwfougCbOggaZI4f5hwAZTv4hS3k0m
 LMiogv1U5ZjTC932Hi6XdepcqF4abhdvHVrDHdYgXQLOTzyn06tQ7sR2U3TFnZKJyFhWd/z2Y
 3WWvgFllW9z9CFqkw8PFWN/vBWkeJqpORhL3r4QHIrtf5oVo7gjRjJKYRgwmC5dJouse0jvzi
 qCNovIhPQvhrJTWNJcocBLqxPvWp2yROJbzAwCnbrZ9VcKlDnJBCZ2iM564nGbT/WBaMlPkif
 dBNJc563mYszr8F1QB35OgtaOXoueiL3QkcBzh7VulExjhGMsjrO2CuVqGdLxZUcsZpDaSJDg
 g1LeNfih4CSazGx9WCqT0f+N1kiI7V38YAoz5z4WmEa1palBNa9C4zPR+4fFGvZ47NaoAPYoB
 QMmzJ6wQVPE5zBxl7smY4ItL5xctuY2wlXCu0FxNhml3/aTSTokXB/PLTtBOoGM62eY5A9Khh
 qz7NyYUSKsx9TxxxfyOSW/NTLqfDz3CGiEFz+eQ1AqeXdanVEMGo8IbX6v7DngX+UC//JlZ0e
 g5Nql8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-784864794-1472025610=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Mon, 22 Aug 2016, Torsten B=C3=B6gershausen wrote:

> On 19.08.16 17:00, Johannes Schindelin wrote:
> >
> > On Fri, 19 Aug 2016, Torsten B=C3=B6gershausen wrote:
> >
> >> On Thu, Aug 18, 2016 at 02:46:17PM +0200, Johannes Schindelin wrote:
> >>
> >>> +--filters::
> >>> +=09Show the content as transformed by the filters configured in
> >> Minor comment:
> >> s/transformed/converted/ ?
> > Sure.
> >
> >> Does it make sense to be more specific here:
> >> The order of conversion is
> >> - ident
> >> - CRLF
> >> - smudge
> > I do not think it makes sense to complexify the documentation in that
> > manner. The filters should always be applied in the same order, methink=
s,
> > and it would only clutter the man page to repeat that order here.
> Can we can shorten the description and have something like this:
>=20
> --filters::
> +=09Show the content converted by the filters configured in
> +=09the current working tree for the given <path>.=20
> + =09<object> has to be of the form <tree-ish>:<path> or :<path>.

I do not want it shortened *that* much. I, for one, would be confused
reading about filters, as there are so many of them. So while I do not
want cat-file's man page to include an extensive description how filters
work, I do want it to have an indication which filters this option is
talking about.

Ciao,
Dscho
--8323329-784864794-1472025610=:4924--
