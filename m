Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835981FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 00:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753762AbdJIAvt (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 20:51:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54564 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753743AbdJIAvq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Oct 2017 20:51:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8FE8460D91;
        Mon,  9 Oct 2017 00:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507510305;
        bh=tLjO+sDY/Ofo5md7K7PZcOCg2r6uaD0ll5ClRzCnxTw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0lQnRoX2gFXxaG//d+Xn/OMtyRG+f+TgSrQubUhxGygTl2d/Z2hbj2dX49VpGNdzC
         0Ey5bgNp6TnXyUANeypSH1CM7XlqFqJaZ35jJLYRmB34uUNK3DUhjk8bZ5L6GKiyYn
         kzK7dsOkKmEXTmKJDiFkwzJQU/zvZ2Lthsoeep/QbGnvn7blZjetnLUZG4F3QxttoH
         LZHEJfOS74rjfUQWyrdk+IPJDFpvRPTpVDGDIl/5D2c4SMSBZcSGFhqDoHnij89YjF
         j797tx6Jb73hpzvpDM+6ke1y5/2iFGTLTO/Li1FDUi1ue7fhhwdlwg9xnmllwYPCfX
         zVfzLW/uYQ3HOmHYA1vWVnTblzAWPjxubgYXV0BEFsSxgmOV3mEHrBPind38ObbYTE
         fLktkZemdQVx2dBP6p6ErozoNR4DoMJI1Pdblk4CGHah0r6QzqCbD1WboslokJXi84
         0IQxrz+6LKPB6OWKx/UieHPdPAWLCOsK6zxQCAe3Dwoe9lxzYJy
Date:   Mon, 9 Oct 2017 00:51:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?B?RMOtYXo=?= <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
Message-ID: <20171009005137.4qwvkpedjslvbkca@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?B?RMOtYXo=?= <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>, m4sk1n <m4sk1n@o2.pl>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
 <20171008084824.5331-1-martin.agren@gmail.com>
 <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="znvhucwbrec2xvty"
Content-Disposition: inline
In-Reply-To: <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--znvhucwbrec2xvty
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2017 at 10:32:35AM +0100, Philip Oakley wrote:
> From: "Martin =C3=85gren" <martin.agren@gmail.com>
> > - die(_("submodule entry '%s' (%s) is a %s, not a commit"),
> > -     cb->path, oid_to_hex(oid), typename(type));
> > + die(_("submodule entry '%s' (%s) is not a commit"),
> > +     cb->path, oid_to_hex(oid));
> Bikeshed,
> maybe:
> "submodule entry '%s' (%s) is not a commit. It is a %s"
> This puts the two parts in separate sentences?

Languages with multiple grammatical genders are going to have problems
with this.  In French, "a tree" is "un arbre" (masculine), but "a tag"
is "une =C3=A9tiquette" (feminine).  We don't currently have a Spanish
translation, but this would break there as well.

Splitting the article out with the type name is still problematic for
languages where articles vary by case, like German, since the
translation might be reused in another place requiring a different case.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--znvhucwbrec2xvty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnayBgACgkQv1NdgR9S
9osbSg//YxSBa3M/WeFwdOpZE4/A/dzJTIfi/Wc3riz3rNMKFSWTmHdo3aixUAcA
0Fk91AWmdL9zV9saYNjgWrAJ1xGfWMgjXhPIueHYI7VaGZ3SLbFhM2HqfH+0AcER
9A/eYD8T4D+bmMGRaPUYz9mnh2QGKaIsY7fHcAOzXOGlCOUtHcbTn5i5oQ+DgsC5
u6AjhQMnKMjKprn1tUBa4BliFufCZywUo4edE+jLf0NzJBbCsnWzwmJVCaBj/lLx
Z6X/QE+K9WoW8jrXdBMuFzMOCmv80/dYo0KeyHSWk4H3dyJgPIwzR2XwoS2eWDyw
WCWups89NghJ9ZBEFjMlll11OtLcSlcBJAl/0qwvCJDP8ntRRISlVBds8PW4PbGa
qtjIoSYuO+sRkdbog7qWVt8/jvjeVh+95I9sXvT+VYjelkVn6u7pVZTCfYHtxThK
NzQMow67F6R9Q5nUPqwKU8hTgNk6H/xB5UOb2qaUpodIyESK5nmRcjig15RyqSqi
YBVNVyfuIy+HNHMZh0RAhb/gSHVRsmjnW4kqyaVwaMnrwfYSw0PPokmHbGlUYuBe
huORhRbtC6IXz2hzRNxVgd3jMamM9Tvl0XC7qMCQicVkWsn/+O45RbP51CkO1Ykl
mozGucQcY4gTiePtVnthaMjDEQICESYXFsPbp4LEsH1UeHRp2+Y=
=c8Nl
-----END PGP SIGNATURE-----

--znvhucwbrec2xvty--
