Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A57C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF9361242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhIXUrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:47:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47364 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237268AbhIXUrN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 16:47:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C869F60426;
        Fri, 24 Sep 2021 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1632516339;
        bh=9kHZq8xUSAYw4UCb8vgSrWyAMIZkyWCmgpt3bvvr4Jg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y8WCwQiPhdNCohMS0CmQuGPa7YvcQSrkmg5yAdzPFqqSUIIUp/WEXsyQweCnILh81
         tTs5Hi9G5TAsS8SnH3zqvO/cXHwoA8UfTAxszt8iSqbsfxJmAqaalNxbGzgooCI94l
         t6rlYH5vBymnpt78KKMXm1X6Cym26WbM2pcbsWi8iwjbW+IU5f4PRQoA0Ysp1BHPaz
         npLiHs3gnHj1Joq4uXsFaDlz238bUKoCdc3jarPng/WEqUr5jQ8QbHnnmUZMKdV1uk
         D23euoCJhB2Al7+jMyuBpkFxAMN3DsjeASVNYJGx7p9wBbY/Hgtfic6PFOh4lpHDUG
         e+p+JITs9iknYxfg7IJk2LEq1gA5/duEb7kavfqctp47Hj/2dyxifbmWPA9eut3INS
         pZ5tylkCtuEy+SR8fZgiHp631jTPIxJTOJtcjYw0LPM8LxVgFOLtkorsLbtjTdO2R0
         H6qEN9l9uSrCTqSEJ88NBOGrrMIVVHpxKGRldd/BQnYLntX53is
Date:   Fri, 24 Sep 2021 20:45:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Emily Shaffer' <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: pull failed - why should I receive this message.
Message-ID: <YU4475ZbWfnvKomP@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Russell, Scott" <Scott.Russell2@ncr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Emily Shaffer' <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
 <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <000401d7b16e$17ea02d0$47be0870$@nexbridge.com>
 <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YU4vG0TI+BkK6xiW@camp.crustytoothpaste.net>
 <BN6PR15MB1426EBF10C9E8634EF317DDBCBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ynggBc4Rf9IJRqj"
Content-Disposition: inline
In-Reply-To: <BN6PR15MB1426EBF10C9E8634EF317DDBCBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3ynggBc4Rf9IJRqj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-09-24 at 20:13:15, Russell, Scott wrote:
> Brian,
>=20
> You are correct.  This is a build system.  And your responses are the mos=
t useful so far.
>=20
> "git fetch origin" - okay
>=20
> For this one, is there a way to specify just the head?   I just want the =
latest - and don't want to try to figure out what 'Revision' may be.
>=20
> "git checkout -f REVISION"

Pretend the branch you want to operate on is called "main".  Assuming
that your remote is origin, then you can write "git checkout -f
origin/main", or, if you want to be more precise, "git checkout -f
refs/remotes/origin/main".  That will check out whatever's at the tip of
main.

Note that doing that will result in a detached HEAD, which probably
doesn't matter for you.  In case it does, you can check out your local
branch to match it by doing "git checkout -f -B main refs/remotes/origin/ma=
in".
That will make sure you're on a branch called "main" and will reset it
to whatever was on the tip of main when you did your fetch.  If you
wanted your local branch to be called "dev" instead, you could do this:

  git checkout -f -B dev refs/remotes/origin/main
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--3ynggBc4Rf9IJRqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYU447wAKCRB8DEliiIei
gRYpAQCwT9uFujttRvbjzi25bYw4NjAGXr5Erwhbxcwjvf3Z2wEAznoyZEUbyWXj
YffLNxpiO5ufJgNQFHYlqlbucS1msws=
=pXue
-----END PGP SIGNATURE-----

--3ynggBc4Rf9IJRqj--
