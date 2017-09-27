Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220292047F
	for <e@80x24.org>; Wed, 27 Sep 2017 13:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbdI0NX3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 09:23:29 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:50386 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdI0NX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 09:23:28 -0400
Received: by mail-wr0-f170.google.com with SMTP id w12so16440865wrc.7
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:message-id:date:to;
        bh=FEk8w4xl895ctLan17KlkevGvV7MUZyEITVMgzHgI/c=;
        b=DI42hk7t+e0UBwpKYydvs6gp39Xm+Xp18ayngT0msSz4ca48kwND1HUlCi7uT1KjaC
         CcUZyMb9VKKtEYjAKLZgh0mxKyTc6KfJVhkaLjTjBVp3SsvACevagp2wUdRck5DAkHph
         rwh8KxxBGp1Q6QS1juhMVwzxWlXS9rVaBOp5mUxiL7tyyYSD7FhnFZUYqy1apPUxXers
         ScOL2WSvpdgGwNlZDxMirMStkkKNR67IqCIvgUvj74GD37LAON3tkvV6iCazc6PVD2VV
         Ww1o+p44iSaEGFkRdvMfi5Z9qsNhqrNCawdqzGgCtEwj1Pqyfr5XiiuNda6QIFSg2CZM
         vlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=FEk8w4xl895ctLan17KlkevGvV7MUZyEITVMgzHgI/c=;
        b=ivC5H+Z59RtN6I1jmsov554vsPMcda0kPc8wiIwoR07tyAZ6nUANuWF2pKtaM623rd
         qf7XPzimdRpdS6lX8cuQo7X2748+0mvrXFBYe04qDHllP2wuMc0seWsYASpBO0wYsLnp
         cEau58C/4xEk9MWesIDLMnC+N/kPE0TtqVq//6yid5uNEzx9kVHGXU3KKwR8Fk/P4qrJ
         6U4LN92o/GDWRf19UAHAM6Yprh1eXEo69V76J+VnkEERvZ5rmdnvc0YhQc7AMiREYN85
         fEawPEt8NDn3+mSKYCvXbuapUVtlzvsp7yh50tCqhRIkHa/fhC4JjgkwnaCd5sJJuLN1
         cKgQ==
X-Gm-Message-State: AHPjjUjA+GPdOsIcvAebbkMI/RETPckEarWqisszKVqmPhE6y90tT6xB
        0MCy/Vslrps7MBOl1mic8bUoEa41
X-Google-Smtp-Source: AOwi7QCYxmTQBeeG7cWmItjRV45uXY+DtuS4XsNoAr08t48HlFRncqaxypAUqsKCF+gy5Kp6wVxXFQ==
X-Received: by 10.223.160.170 with SMTP id m39mr1365312wrm.174.1506518606132;
        Wed, 27 Sep 2017 06:23:26 -0700 (PDT)
Received: from [172.27.233.198] (vpn-muc.tarifhaus.ag. [104.207.130.146])
        by smtp.gmail.com with ESMTPSA id h29sm10874883wrf.76.2017.09.27.06.23.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 06:23:24 -0700 (PDT)
From:   Toni Uebernickel <tuebernickel@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5302A483-64FB-447F-9E17-E044FC631EB3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Updated to v2.14.2 on macOS; git add --patch broken
Message-Id: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
Date:   Wed, 27 Sep 2017 15:23:21 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_5302A483-64FB-447F-9E17-E044FC631EB3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi there,

I updated to git version v2.14.2 on macOS using homebrew.

Since then `git add --patch` and `git stash save --patch` are not =
working anymore. It's just printing the complete diff without ever =
stopping to ask for actions. This results in an unusable state, as the =
whole command option is rendered useless.

For illustration see: https://asciinema.org/a/fw6cy9Ds6CeNOt4RYknLYgOD3

Kind Regards,
Toni

--
Toni Uebernickel

tuebernickel@gmail.com - https://keybase.io/havvg
https://github.com/havvg - https://www.xing.com/profile/Toni_Uebernickel


--Apple-Mail=_5302A483-64FB-447F-9E17-E044FC631EB3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqtw0WfnqbGj2qtYvvngIZvYDXHoFAlnLpksACgkQvngIZvYD
XHppohAAsdp4zXk3HoEX++1E2hbBCKfkq52n8MYw8PjXySipNq/EKPSPedOICsiU
k4aRCs2irJJWDHbxhxZ6DXCNZNDRr2nqtW02kX8CN/8/i4B1Mwm1mny1Rk98/cGA
FHo/XMMR+MOymAnwy2Bhqfmn/gjPiuwcSeLKUS4vO+QyzSy1OcGGjQUk25EMnK6u
uWnK+jQQGvuWQvJ34UqubRFpTLrOUI9W69JXT3Anz8U96cWrpBeEbAOoCVhfetXm
GwSaINKJUycy+R9lQ1wIbpWNlv/GFGztC5OuP0PVpoYYp/+jMeDNijZi58i+40z9
gKm4aHksAY1K+ps/5pveAH1iI8Db/Of1NVrU6y9PRpaeaDcuYmy7kupcyPpyKFpe
jasoykAelBQ/D+BvtMQ64/XPFb0teChf39lRqBfUizdeSrnaXmeKCInDR31vmNVj
KcRfkwoJMXOIwlcb4pNmQuf5orN2LTtbUL+8jtZ11+g38PNinK6XsLILU2WbH1Qp
qRR1vxLKq0thUk5j47cZCem6CQZVKcOQFTSgVL/TX7QWM0JdvgtmOK74yNcMNu4e
CltjZ8PeyzI5P99AmzZAIWHmuKuxBVkX4S6NKfB909yIUAqiddxzMbdWzLW38ry1
lpyc5x1QUY/dNyJOdcislmYr67vMojrqwoFT08qT7S+C/rkjrz8=
=D0Dj
-----END PGP SIGNATURE-----

--Apple-Mail=_5302A483-64FB-447F-9E17-E044FC631EB3--
