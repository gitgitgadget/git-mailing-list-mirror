Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A14C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 20:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiANUie (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 15:38:34 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:34412 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiANUid (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 15:38:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 805FD5B227;
        Fri, 14 Jan 2022 20:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642192712;
        bh=jGcgYYZY8/07gP3M+bS37IyJP7VXo8dKiEPPR/AZ+j4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mWS6QhcO+WoGAxMdRRE5FtsllWrOO+jc32ZEejnTxjtlabq3aWg5XJNKeaZDKsWfI
         qSL2Qhkhgoi3N4TVRWP/yj6caueLXLFXZznn/zgiJ2U8VKVZ94MMej2ZPt7MGaAT0e
         I5P6MbzCImxDbc5PKJ6iinYJQpo4WMxvtxxnUJvXSiUuggtSCZlJaRR/LAgAnreJPI
         WUW4KWCJRrK76UwBvM55a7Myy2Ewlj3+POplcIyAcMqTOJCJGLCx+8dZ28893mSzP8
         p4rzN5lP5THnz0bXOAJTwoA7JxfFbuA2H04ObfMrOO6AS2AU7yxITkL6/N0KMVtcXs
         NUBnfNP8zRwQEUo5Aws1BzEETqvvNS9wwvIP0/kyB7yxJ4Y4Jj9u/QaDHVod1f6x+0
         /TEcfAWhj7hizGXKrVvhwR8VHmkRj3WKCtAKH5tCsb6UI9cwpsiPj08rV403x62E1f
         23ADUyfP06sd4s12mVZZGwfgrEH9KvvMPjyJjJpmw4VPh/biSiA
Date:   Fri, 14 Jan 2022 20:38:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Glen Peterson <glen.k.peterson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: `git commit` with the `--author` option
Message-ID: <YeHfRguxRI6wNwvg@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Glen Peterson <glen.k.peterson@gmail.com>, git@vger.kernel.org
References: <CA+LnoU=MwKiyY6+MUWUj=SpgGrg2RVabNY_vtBbBicAsW2ZzjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IxWXo8A5i008TuFb"
Content-Disposition: inline
In-Reply-To: <CA+LnoU=MwKiyY6+MUWUj=SpgGrg2RVabNY_vtBbBicAsW2ZzjA@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IxWXo8A5i008TuFb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On 2022-01-14 at 20:24:58, Glen Peterson wrote:
> Thank you for git!  I use it hourly.  It is orders of magnitude better
> than vcs, cvs, subversion, clearquest, sourcesafe, and a number of
> others I have used, but can't remember right now.

I'm glad you're happy with it.  We always like to hear good news.

> I was excited to see the `--author` option on the `git commit`
> command, thinking that I could use it to set arbitrary authors for git
> commits.  Reading the docs, I expected to use it to, "Specify an
> explicit author using the standard A U Thor _author@example.com_
> format."
>=20
> It seems from stackoverflow and this list that git won't do that
> unless you have an author specified in your config somewhere (`git
> config user.email` and `git config user.name`)?  Links to sources
> available on request (your system rejected my first email).
>=20
> Does the email you set in the `--author` option have to match the one
> in your config, or can you set it to anything once you have a random
> user.email in your config?  Is this option just for choosing between
> pre-configured emails?

The --author option does set the author, and it should contain a
personal name and email in the typical format.  It can contain any entry
you want, whether or not it's set in the config, provided it meets the
syntax requirement.

> I think this option would be much more useful if it worked without
> also setting your git config.

Creating a commit also requires that you specify a committer.  Since
there's no option for that, you'll need to either have it come from the
config, or use the GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL
environment variables to specify the committer information.  There are
similar GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL, which are useful to set if
you're working in a script.

You can also use the -c option to specify that config, like so:

  git -c committer.name=3D"Pat Doe" -c committer.email=3D"doe@example.com" =
commit

There are even more ways you can get this information, and the
git-commit(1) manual page outlines them in detail.  If you think that
documentation is lacking, please let us know, and I'll try to get an
improvement in when I next get a chance.

I agree that a --committer option would also be a nice improvement here,
though, since this seems to be a thing people want, especially for
scripting.  If there are other use cases you're thinking of that aren't
scripting related or that we haven't considered, please share more, and
we'll see if we can accommodate them.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--IxWXo8A5i008TuFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYeHfRQAKCRB8DEliiIei
gWWpAP47lcOb031nKsxB+DkR+Sx63GJQK/CxDEOOekT/gqTaJgD+M8peZ7ROvJWS
sT2n5O1bw2mqglWiV+wM2O+s/7Domww=
=vbE3
-----END PGP SIGNATURE-----

--IxWXo8A5i008TuFb--
