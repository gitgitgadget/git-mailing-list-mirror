Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E1D1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936458AbcHJTVI (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:21:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:53485 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936601AbcHJTUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:20:50 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MCcja-1bO8zr3jIg-009SAj; Wed, 10 Aug 2016 14:31:38
 +0200
Date:	Wed, 10 Aug 2016 14:31:34 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge: use string_list_split() in add_strategies()
In-Reply-To: <xmqqeg5zf8mh.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608101431300.4924@virtualbox>
References: <57A4FEAF.3040208@web.de> <alpine.DEB.2.20.1608081034250.5786@virtualbox> <xmqqeg5zf8mh.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-413365396-1470832298=:4924"
X-Provags-ID: V03:K0:VeuVHks3HXE/krrlOX6Svj68uiX1xI206zqkwSUIHTSTo5gZI1t
 11QayfAE782N1pGJJ9OdoWs+obO4uc1/U22ZUNGaYe6mt/yvm5QXVwNhUsOf7wPtH+BpqIX
 51tBzE59fPbMXYrKALqDOKxnEwX6GWjy7ncxuMohvEU8QTNo+elfoQH27kD5JzHyFIk7GMp
 5Ail1ZsY8AnHVQ0XK5oig==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:afsTNEF9umM=:cH7RdEB9Z/Z+nKZSYaskJH
 Id4BDbxXEsjr9Ht4U7FFRilwJ/y4bbgH2OiJSACbV3Rx9ueU8CGQYV45oxHHZ0CQE++YLL6Uh
 Jv9jnDV93SJperdR+DOpL0Qlh3bW3btltAFVuBg7v1SqOo/piNnPieFRxknxzNtiiFbTjzbOV
 L1CdqdtVshyoC+XiAdacjcsK4LxrUZM8NxxY9o0fRFh5+OP/kgXCiLK0Q/hz1C34MX+yPGltG
 KC4jX0EPQDHXYiBgGP4+sp/Pyje1zKYgbSdpI88AyQUDdHbZ0SW+KtYNLJk/GZgq1x7alJ0zv
 RyRci1IgvTGtAhZF0LdWfEzNZ8+WhZpdEqVcG8UH9R5G49ubBkk/RmPg0+iUJaLBXe06HbTt1
 p7C7nh+Vf9N+Xmi48IPbJ9kIP2cWQcbn/0xbVfUZWIZsUPwt17vr6tMvUhz3sp2fQC7nLtBEX
 3qTisBLyyYLkwLJX+T8ZZjQYVSu7z7xH3tAOY+9lloURcmg5RvD4q1YgYdupNIcF4r8damhlu
 iUwYIndJh2q5qPf3k44q8RricyzPJMG4ICYHEXOcGeDgGgG765unkf8UWqBpn0iHjYT/AjTQZ
 RZQdQowkgQKz7H7F2UC8N828vJG24W7QSvKAACrmaDz8GEjFh/yTnJ2ejAR3LAk6ecUkB5+xn
 DH8/9OuJ/8cJe0iJiJ5F0XeawhukrtmrILPmdjTOt3rOZq2HXwhR0cI7eKNFKL76Y9CcBipMS
 yabB6mxFpnkQTZYZF8vlNZNIShmU98QMXNjzBnS45EaGXOs2kkc1yDXzanvNV0rA/EftzoGQa
 hdXlBDc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-413365396-1470832298=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 8 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > I wonder, however, if we could somhow turn things around by
> > introducing something like
> >
> > =09split_and_do_for_each(item_p, length, string, delimiter)
> > =09=09... <do something with item_p and length> ...
> >
> > that both string_list_split() *and* add_strategies() could use? We
> > would then be able to avoid allocating the list and duplicating the
> > items in the latter case.
>=20
> I do think such a feature may be useful if we often work on pieces of a
> string delimited by a delimiter, but if the caller does not see the
> split result, then the function with "split" is probably misnamed.
>=20
> I however suspect the variant of this where "delimiter" can just be a
> single byte would not be so useful.
>=20
> If the input comes from the end user, we certainly would want to allow
> "word1  word2\tword3 " as input (i.e. squishing repeated delimiters into
> one without introducing an "empty" element, allowing more than one
> delimiter characters like SP and HT, and ignoring leading or trailing
> runs of delimiter characters).
>=20
> If the input is generated internally, perhaps we should rethink the
> interface between the function that wants to do the for-each-word and
> its caller; if the caller wants to pass multiple things to the callee,
> it should be able to do so without first having to stuff these multiple
> things into a single string, only to force the callee to use this helper
> to split them out into individual pieces.

All true, but I guess this type of complexity would really complexify
Ren=C3=A9's patch too much, so I am comfortable with the patch as-is.

Ciao,
Dscho
--8323329-413365396-1470832298=:4924--
