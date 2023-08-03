Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D0C00528
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 21:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjHCVit (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHCVis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 17:38:48 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179630F6
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 14:38:47 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 41C835A2FC;
        Thu,  3 Aug 2023 21:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1691098726;
        bh=NSxpqz//qdl17xrl0jTiLd7NQicdQ7YK5d2nTmGmlwA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tx1JZXgbebD+2jefmK4A8y7EAPRMuVLSpwRec+dUOFvfhc3KGapEqHlSycC3mdSfg
         8X7nfw/ModP/l4QbpgKolmFZtq90wIigXtGRP2TuhyBtbGkJComoKX92Nwe+ZaRfnl
         zz5JqMSINQsZiV2ly5+jen1agjkXTjzvPljcGC3dn6Rhq/c07dyVsE5LgIAx40FkSg
         1IgBx3jUtG9Pt49Yr5WVbbc5FTas332n+siWJtrfUfbZhKvpBUeaOqiCo+GTzGo6Ow
         5bWeHOqkI8bKdWnAM3Q9A3ZZ3sG+SXIUeNTm7UwBaoU3lUtaMfVwFLJnYcABRf9cXp
         XW/hfaW2LaM2i5OT4vhoyIn3hH92q/SG+lnyNj5mG3BWzM2sVq9QaXkdtgKHUxH7Cl
         vk4cp5Eu2DNet3dNADvIh1xKkTxMrjWwTvL2mXCFSNSkGP0V3yvNyXJjLdNak2NZhc
         ckAwrPC2HjBoqaxrDYASSe6SzRp/HU8sjDuGTjRvUfH2r34QNkw
Date:   Thu, 3 Aug 2023 21:38:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
        Aleem Zaki <aleemzaki@gmail.com>
Subject: Re: .gitignore is not enough
Message-ID: <ZMweZHQZL7nnla+2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
        Aleem Zaki <aleemzaki@gmail.com>
References: <CA+sf2-+499Nfu00ciJeLwjRmBE7Bb-WZcZuCXY2-JXs88Pwz-w@mail.gmail.com>
 <CAE1pOi1Zt8i_rVi6dCGVsshhPxa_kV7qQ7SMu6R4nsSiadq7xw@mail.gmail.com>
 <c2fea20d-af37-8721-5bd8-14bbc3daf937@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+cKv7LIMznYS82ka"
Content-Disposition: inline
In-Reply-To: <c2fea20d-af37-8721-5bd8-14bbc3daf937@kdbg.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+cKv7LIMznYS82ka
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-03 at 17:17:15, Johannes Sixt wrote:
> Am 03.08.23 um 07:35 schrieb Hilco Wijbenga:
> > I think you might be looking for "git update-index --assume-unchanged
> > <file>"? See https://www.git-scm.com/docs/git-update-index for more
> > details.
>=20
> Sorry to tell you that this is a myth that lives on because it is
> repeated over and over again.

This is indeed false.

> > This allows you to tell Git to ignore the changes you made to that
> > (tracked) file.
>=20
> No. --assume-unchanged allows you to make the *promise* to Git that you
> will not change the file, and consequently Git does not have to check
> whether the file was changed. If you break the promise (because you
> change it), you will get what you deserve. For example, you may find
> that Git overwrites your changes, or commits them nevertheless.
>=20
> Perhaps a better choice is --skip-worktree, but recent answers on
> Stackoverflow point out that even that is not a suitable solution for
> "please, Git, ignore these changes".

Neither of these is an acceptable option.  Here's an entry from the FAQ,
which I have referred to several times (on StackOverflow and elsewhere):

How do I ignore changes to a tracked file?

  Git doesn't provide a way to do this.  The reason is that if Git needs
  to overwrite this file, such as during a checkout, it doesn't know
  whether the changes to the file are precious and should be kept, or
  whether they are irrelevant and can safely be destroyed.  Therefore,
  it has to take the safe route and always preserve them.

  It's tempting to try to use certain features of `git update-index`,
  namely the assume-unchanged and skip-worktree bits, but these don't
  work properly for this purpose and shouldn't be used this way.

  If your goal is to modify a configuration file, it can often be
  helpful to have a file checked into the repository which is a template
  or set of defaults which can then be copied alongside and modified as
  appropriate.  This second, modified file is usually ignored to prevent
  accidentally committing it.

There's no option to do this and you should adopt a different approach.
Probably 95% of the circumstances I see where people are trying to
ignore tracked files can be done by moving the original file to another
path and using a script to copy and modify the file to an ignored path.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--+cKv7LIMznYS82ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZMweZAAKCRB8DEliiIei
gdx6AP0ctjawXpSCoGXAqPzTu/luY4jM3rmaoxmeIINiob1CUgD9HOPHS7o/Xu4h
0qecf1nSvscw6WJ7+6x/irxf5KmbGgw=
=Gbz8
-----END PGP SIGNATURE-----

--+cKv7LIMznYS82ka--
