Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24001C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 19:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F5921D90
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 19:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgISTzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 15:55:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34566 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgISTzv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 19 Sep 2020 15:55:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 49F4960457;
        Sat, 19 Sep 2020 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600545349;
        bh=2jCxHCGS+tMvADEQ7o5mTT5r4ryXf75GuPXUTPBJHjA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Im46Y/rG4LeleMFfVx+LswmjW/kkvjLhOTRxoZz1B6iz9ufepSksqW0HAd5oxzvr0
         vLgd9wgBvi7Iqc/2Lq0ocMoUi/wCvO6VnehKps037PVrIjrzDGMha6d5owTk7VZy67
         haBJebLHConhBwN4vwoXtt/4g6Z31KhfUeVXjYw8I0CUOma1I2drbjjcNZoNsd4fW4
         lsPz+aWBjep6IZ5rXtnxnHXixPYkgWXxYcpbgRtrAf9V2pMOZulgNR2dgG0URfORZ6
         bouBrPvHCrqYFvly2ahwRmG0ovfseGQU4kFwRJvV77jo0Zi6tER+qUrijrS8V6yNwY
         QdBRBxu1ERaWE/kfV5pvUJ9gcmjCaf9ht/O8ejY+wh2SVzMhUGQRCGyzeiNvBdcSyK
         uIdbpkjAaMDpif8+qGn9opjJL8XnWTUyif/n7taS1JZErG9UZrIy63NabzVLn1DveV
         /Gr9D69+DOSJD+HqGdFtwgEcp8IbfYzOXkAy1qE1WHboiYq4/To
Date:   Sat, 19 Sep 2020 19:55:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Joint project with Git for outreachy
Message-ID: <20200919195545.GH67496@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Developer support list for Wireshark <wireshark-dev@wireshark.org>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
References: <20200918222103.GA3352870@google.com>
 <CAN05THSUN4YToYRqWUxZ0r2=wVxJU0V2iWumx1jjx=eTQ7rAYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <CAN05THSUN4YToYRqWUxZ0r2=wVxJU0V2iWumx1jjx=eTQ7rAYw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-19 at 09:12:53, ronnie sahlberg wrote:
> Hi Jonathan,
> Hi Emily
>=20
> Emily, you want to contribute to wireshark? That is awesome. I think I
> speak for everyone to send a HUGE welcome
> your way and hope your experience working on and with wireshark be excell=
ent!

I think there's been a misunderstanding.  I think the proposal was to
have Emily and Jonathan, who are both significant contributors to Git,
doing the mentoring from the Git side, along with someone from the
Wireshark side.  I don't think we know yet if anyone will be interested
in working on it, but it seems from the response to be a proposal that
has interest in both projects.

Feel free to correct me if I've misunderstood.

> I think a git dissector would be really awesome.
> We do have a packet-git.c already in wireshark, but looking at it it
> is very barebones (understatement of the year:-)
> but getting a real full blown git protocol implementation would be
> totally awesome.

I agree that a Git dissector would be an awesome addition to Wireshark,
for all the reasons mentioned, and I do hope someone is able to pick it
up.  I'd personally find such a feature very useful, and I know some
colleagues who probably would as well.
--=20
brian m. carlson: Houston, Texas, US

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2ZiQAAKCRB8DEliiIei
gfccAP9f7Pc74zHLEOjonaTfo8IedAyruzV/wFGrE3zGPqZmJAEAnPU1/j8gRpfe
EReDvu3ZHFhPj2v2XTf4lnwOqlnNnw0=
=yugp
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
