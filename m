Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D49CC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 23:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C3206FA
	for <git@archiver.kernel.org>; Tue,  5 May 2020 23:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Tdnjatg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgEEXRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 19:17:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37938 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728642AbgEEXRR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 19:17:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF9C36044D;
        Tue,  5 May 2020 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588720606;
        bh=APrB4PbPoqg4pFqS648KX6t1M6U19+BaqXDeXD5/ffs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Tdnjatg0JBaiX+BR7nMcMvP+dfBLQ2IMr/cPgDPv6QGdJjr9cZWZTDgkuSTzsPggq
         6OKt12oVN7zybyyzXNjN3FKyh4G9CxbtVJTakESlNYkXamIcQcE8/2mxylcAnE2nMJ
         eABSQZvXA7PHwEGMEzdvycrzIGSOajCDEVrJUcvU36rqgZyGeBb0/p5R+Zaa4DzdXl
         lY7CYJhzgu5HsyMeoqlRkwS5KEzLAYUhUEsiX9XQQt4qoLBn14ph0R9aFD5EQHIKXd
         nRKTSCUKyXjK0HodCdODl3P1E9yuepVVWsTUemQJR3xrCu6tb71hyLJqTFM/RmHo6J
         NbdInhE8/EB1VpcAZCPBb3N5Z4i2fXDo2vBy4TVtNlK5YEhx4+t9dIFoHaEBDqZJm2
         yKkDrCRp8LpL99MB5KXDHUzca9vGYxjThH1qN9q3sUU7RpWGbvloFVk6HBfrw6mIEb
         /lBs82qmodLIY6ZBNhhUWTYBMVWcudb/toFaUgAV7+byRPUWg3O
Date:   Tue, 5 May 2020 23:16:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Simon Pieters <simon@bocoup.com>
Cc:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200505231641.GH6530@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-trunk-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-04 at 17:20:33, Simon Pieters wrote:
> "master" is an offensive term, as it can be interpreted as being
> slavery-origin terminology. See
> https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_conce=
rns
>=20
> The Python programming language, and various other projects, have
> taken a stance and moved away from offensive terminology including
> "master". See https://bugs.python.org/issue34605
>=20
> When different projects using git decide to move away from "master" as
> the name of their main branch, inconsistency ensues between projects.
> See https://github.com/desktop/desktop/issues/6478 (and "Related
> Issues and Projects").
>=20
> To avoid offensive terminology and to avoid further inconsistency, I
> think git should use a different branch name than "master" when
> initiating a repo. I don't have a strong opinion, but I like "main"
> since it shares the first two characters and it's shorter.

I've been busy and haven't had much time to respond to this, but I've
gotten some feedback from other people on this issue and so I'll share a
few thoughts.

Others have pointed out that "master" meaning a canonical source may not
share the problematic origins mentioned above.  From feedback I've
received, I get the impression that "master", even though from a
different origin, brings the idea of human bondage and suffering to mind
for a non-trivial number of people, which of course was not the
intention and is undesirable.  I suspect if we were making the decision
today, we'd pick another name, since that's not what we want people to
think of when they use Git.

Clearly we have compatibility concerns to consider though, so if we
decided to make a change, we'd probably want to make it in a 3.0, which
as far as I'm aware hasn't been discussed yet.  I also wondered what
such a change would involve, so I did some research.

It appears that if we made the obvious one-line change to
builtin/init-db.c, we'd have 304 tests that fail, which is about a third
of our test suite.  I haven't examined any of these tests, so I don't
know what would be involved in changing them.  I imagine a project to do
so would involve setting an environment variable in the test setup code
(e.g., MAIN_BRANCH) and replacing instances of "master" with that until
everything works with an alternate value of that variable.  Picking the
new name itself could be deferred until later, and we could choose from
some popular alternatives.

There's also the documentation, which at first glance seems mostly to be
examples, many of which could be changed to any suitable branch name.
There are a large number of those cases and someone would have to audit
them all.

So it looks like this would be a reasonable amount of work for someone
if they decided to pick it up as a project.  Since I have limited free
time and am working on the SHA-256 transition, I won't be doing this,
but if someone did pick it up, I would be happy to do some reviews,
provide feedback, and include a few patches while doing other work in
the area.

I realize there isn't agreement on a direction forward or whether this
is worth doing at all, but since Git usually operates by providing
feedback on an initial set of patches, I thought I'd sketch out what
that might look like for folks who were interested.

I should point out that it's also possible for users who dislike the
current name to use a template to change the default branch name like
so (using the proposed "main"):

  mkdir -p ~/Templates/git
  cp -a /usr/share/git-core/templates/* ~/Templates/git
  echo 'ref: refs/heads/main' > ~/Templates/git/HEAD
  git config --global init.templateDir ~/Templates/git

Then "git init" will set your default branch to "main" instead of
"master".  This does have the weirdness that it claims it's
reinitializing your repository, but otherwise appears to work.  That is
of course orthogonal to changing Git itself, but is an option for folks
who'd like to make a change now.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHQEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrHz2QAKCRB8DEliiIei
gTveAPdZKP2kteajePBP3bc+xlnNKsoNt028parRTTtawrDrAP9lJJYeUUcRGUgb
9KNWNqg6O+utWcDSHXT5+BmWva50DA==
=xgtj
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
