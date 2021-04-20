Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB436C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD6D613FA
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhDTXfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:35:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234427AbhDTXfX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Apr 2021 19:35:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0D3BE6044F;
        Tue, 20 Apr 2021 23:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618961691;
        bh=RrQaORRXRyVnaSvH4XbJVxGpm2xbV5D5wOeEH3l7z58=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oDnnWfe0yaACLn2jM4aDYN41Rs9A4za2UPYZhar48OT6C+pRSmBWkr+VLAbUaKgdE
         SYv17m01wCM6dxkAuCSGzKwUPbq/e0QK6HDtCfB1jLBbP8UVNQtrWn71+e7h6qUvh5
         84p651C7Rne2R5TTuKXNuTz5RONUg3fvb5LrE3nL0DFpeH4ZQ+z5HsIvltwdRTv6pu
         nM8G/NVzaVafwCUMw500r7FN0gheDObleW/E310UJEG18MYTgZ+K3+SgTmfM+C+uCb
         xGw95ucUjF0Hhsq0EWKAHa7obhzo6Bu33izN5rKAQGmw+UAl47EfLny3vmWL9ev03P
         4H6PFYYePVlYbTh2REtvHxWn1SQkJciGlh08AVw3DAzBVRxBmjKEnCSxnxCsVRjsNE
         Fv6QdguCoY+Uym2Z6jcrwk7AKAcnSFg/qXriF+kGZRZ4f/HVO/wifiZNUEiLiQFD5K
         n10hzEgG/g2YCEwZEEDb6fGco8w7XDbtys6bb8CcCrWrGYgW+7B
Date:   Tue, 20 Apr 2021 23:34:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Dennis Worthem <Dennis.Worthem@amtrustgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Problems with CRLF line endings
Message-ID: <YH9lFnJYpejqTOhk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Dennis Worthem <Dennis.Worthem@amtrustgroup.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <DM6PR17MB2106CEAA1CED29E738B81602F9489@DM6PR17MB2106.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CSvfnxaUZ93LzMVY"
Content-Disposition: inline
In-Reply-To: <DM6PR17MB2106CEAA1CED29E738B81602F9489@DM6PR17MB2106.namprd17.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CSvfnxaUZ93LzMVY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-20 at 16:33:40, Dennis Worthem wrote:
> We as a multi-developer team are using git version 2.31.0.windows.1 on th=
e developer side which we use through Git Bash on Windows 10. On the server=
 side we use Azure Dev Ops.
> Approximate 20 developers are working from one repository.  We want all f=
iles to use CRLF line endings with working with the files. All the develope=
rs have a .bashrc file with contents of "git config --global core.autocrlf =
true".
> Additionally, the repository with a .gitattributes file with contents:
> *.raml text eol=3Dcrlf
> *.json text eol=3Dcrlf
> *.vb text eol=3Dcrlf
> *.cs text eol=3Dcrlf
> *.vbproj text eol=3Dcrlf
> *.csproj text eol=3Dcrlf

text eol=3Dcrlf tells Git to store LF endings in the repository and use
CRLF endings in the working tree.  This is the recommended way to
configure things, since it means that operations like diffs don't show
trailing whitespace.

> The problem we are having is that when pulling branches from the reposito=
ry we still have recurring  files with phantom changes.
> We have told developer who experience this to either reset the indices ca=
che and do a hard reset or renormalize and check in and push as indicated i=
n a number of web sites. But it still seems to be happening.
> Our repository has a release branch and a develop branch and the problems=
 seems to be happening with mainly develop which has more developer traffic.
>=20
> It seems inconsistent on changes, The file will download with all CRLF en=
dings but the file is marked as modified and it is not clear what has chang=
ed.

This happens when the file that's checked into the repository hasn't
been properly checked in and either a filter (e.g., Git LFS), a line
ending change, or a working tree encoding causes the file as checked out
to differ when checked into the index.

For example, since you've told Git to store LF line endings in the
index, if the file is checked into the repository with CRLF endings but
then it gets updated, Git will re-read and convert the file into LF
endings in the index, and it will appear modified.  That can happen
because the timestamp changes or for other reasons that make Git think
it's dirty.

The proper solution to this is to do "git add --renormalize ." and then
commit.  You may want to also set up your CI such that CRLF line endings
in the repository cause a hard failure.  For example, you may wish to do
this:

----
#!/bin/sh

if git ls-files --eol | grep i/crlf
then
    echo "The above files have CRLF line endings in the index.  Aborting." =
>&2
    false
fi
----

It's unclear to me why this is happening if you have the above
configured, but it could be files which have not been updated and still
contain the old CRLF line endings in the repository, which the
renormalize should fix.  It's also possible someone is using a different
Git implementation, possibly one integrated in their editor, and it
doesn't honor the .gitattributes file.  Or someone could have a
=2Egit/info/attributes that's set to override the value.

By adding a hard fail on this in your CI system, you'll figure out where
the source of the problem is very quickly.  Most of the projects I'm on
have hard failures on trailing whitespace, and this is very effective in
stopping it from reappearing in the codebase.

> Does anyone have recommendations on how we can get this to work (always C=
RLF) without the phantom changes occurring in an apparently non-determinist=
ic manner? Have I configured this completely?

It's unclear to me why this happens inconsistently, but it seems to
mostly affect Windows users.  Users of other OSes don't seem to have
files in the working tree re-cleaned unexpectedly as often.  That's why
this appears to be nondeterministic; I'm not sure what it is about
Windows that seems to cause this problem to show up more often there.

> The problem may be that one or more developers have not updated their loc=
al indices. Also would it help to have everyone do a one-time reclone the r=
epository?
>=20
> One file marked as modified has
> $ git ls-files --eol | grep WCAPI.Core/WCAPI.Core.csproj
> i/crlf  w/crlf  attr/text eol=3Dcrlf      WCAPI.Core/WCAPI.Core.csproj

This says that the index has CRLF line endings.  That's not correct.

> and a similar one not marked as modified has
>=20
> $ git ls-files --eol | grep WCAPI/WCAPI.csproj
> i/lf    w/crlf  attr/text eol=3Dcrlf      WCAPI/WCAPI.csproj

This is correct.

> Why does the modified one have 'i/crlf' and the unmodified ones have 'i/l=
f'

Because it was originally checked in that way and hasn't been fixed.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--CSvfnxaUZ93LzMVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH9lFgAKCRB8DEliiIei
gYBGAP4pi1zuFNRkXZUS1zhfX/4ywIfmb0dy3fIWs1ZHDYF/DgD9HNeVeAQNuE53
f4tq884GB6z1e0D/c0TGEs1rXanPTgU=
=oPk/
-----END PGP SIGNATURE-----

--CSvfnxaUZ93LzMVY--
