Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86D81F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbcHPQCH (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:02:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:56565 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbcHPQCH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:02:07 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LoVvG-1axrrC3oC2-00gZka; Tue, 16 Aug 2016 17:55:17
 +0200
Date:	Tue, 16 Aug 2016 17:55:15 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	ryenus <ryenus@gmail.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] rev-parse: respect core.hooksPath in --git-path
In-Reply-To: <1134106438.1228353.1471361364992.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Message-ID: <alpine.DEB.2.20.1608161739280.4924@virtualbox>
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de> <ce8891377cec31cada49208f2d192dda86658e40.1471353054.git.johannes.schindelin@gmx.de> <1134106438.1228353.1471361364992.JavaMail.zimbra@ensimag.grenoble-inp.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1853737729-1471362916=:4924"
X-Provags-ID: V03:K0:+9RNBkHhruY1/PadwnVYz0hXcAeoXdQTrnzQiLr4JjKUGbYsuEs
 orwjEcaCDleL3rVdZ53sjgc90Fs4PptY0JNK+PxhJeiDlBrM0QDEYx2pq1no5AY9JJWA99f
 kSmcBgi6PVS+MlOm09dSD9gZYo0Jh5FUgZZOReOejy6/It20Vt2TMSAxkxlTtzchPFO0Pli
 iS38Vtq38ojw2VahHVJtQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:4zLn4Q0D+I4=:NFywfKB8aFztyFy8xM4qtI
 J92fxKDDyKmf8KW2Dlapv9e+/eZSHtBcvB36zKwf6MqotjcOstY1btH2vfgnuX9qhx1WE83+M
 L73vui12kxMFvgZLRt4jYyqcn/hKoHEcfGgpvXK+80ZWbG9+WFP92onXmaxKiBOEU0bXAQ3Nn
 i/8QM7gpFMtHtlMrz591btpmHQ3XVu+6CMBu6Up+3fl+uGaQyBvHMGvDCegJ4erIhmADMlQhG
 0jLb0On7ZmqKaOpkZoUXzD/YgogKfYI3lzRUMkQ/FQDtZIKYo+kgYlC7oXXeIev+EZuUh6IyQ
 OdilEPebRX+xrmAxn8YhXl4YaUd7OhwQ8O1vGskiM8/DQzLawVv1bsFLGye7RhVA20ilrwDwd
 t7S7coP86F2nRPEC0VL7n2tLi/kbLJvoDu+L6PEkDlIF+g250AqE2KA3X14zPjvJSWSU5zT5K
 a1GIyvRpvtuwVZwnn05j3VRc1/oK+m39CxG+j+bQiUjh3X067vFZluYUfzT8Vx5oJ5Rsc0MFx
 CMl7/eU7xWfPytlFQs1oIxp8myiyhl4f8UKHjDezLbEqz/j2mqZJGkEYAqH0p5EiI0pr1iQrq
 GQW/NxkiwsT3cwSVjHvCHe1w6isjalVKpiUi5N0NA5Cfk+B8Gaf2KT17i0d5UqpIbvBNLVLHN
 7odxxpXapws1uzf2FHqF4OYlLP+c8K1ab1lDwzyj25u3K9zyY6oIoQS4WZi3FmXlIEl5Fm8Qk
 mv8UaIkEzaM2K2Lea7LfWIntYxNvTQDi1T9cReJgi4MYiQz7+/nuGKyYHe6hvByZqfqIxQPw/
 wP27QI3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1853737729-1471362916=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi R=C3=A9mi,

On Tue, 16 Aug 2016, Remi Galan Alfonso wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.s=
h
> > index 5e3fb3a..f1f9aee 100755
> > --- a/t/t1350-config-hooks-path.sh
> > +++ b/t/t1350-config-hooks-path.sh
> > @@ -34,4 +34,10 @@ test_expect_success 'Check that various forms of spe=
cifying core.hooksPath work'
> >          test_cmp expect actual
> >  '
> > =20
> > +test_expect_success 'git rev-parse --git-path hooks' '
> > +        git config core.hooksPath .git/custom-hooks &&
>=20
> Any reason to not use 'test_config' here?

Yes: consistency. The rest of the script uses `git config`, not
`test_config`.

Ciao,
Dscho
--8323329-1853737729-1471362916=:4924--
