Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3954C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 17:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiHMRfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 13:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiHMRfu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 13:35:50 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7002013D09
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 10:35:43 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7AA5D5A26C;
        Sat, 13 Aug 2022 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1660412142;
        bh=ZoejQiDLjnWsgviHGLwRF3se5TIa7Jd+QDM/zYZa0rY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DJUzESve4W45Ao6OgxcEoTPuTCSk5GvMN461iwY3dGnrMLf9pJ0MmTFV1IswtlYQt
         c8t26mVBSncMbyfFTGK0F4bAe3ZJVcjeKLun2L5mFLAZ3tznw2E1WxCkmowK9EuOfE
         j6YMmOBFGhFiLigOoehA3qAsh1pYqW7PiWYUgHtbR+HfdjTRZnN7py6/CXvPSYY2Kj
         8n7BKltbw7kWahjS7DglZwSa5A40K/lLFaJNgzoXSDTjtyV/Ln9HwHiuR6ufEn3cGw
         zmcIJAxuY3mYlLXLnjILf7Uf0N/YH0d/WyCOxhw9J+B/co3wajlHenCXyQA8NSI/Tj
         xjjquj4wihZht5jUInJ7gC6PO5J/rhi7ofsApb0lsETgBwecDAUHYPiTDwZjDAWptc
         juiOtvZydasjB7P6Lv+7+nc/+tae1H8bojcSinkMucPG4wecQp5FH9dXS8jpJ/yxPx
         Yad3ORk5/9ynqQfMMDKwV5P/U2odmldT4EGPn5C0679PdjFmws7
Date:   Sat, 13 Aug 2022 17:35:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Todd Zullinger <tmz@pobox.com>,
        Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git maintenance broken on FreeBSD
Message-ID: <Yvfg7WwL8oCdxqzQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Todd Zullinger <tmz@pobox.com>, Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
 <YvZnQFVMZZmz9TIX@danh.dev>
 <YvcdskzUkocUv/d7@pobox.com>
 <xmqqczd4ag8f.fsf@gitster.g>
 <YvfFUuuydtYeuvRx@danh.dev>
 <xmqqsfm08382.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DqIyFR7B1HOtzJXM"
Content-Disposition: inline
In-Reply-To: <xmqqsfm08382.fsf@gitster.g>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DqIyFR7B1HOtzJXM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-08-13 at 17:26:05, Junio C Hamano wrote:
> Does FreeBSD offer choices of cron implementations other than Vixie,
> just like some Linux distributions?  If somebody on a non-FreeBSD
> platform happens to choose to use Vixie, then they would presumably
> have the same problem, so a compile-time switch, whose default is
> hardcoded based on the target platform, would not work very well.
> The default will be wrong for some users, and users can later choose
> to switch between different cron implementations.

I'm using Debian unstable, and I'm using Vixie cron.  I believe that's
the default implementation.  However, I could also well use cronie,
since that's available in Debian as well.  So, yeah, I think this is a
thing to consider.

> Configuration knob can be used as a workaround, but in this case, I
> am not sure if it is worth doing.  What's the downside of securely
> opening a temporary file and write whatever we are currently piping
> to a spawned "crontab" command and then giving the path to that
> temporary file to the "crontab" command?  Wouldn't that give us the
> maximal portability without that much code, no?

I think we should try to provide an option which works across at least
the versions on a particular OS.  The temporary file seems like a nice,
portable option, so I think we should just do that unless there's some
practical objection.

If Derrick doesn't get to it this next week, I can send a patch.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--DqIyFR7B1HOtzJXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYvfg7AAKCRB8DEliiIei
gZQwAP4zdcF9IHIV+8C0vZLZiHKczU56bYJUKpfr5KurScc9EAD+Nsn0Hvd6pvAl
auODhmwj1c6YoPQ7mCDK0EoJqX+OSgM=
=FbTt
-----END PGP SIGNATURE-----

--DqIyFR7B1HOtzJXM--
