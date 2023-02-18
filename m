Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF60C61DA4
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 17:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBRRIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 12:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRRIb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 12:08:31 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36F126F7
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:08:30 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CC5375A1A8;
        Sat, 18 Feb 2023 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1676740109;
        bh=BArvDLNO1pMfL2v5KfCF3UAa276u5hVzp804xyhfsKU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Vgefl3oPU83BHzPMQ0TIa2k2W2AXbssO7HJSuav2+84lpzkHRfbrKdzxVD9YSuMAE
         5ba7TW8G8wVhe04fuU6v9WXnc1Fc+rIKPh3N+1s1NFinaC6o5VFzVWAbYuf0brf6aH
         7s8czDaIPF1r0Ov2evMEWyh4PON/wLAivS0AumerSxKGvb1UTO3WyQJlIEYlEG3Lkq
         hXRhwAt1F0+0/Q2wfjUWgFIlg39uWSxP7gQhDpk+dVbl5M3QKXriGoEnTSiGZwC5aS
         aSpxw6H5CGsXHCD6sYxjzYFMb+oSvwtpg5aSlAfraXEo+rKThXcFA6jqJ/aj/3uyyP
         FeTR9wqoMMMoN8WFRXZwny7AcA6vbAJDOf35BHZswU3sKxqFKDn6ye2TncUnypADW5
         vsryxmQaZLVxOn+IcatfhLUDpkptZifdIdMSOp8EOXpUGj+swN5lfthW5v0LYd2JKE
         Ek4pRbM3uJeH5VmPThdjYY7Bme/RfLi8k7v1Z09dwvRCA11JeqU
Date:   Sat, 18 Feb 2023 17:08:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
Subject: Re: Feature request: Add --mtime option to git archive
Message-ID: <Y/EFfxe0GGqnipvL@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Raul E Rangel <rrangel@chromium.org>,
        git@vger.kernel.org
References: <Y+6G9n6cWRT9EKyl@google.com>
 <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
 <xmqq5yc1p7yn.fsf@gitster.g>
 <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net>
 <xmqqpma9m4i1.fsf@gitster.g>
 <CANgJU+VaF7-SJgGPqYGEV5VcJd_nTt2SMOQ5u9mNZ_wsArKT6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C8m3uuobZquCJB84"
Content-Disposition: inline
In-Reply-To: <CANgJU+VaF7-SJgGPqYGEV5VcJd_nTt2SMOQ5u9mNZ_wsArKT6g@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C8m3uuobZquCJB84
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-18 at 03:04:12, demerphq wrote:
> I could understand this position if letting the user set the --mtime
> implied some harm that must be mitigated, but it seems like an odd
> choice if there is none.  Especially given it would also future proof
> git against people coming up with a good reason not to use the 0 epoch
> in the future that you haven't thought of right now. It is not like
> epoch's and unix time have a totally uncontroversial and stable
> history. 0 has meant multiple dates over time, and the current
> definition of 1 Jan 1970, 00:00:00 UTC is problematic as UTC didn't
> exist until 1972!  Given it clearly wouldn't be hard to allow users to
> select the epoch in these archives then why not do so?

If folks want such an option, they're welcome to send a patch to do
that.  My approach is providing a stable tar format that doesn't change,
and for people who want to use that format, it has fixed timestamps for
trees (so it's completely rigid).  If people want to use the default
format with an arbitrary timestamp, that's fine, and we can support
that, but we won't guarantee that that format won't change its
serialization in the future.

> I have seen devs have issues with stuff like this in the past.
> Unpacking an archive on one machine showing a different date than one
> another, or other weird artifacts. Mac used to use a different 0 epoch
> than windows and linux as I recall, etc etc.  I dont remember the gory
> details, but i have definitely seen people gnash their teeth over
> these kind of decisions before. Why not side-step that if you can and
> let people choose their own defaults?

The ustar format is defined by POSIX and uses the Unix epoch, just like
the zip format has its own epoch.  If you're processing a tar archive,
you need to use the Unix epoch.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--C8m3uuobZquCJB84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY/EGDAAKCRB8DEliiIei
gY4wAPwKOtnsYQlKruCYypd5iWcUgVNBRXXYlTAB8wjG4ptJxgEAxZCYQkFpxVYN
QfpGyn+jI3bxa8zTLAtRITUn/Pj/Mgc=
=6y59
-----END PGP SIGNATURE-----

--C8m3uuobZquCJB84--
