Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81234C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiKNWpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiKNWpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:45:50 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE646B01
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:45:49 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EBAD95A1AC;
        Mon, 14 Nov 2022 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1668465948;
        bh=EmaIimD7AiGChpCEeC9iLqAdR2y2OtkZ623UvM54UzY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JkdrSwVbNBvMB39iqqeUdRERxEePplLecyWYp2D5iwh3ArtWGSxtGmir9T6Zo0pW7
         KFwyjviXxvXUbiMkoqXDRUwka68J5JdC1RylojZIVK99qS9yp31XdbpcxinShZw5va
         Zoty2Et3b2NGM7Z7Xdz6ECURRyZP82y7wgqGkBcGF6CJRcDjIiX/qMEwbOHzNDlxpG
         cN7YO1W2iOtzAIgDC2o8WuC2OKUHRMFXVdcBPe1kt9MXRiF3KgmikxG2u8APPWp2NY
         1QA+E/EbO5DrKcnaSELk3kh6AknMBMoFPg8yLyzRermA5w1gJY3y7YGkVuW0MJj96+
         heoaVYZqSGXB1D0TEgcRf05s9Gczk/WjaOFqUMvIY8oP/k/oLVkW+Ik1jqSH6kbBnk
         jH5E3DeoZHT8+JDwZg95kHgCmVNjW03EdENWCEB55kZG5I/W8BxsfncyM6/+uF1eu9
         aysDKLGI/1kJOAqYY6Aaza4IeJyiB7RwoH+oeNcp5dXBjeuta/Y
Date:   Mon, 14 Nov 2022 22:45:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Moss, Adam David" <admoss1980@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Annotated Tag Hooks?
Message-ID: <Y3LFF9EFVlCn4Lt2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Moss, Adam David" <admoss1980@gmail.com>, git@vger.kernel.org
References: <CAMTDv-8kxu-vwtCgz-VGBhYEbUX8edXzyaQK4szg2bmMJLjF4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/BCsne2PDJMMq2KU"
Content-Disposition: inline
In-Reply-To: <CAMTDv-8kxu-vwtCgz-VGBhYEbUX8edXzyaQK4szg2bmMJLjF4g@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/BCsne2PDJMMq2KU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-12 at 11:10:38, Moss, Adam David wrote:
> Hello,
>=20
> Is there any way to use, or are there any plans to introduce, an
> equivalent of the `prepare-commit-msg`, `commit-msg`, and
> `post-commit` hooks but for `git tag` events?
>=20
> I would like to make use of `git interpet-trailers` to automate the
> inclusion of some additional information into the tag annotation in
> the same way we do with commit messages, but am struggling to come up
> with a nice solution at the moment.
>=20
> If there is a better approach I could use I'd welcome suggestions?
> Alternatively I'd be willing to help implement such a capability if
> anyone would be willing to mentor me through it?

Without speaking for anyone else, I think such a feature would be
beneficial and I'd be happy to see it come in.  I'm not personally able
to mentor you on this, because I have limited time to work on Git, but
perhaps someone else on the list would come along and be happy to walk
you through it.

I _would_ be fine with being put on a CC for the patches to provide a
review, however.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--/BCsne2PDJMMq2KU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY3LFFwAKCRB8DEliiIei
gVrPAP0ZxMuOjJpzJjjGqW9GIvwi+JqIb8Culw3Gm9NaJlqHWwD/eG2hnHxdDQK2
W1mDIRTpWwlbNHv5juICfSeshRjJMwI=
=LuSo
-----END PGP SIGNATURE-----

--/BCsne2PDJMMq2KU--
