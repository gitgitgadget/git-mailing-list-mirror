Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D6C001B0
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjHMTpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjHMTpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 15:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622610DB
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 12:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51AC061130
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 19:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A23CC433C8;
        Sun, 13 Aug 2023 19:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691955915;
        bh=eR9M8BaFNSQJiUPemW329wRdm2eyn/dn6zS+tGXGJPc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xw9CCksDMXPpp8PeroUJI7J6Ptnb6TlfIRDioX8TCkKX5dxlatx27PeODH1CphB6S
         vqitC9jM6SQDyqq/kfw/zpl4/EF58WnOEsZY8ZNtvClwfJOW+aljsfW/d7SP8q7wda
         7KW8vt7Eti9D+vLaAgJrFujrMzLuz29Uk6wTcFMIOZayqALOSxglDJ5xAhc1LHoXM2
         Vx2dpvqVBwIzSZCCXbIWmMq/XuYLB677D8Nz79rVGXBU87mgNEgDPZpFuL4/kC0UP8
         Hzzt7UD4fH7tmRUScNwkEZTDzzefxiVZctnCL6edZRoI3111oa+59aDzrzZPfMJCLp
         2nXfuIwBlBhtw==
Message-ID: <6b191540-c2b2-435e-667b-43c251b829fe@kernel.org>
Date:   Sun, 13 Aug 2023 21:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [wishlist] git-add(1), git-restore(1): -U for more context (with
 -p)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <8bbfa6fe-fdaa-aeaf-51bc-16b3d3f7afaa@kernel.org>
 <xmqq350mohgu.fsf@gitster.g>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <xmqq350mohgu.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------t9K0zOY0GoN25Gpwyy2RZNR2"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------t9K0zOY0GoN25Gpwyy2RZNR2
Content-Type: multipart/mixed; boundary="------------HkoPRmHg4Nnd2FB0HR2O5Gsa";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <6b191540-c2b2-435e-667b-43c251b829fe@kernel.org>
Subject: Re: [wishlist] git-add(1), git-restore(1): -U for more context (with
 -p)
References: <8bbfa6fe-fdaa-aeaf-51bc-16b3d3f7afaa@kernel.org>
 <xmqq350mohgu.fsf@gitster.g>
In-Reply-To: <xmqq350mohgu.fsf@gitster.g>

--------------HkoPRmHg4Nnd2FB0HR2O5Gsa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-08-13 21:44, Junio C Hamano wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>=20
>> It would be useful to have -U in git-add(1) and git-restore(1)
>> to be able to see more context in combination with -p.
>=20
> Even more useful would be to add commands to enlarge/shrink the
> context to the interactive prompt, wouldn't it?  Not all hunks need
> unformly large context and having to decide how many lines of
> context to ask upfront and having to stick to the choice during the
> whole interactive session would be a bad interactive experience.

Yep, that would be even more useful!  :)

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------HkoPRmHg4Nnd2FB0HR2O5Gsa--

--------------t9K0zOY0GoN25Gpwyy2RZNR2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTZMskACgkQnowa+77/
2zLOfg//Yo1GSiNLj0KHCmjLBM6+JxWhrMk1jCiamVMIk2H2ytATim8FFerho+ig
vzB/8mrppA6v4FRvS18LSlMpqxtJw9AhLRhsxwJS5bkbrxMkToefk0fYWE3Ni3Vz
RsrR2WHYO2dUoDaAigqucu6FOgqLCel8jKgSaaBYOJW/T8aoAati3Sw2Iw5l+YNk
wiJB/94wiR7SQUOu+K9ljtRY/qxaer6WP7BEXZfPpb9JlRaIqOkv/S+ur7jNw7dJ
toPEnQ/MMl3eToJt8Uid257lstP6BFiZ2akOFQgc3naWCCpK0ZHBVAdbml0Sj1lk
nmyZX+V3+2lu2BjyawPSB0lmCL1wqn8V5P66CF5XbClOJN99rzqq+AVYe2F8mxhK
Ao7n/11CuV9X6pXhwY0uJKDUaCFCRY8jEMVymd9VakLzHRDCyw6Zqf5ScY2ObJS0
3uwzrs6iEco+nLntivuZD7oBW4Qg/s40/M/Yf1DxoSyXugd4LYqRQQKCnCcw929t
Du5nJ6GX5+pv1lBoSsW+6sxGgIRHldsiJJvvPZ10QavBWWwN6VUVdRi2cY/wIVYe
DgmtGTVukuLJ7KTqZM2+BPa4/7FafDYyBgMOcQ0BbyWiVpfqQ/QuOQif1q/TJrPJ
6HfjNx5S1hB1vjWfVW+w7UJqMQ1up+8f/z1h2d+rP4hFQ1SP1Ws=
=V/ks
-----END PGP SIGNATURE-----

--------------t9K0zOY0GoN25Gpwyy2RZNR2--
