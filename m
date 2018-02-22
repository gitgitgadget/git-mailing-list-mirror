Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7B41F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeBVUM6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:12:58 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:41068 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBVUM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:12:57 -0500
Received: by mail-pl0-f43.google.com with SMTP id k8so3509267pli.8
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=lxAv1tXEWS2xLY57idcXfDqFqdEtx3j7NMoyBTbFo8I=;
        b=sjUKRFbpfVnz7v2VYBhveVfEEFzoW9UpdVRnaD/nc+ZQICgEToyGfbUPcEwbsKJG33
         R0e2YgUoQvV9J+zg2Bk3L2I6h18lPq9sDZL+sOanBz6MIJN8TvNjpmJVoBUi83ScaiC1
         JBR5MVGaMATjeC8CYLkWGOcQ0MmGueGmB87BKJiQY5NrzwRNtFP1IKLXDA36zRxxayee
         2t6wCDh/Mnogoq0YP4/x3cavQSeHqZOOaIQg1O61wzRRa6p9iYZRzJ+NZ1C9WS7cpKVd
         hQatYlo1R23JrQ+pxNQN/+eXILWdpwoHKnI0Kmp+r94zO+/QljQJkcKWwdWr8ReXmcWB
         0pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=lxAv1tXEWS2xLY57idcXfDqFqdEtx3j7NMoyBTbFo8I=;
        b=E2pZiDMJ9irMMNwSI6BKBNhIs+BWKNcN988d4Wn4enq/7eetL7rFx7QEokJOKTwTNn
         JoN03Q4ZGsrXWhe9buTruVsK8Td8tkncxiXAGa+BzKnT9/c+cGWwRABXW4tjrDy7K3vE
         h/RCP+GOFdyoZQ858FNq5/xK0fk3Ggw0IJz6SmAuQCdojKkYWwZLdBMI+vwhY0twnbYq
         ZlWITAhNGlc4oDOUryB015wzFxEubjofCW22xhHHVOoTITxWbmmSgmEr0ltCGOb6DW2i
         nmpzkXdNP34sl1IkqInMYqOcSUEQyySt9SEvD1j/yxNJNUMapBJdH9o6ElNiEMRIVVPJ
         vChw==
X-Gm-Message-State: APf1xPDc6GUrGaZ16EIdzWdEQ4W57xnHcWKXz9OUkW8JCSGIa+HbnTUF
        kar/X6f/SZVkwwQxqDD+GJ4=
X-Google-Smtp-Source: AH8x225XDUJxD0DUBGiPNvMhOFh3hUk+uQZL+XB8dVV/ZBQQUdnfR2XN9qwD0lSq0Spz4irKrTqTVQ==
X-Received: by 2002:a17:902:5914:: with SMTP id o20-v6mr7595487pli.60.1519330377311;
        Thu, 22 Feb 2018 12:12:57 -0800 (PST)
Received: from pants.nat.office.privatealpha.com ([198.47.44.221])
        by smtp.gmail.com with ESMTPSA id v65sm1310178pfv.61.2018.02.22.12.12.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Feb 2018 12:12:56 -0800 (PST)
Content-Type: multipart/signed; boundary="Apple-Mail=_1A39F2EB-E822-4A8D-AD3C-A3D9E97316A2"; protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bug in HTTP protocol spec
From:   Dorian Taylor <dorian.taylor.lists@gmail.com>
In-Reply-To: <xmqqbmggx063.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 22 Feb 2018 12:12:54 -0800
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Message-Id: <01B07AA7-B2A4-4A81-B1F0-E2EC3D6BFBF9@gmail.com>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com> <20180221221516.GA7944@sigill.intra.peff.net> <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com> <20180222053722.GB133592@aiede.svl.corp.google.com> <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com> <20180222100840.GD12442@sigill.intra.peff.net> <xmqqbmggx063.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_1A39F2EB-E822-4A8D-AD3C-A3D9E97316A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 22, 2018, at 12:02 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>=20
> I saw somewhere "Apple-Mail" and a phrase "repaste".  So perhaps
> copy&paste on the client is involved in the whitespace damage (of
> course the original could be broken, but I somehow doubt it).

https://doriantaylor.com/file/well-ill-be-damned.png

> For what it's worth, I am slightly negative on this addition.  It
> makes it inconsistent if we only mention it about _this_ flush and
> not any other flush.  It even gets in the way of learning the
> protocol by new people reading it, by giving an impression that
> somehow LF is outside and in between packet line.
>=20
> Thanks.

This patch exists because I was asked to write it. I don=E2=80=99t know =
squat about this protocol other than the fact that I followed the spec =
and it didn=E2=80=99t work. I traced a known-good protocol endpoint and =
found it contained content that didn=E2=80=99t agree with the spec. I =
then obliged the request to submit a patch with *what I knew to be true* =
about the sample that actually worked. I then followed the =
recommendations *advertised on GitHub* for submitting the patch.

You=E2=80=99re welcome.

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_1A39F2EB-E822-4A8D-AD3C-A3D9E97316A2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJajyRHAAoJEIqxSjt9ja+jhZcP/2QYeHtO2jWmI/pBPl7l7dsM
2hXeCXMZWjrp0RO3ZT/iN0zPjTWvEvZUyNN5pq3bkarJam4WIlJnl3f3Lh1O6iFl
va3gmGDutvlaua8BZfX8xKyD+jE5weZcCF+lb3mTLOMnU/7YhCbT6f35RVsHsfIh
Gu+auTkMJVnloX+aJWk9Adn487zVJVup/BaRI0UmTHH3RuNuBEJ54te90rSY7W1A
EZ0KyO1ihftb/7a6eeR/p8hEySb6E4+Q7+n/ZdyjumAOQ1ymYhB3uOHkzf8hyhL3
EbivJm3Y8OAGYVbbPvpChxE0NofBuoOOnaMBV08A4BQeCzKn/gaEn51MipPA9kv5
iVSmagOAPjPoYp6lql6SDNJYDQFuIe/Rb2D0rsFl8MSepezmitSgF05uLqXnpYQN
1rF8c3KaUOQGrgWIl1KG6i2P1LaK+jY6gE5o0LkkGu0FQyq2WuidkV+u/yVXGkBB
fqFoPve6PJzbGHoZ+JoNH9HTU+lUHPybwD6wh8g0LzEWlbAcyExBv3O/7zgv4uiH
qvEreqBl/0qzKLpsTKcaXFtcAE6YTV8kPEfWO7Sgr7MFlO7yAejHPjzl9OU3aBUM
pIIbjFO1U0ReLEZmu1HjfwOdCw+vpk1v/FC35Fw9GBn3VLFwD6cQ+jcEPLaQYQDY
avWd2IwMV439gqa3dxKx
=P653
-----END PGP SIGNATURE-----

--Apple-Mail=_1A39F2EB-E822-4A8D-AD3C-A3D9E97316A2--
