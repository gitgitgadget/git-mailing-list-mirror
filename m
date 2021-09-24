Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD04C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738CB61107
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348315AbhIXUFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:05:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47346 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345661AbhIXUFs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 16:05:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 410566073C;
        Fri, 24 Sep 2021 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1632513824;
        bh=1xz1At3+xBjQU9bjC8+NvXg+//7Cu25zc4BzrL3bLwk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=axsPIZ3PPXEt33UJ5bTTj5vprSgNc8Bg7og5YBl/nyKMOPcYraAQ1gHi9DeeySxnP
         5JNU8O78hjr1+56L5D+GsZL4SfDmpYLmZntVIWVC8K41tqaJOt4jjpQ2dWq8+B+E6L
         t96awbowjCK5Ud5RsduhRCwAf3j0Ki5obY0XS1mTh4QbVUFjikUWN7UiGr1lQRAcYq
         axtBQQ0D5bi6ZcumkHlkvDxdSIMqnObQHX+SkC69tIVlwE+EnCiOjCfBIqm9GC2MDR
         vBcaS51cDDdE13Kh8i2gCjrHI9dP2/WmktGfPHk74Wi1nTulr/APWtNP0Kj94m5GX8
         wid2l+uvY/82QvhupAgeZCSk571PCib3GFhMEkpMpS1PaClUG3kUk5VDE0ylsJdoFT
         oMO9HsjYXTq1QHbZnOvSYIhmKQC83Hmq3b7LvJsyvqmIC+oiFr0ZFU8hSXeBOe7bSR
         w7jkueC1IIA0fFYmlTMfa+Jgg6k7XV3z6XUJbsMC8uoUMSOzjUB
Date:   Fri, 24 Sep 2021 20:03:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Emily Shaffer' <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: pull failed - why should I receive this message.
Message-ID: <YU4vG0TI+BkK6xiW@camp.crustytoothpaste.net>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0HfqGeON3c+l9/lK"
Content-Disposition: inline
In-Reply-To: <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0HfqGeON3c+l9/lK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-09-24 at 18:36:51, Russell, Scott wrote:
> Randall,
>=20
> Thanks for your answer.   However, this is a build system.
> Git clean -dxf would delete all untracked files - not just the conflicted=
 ones.
>=20
> We must keep all untracked files that would not be conflicted by the pull.
> Otherwise, the result would be our build would need to do a fresh build o=
f all objects and build targets - those are all untracked as well.
> Instead of the desired case of just building the changed files and their =
resultant targets.

Note that a "git clean -dxf" will clean even ignored files.  If you just
need to clean untracked files, you can do "git clean -df" (without the
-x) and then your ignored files will not be deleted.

> We just need the pull to overwrite any untracked files that may exist in =
conflict with newly tracked files.
>=20
> I see git is troublesome in this situation.   Every time a developer adds=
 an untracked file to the repo - regardless of type,
> It will result in failure of the pull.   And a failure of the build.

I do strongly agree with Emily that build artifacts should not be
tracked in the repository and that the best way to solve it is to
address that problem.

However, if your goal is to just update the working tree to a specific
revision, rather than to potentially merge that commit into the working
directory, you can use "git fetch origin" to fetch the remote, and then
use "git checkout -f REVISION" to check out the branch and destroy local
changes.  I suspect in your case, since this is a build server, that
checking out a specific revision is the intended behavior.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0HfqGeON3c+l9/lK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYU4vGwAKCRB8DEliiIei
gVuyAQD80swLb9Wq0gEqt1TfSKhUjP9aN4iYzRlXKsV/1YBP1gD+JoKS9Uuz2VJS
JHi97NqGPlTYKFr+EgUPlWrp4H0caAM=
=BCdL
-----END PGP SIGNATURE-----

--0HfqGeON3c+l9/lK--
