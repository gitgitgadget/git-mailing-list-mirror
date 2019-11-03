Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE221F454
	for <e@80x24.org>; Sun,  3 Nov 2019 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfKCS7P (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 13:59:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59872 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727322AbfKCS7P (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Nov 2019 13:59:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0039D6052F;
        Sun,  3 Nov 2019 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572807553;
        bh=Fj7TrRsRGFjuMXYGGUCZwRfheJ1KpVjSCQhG/5eZCtM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=c0q/Bg2iMSbhdr1oTufzgnFwNQ/ai7gBTvfBa/Lgc7G+Ft93OItR5nVDO5Vzy6gl/
         LZgpwyNv874Lm64/dTTdjmmdFdC6C9utXTKmgZvwCOTFhxZ8JpI0VLeEoqZ8wpDNOY
         rZ+2X+MSmkQF2j4ueat01co3REwn3lo3YhdExfGO2meMaukOjMnaLgN84UPQnhqUfH
         OeVPgSN0J/DKJeWZIChVg0o+Jtxy5w0VYPLMQGMQS+DVJwpV7qQnd2PVCqXSfyal18
         zFYL3qZpnV57cTcXI0QBOiT4/tA46nwpbAVCbdbSC6y+0QpswBdppEC4Et7gHx/1Bj
         PFS+/LZHv34e8r7mYNpMCwDzeoU0Jt/269ODaHyWJ5sAc1WIeLmCYoIEQ9ik+SoQQx
         6CumrubMKi+FEuTqPQu/era+ZQ2Q7EH+ccJB15/naM+tWoYf5Oy/Px3X8ycTlYIpw0
         rmI20JUA2erDCBEh4wku8EWc3d/xCPxlC39cE5SrbruruGuNGbG
Date:   Sun, 3 Nov 2019 18:59:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked
 files
Message-ID: <20191103185908.GA32531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20191102192615.10013-4-sandals@crustytoothpaste.net>
 <86h83lhugj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <86h83lhugj.fsf@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-03 at 15:04:44, Jakub Narebski wrote:
> Why the change between formatting '``assume unchanged''' (with double
> quotes and space separated) and 'skip-worktree' (without quotes, and
> kebab-cased)?  In the commit message you write about assume-unchanged
> and skip-worktree.
>=20
> I guess that follows the inconsistency in git-update-index(1) headers,
> namely we have
>=20
>   USING ``ASSUME UNCHANGED'' BIT
>   ------------------------------
>=20
> but
>=20
>   SKIP-WORKTREE BIT
>   -----------------
>=20
> This incconsistency is much more viible when both names are on the same
> line, however.

Yeah, I can change them to make them consistent.  I did preserve the
existing formatting for both, as you mentioned.

> I'm not sure if it is a place for it, but the proposed text treats
> assume-unchanged and skip-worktree as similarly unsuited for intended
> purpose.  However, their failure modes are different: (ab)using the
> assume-unchanged for "ignore changed to tracked files" may lead to data
> loss (as changes are overwritten), while with skip-worktree the trouble
> is that some operations that should succeed (like unstashing) are
> unnecessarily blocked - but no data loss.

I agree the failure modes can be different, but from my experience there
are people who have seen checkout failures with both bits set
independently.  I'm not exactly sure what those cases are, but folks do
see them on Stack Overflow quite frequently.

Even if there is a difference in failure modes, I'd rather encourage
people to just not use this mechanism rather than explain why or in
which cases it won't do what you want.

> I would really like to see a simple example of such template, so that
> even people who are unfamiliar with Ruby's ERB can think of equivalent
> solution for their language or toolchain of choice.

I hesitated to mention ERB, but I wasn't sure that folks would know what
we meant by a "templating mechanism".  The reason I had chosen to
mention it is that someone could search for "Ruby ERB" and find out what
it looked like and then look for an option in their own language.

My concern with adding such a template is that an example will likely
grow this section quite a bit, and it's meant as a short aside to help
people avoid making a common mistake and guide them to a proper solution
rather than a comprehensive howto.  I'm planning on adding a FAQ
document in the future that covers a lot of these issues in more detail
and helps folks figure out solutions to common problems, and I'd prefer
to explain this more in depth there.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2/I3wACgkQv1NdgR9S
9osEVg//VAfWcwTwPvYCkFWqa+sfx56a/IgDtVvKupSk5pIykS2UIRsUaANgVHdD
3QFfHAs4thJvanRg9wTK1nZZAM0WaNdhhrffXVo2XSBOrRydnT8RdUlVO37ESYte
kH+TWVBLKVa8d719ktDKD6qG+GD4BpwGOQB85HF1EabdoaNFS0O1ab6qhLZK8i+V
QJq5d5ZWycosI3aZ94awd0wuoidxsvEmWzfAjKbYc+THMuAHR86vIirt6lPU3FqD
nlE8ZRFEY4sSxEXsugd+/WhnaU5FMM8JqTA6TZlFoG9C8mYad/Bwi68dKnDXv85T
wJNX3+PJpPteByGjyTILHE/1kTas+eNhek4YHiiXjbIFtXhMpz5BxlJaZFZ0KPQc
GNRQJGRKjM1zhHz5lKR3Fztx7x/YbTCvorv+jx0DDgPGBwC73frPooht7+8yscTr
g356xX3AIWZgcB/GxvPx43EsG72Yb3Ei5K3qzEPlYUnm2MeqzJH2VHivcno6CUT9
e/bzUW003Zn3kX7sXqwusfwaitqH5j4V+gLPt5WZpgQggaqgJi1z9yLpmDubYCSS
ui6GjZBaC7M8dpp/ynUt9WVatwzpyRrapAGZrxZ9x6xgoEtmK/iGwB5x8mwCC5u2
E6OFUzQnfNF63mB+wrGW8NTV146mEACp+enaSmcCj2QjSIERP20=
=IutC
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
