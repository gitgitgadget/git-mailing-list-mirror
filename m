Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46332C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 00:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9BF61090
	for <git@archiver.kernel.org>; Fri, 21 May 2021 00:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhEUA7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 20:59:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47336 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235619AbhEUA7u (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 May 2021 20:59:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 192FA6043F;
        Fri, 21 May 2021 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621558707;
        bh=TfcYRJkDETV0MTmNoopczxUb6+vebrJJASiqD6fhAas=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=edLXAvwUqiW+uDrj8ZjZ5ISFD4ySek4W/QqErtIdhqsyUzt3A7Xh5NgFXahc/erqw
         /EzMbs2HSkp413pICoO22TWq4viD8Vf8xIt+0hATJjxuBt0tcmn+ao59gPVJzIwvdH
         Jv4xMesyWliprwr3dQZvS3Q85ejtBPIihOfQGcIf1GiSDowIZnuE/wgKVGxF7WhQjL
         32yY9XIb67KMi84jRNRlHsauEFhIPmJrLK+QYHx970Zn6oNqiO63c8Op2WauO1WatL
         vIpaSrwGgPsp8FTldUxseLcASrQE02VQhhdnsx7cOtq/BxsLUAQdEhq1QKRVv4ClTP
         2pjQ16qpAa1tMdhysReen9FPTPXyiHJ6ILWsa1XA/iSBleHW53I2CU/iEWdAN1T2HR
         VIu/TM94tCjBj1o8y9b6KNWnqsByPYB3FsZk9OYFEWl2MNUNC9LGn/Eko4Vttez9Fy
         Uj+0PLDKOzm7Mv4zX4NlLXtB33mxP0aSQ7Tmknvv2c11udi4aRD
Date:   Fri, 21 May 2021 00:58:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Subject: Re: [PATCH] help: colorize man pages
Message-ID: <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
 <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yHLRE97CQ2/X5xgx"
Content-Disposition: inline
In-Reply-To: <87lf8bqdv0.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yHLRE97CQ2/X5xgx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-19 at 08:41:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> It also doesn't seem to me to satisfy their FAQ point #1, i.e. users who
> actually want no color at all can just set TERM=3Ddumb, and we support
> that. The proposed patch is the same as having TERM=3Ddumb set.
>=20
> This NO_COLOR=3D1 actually means something like "I do support colors, so
> show them if it's important, but don't color things willy-nilly".

I don't agree.  The way I read it is that it means that if your program
receives colored input, it is not obligated to strip it out, but it is
obligated not to add any.  For example, if less supported NO_COLOR, then
it would render color it received on stdin, but not color its status
bars.

For Git, this means that we shouldn't add color, but if a user has
stuffed some ANSI escape sequences in their formatting string, we'll
pass them through.

> So it would be incorrect to map it to either color.ui=3Dnever or
> color.ui=3Dalways (as "auto" will implicitly do). We'd need a new knob to
> control the granularity of coloring, something like
> color.ui=3Dconservative.

No, I think in the context of Git it means, "I don't want color."

> I wasn't against NO_COLOR before, but after writing the above I think I
> am. I initially assumed that it was some redundant and more "friendly"
> way of setting TERM=3Ddumb, but rather it's some entirely subjective way
> for every program to decide if their UI elements are "text-editor"-like
> or "status bar"-like enough to warrant coloring.

TERM=3Ddumb turns off having an addressable cursor.  Git uses a pager for
a lot of output, so that's a completely undesirable way to indicate you
don't want color, since it makes scrolling backwards impossible (and may
even disable the pager, but I haven't checked).  For a text editor,
TERM=3Ddumb means you're stuck with ex or ed.

NO_COLOR=3D1 says, "I don't want color, but I have a fully functional
terminal I would like to use, thank you."

I should point out that I think you've misread the text about status
bars.  It says this:

  It is reasonable to configure certain software such as a text editor
  to use color or other ANSI attributes sparingly (such as the reverse
  attribute for a status bar) while still desiring that other software
  not add color unless configured to. It should be up to the user
  whether color is used, not the software author.

In other words, I think in this case, the user has opted to configure
their editor as they like it and invoke it without NO_COLOR, but has
instructed other programs to not add color with NO_COLOR.

Note also that the explanation specifically mentions the reverse
attribute, which TERM=3Ddumb will suppress.

> That's "against" in the sense that if git supported it I wouldn't care
> much, and wouldn't oppose a patch to implement it.

I will probably send a patch to implement it, just not tonight.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--yHLRE97CQ2/X5xgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKcFrAAKCRB8DEliiIei
gfbbAQD99zPtro3inx5BhD1i8JBBdidowNSLYYvDWrD088ut2wEAnYFcHe3W5oQp
48b94B0AyqYj/2Ak+bPZNNofeg9Bvgk=
=Teaj
-----END PGP SIGNATURE-----

--yHLRE97CQ2/X5xgx--
