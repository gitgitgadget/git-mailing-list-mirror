Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE9C33C9E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 01:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548532067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 01:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgAIBFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:05:51 -0500
Received: from smtp.bonedaddy.net ([45.33.94.42]:53944 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIBFv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 20:05:51 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 20:05:51 EST
Received: from chianamo (n175-38-4-223.per2.wa.optusnet.com.au [175.38.4.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id A71AA180045
        for <git@vger.kernel.org>; Wed,  8 Jan 2020 19:59:56 -0500 (EST)
Message-ID: <929fe6f7f41a2abca353df4fd7f602a3e22ceb5f.camel@bonedaddy.net>
Subject: interoperability between git and other VCS and data
 storage/transfer tools?
From:   Paul Wise <pabs3@bonedaddy.net>
To:     git@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-K6jlGKbK059SSsoXUydv"
Date:   Thu, 09 Jan 2020 08:59:51 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.34.1-2+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-K6jlGKbK059SSsoXUydv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

[Please CC me in reply, I am not subscribed]

I would like to be only using git on my local systems but there are
other folks out there who prefer to use different VCS systems.

In addition there are VCS-like data storage systems (such as Mediawiki)
and general data storage/transfer systems where one might want to track
changes using git (such as LDAP and rsync).

I still need mostly bi-directional interoperability between git and
CVS, Subversion, Mercurial, Breezy/Bazaar, Darcs, Mediawiki and rsync.
On the horizon are Fossil and Pijul but I probably won't need those any
time soon. Recently I had a situation where GNU Arch support would have
been helpful for viewing historical commit information but I assumed
that support for it didn't exist so I didn't bother.

Is there a location in the git documentation for pointers to software
(such as git-remote-* helpers) that can help with VCS interoperability?

Is there a place for people interested in VCS interoperability software
to collaboratively maintain them?

Should the VCS interop software in the git git repo move there?

I'm currently using the following tools:

CVS: https://github.com/osamuaoki/git-cvs (slightly better than git-cvsimpo=
rt)
Subversion: git-svn (not using a git-remote-* workflow)
Mercurial: git-remote-hg (there are lots of forks/implementations)
Breezy/Bazaar: git-remote-bzr (there are lots of forks)
Darcs: nothing as only fast-export/fast-import seems possible
Mediawiki: https://github.com/Git-Mediawiki/Git-Mediawiki
rsync: manually rsyncing and importing commits

What other tools are folks using?

Any other thoughts on this?

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-K6jlGKbK059SSsoXUydv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl4WewcACgkQMRa6Xp/6
aaN2eQ/9FstZVB+nt4iZgIqBIlqViymFPRJ1Xygy3Hr4n8xbpfeMYQ0tXvIyZYcH
/Dik6rFBbINfJWSkVUTBc3vVyurr0JwqFWqcs+bTYUAFiWplJqC4K+hhsp4BLVyq
OxWH4TrzDcCu39uyFK1rY5kN30JpgRnYK8qwdGdmVaf23LAF+2xuk1enLKrzCGFt
N/EgaTJf74dfOk4XinMUEvFLFefZN+zuUQIJo8d8aBGYaR1zdnW6C8Ok4d02UyHU
6fXPO5XIhrKjotRSptCcf41rrJ6cxNVqXkRwadPdPQDzI0z4HlonsdaMgsEK4BP0
rvstfA+Fj10UcyyyrkySB7wGFytK4kTAYJYeb8QqmG5MlxwX8nM46vCAKVFw7kAz
7NGuE63rF05QQxqWlFtwobzS6Zn1bzDXs9n5nrFSHyD7rQyX1n2IGlS7JEKIJVl+
5xtj7iRHkZ4dKyHstu4LCRJxAek80eN18rJSVOqPSJ+4DiG1hKUaD+kVkzLgLWMW
JoHFhPQTfL02Aqv3wL0vaADKvD5AMRS9jSnMQXZ+rDRiG7c65umo65fJMLaichIe
NwHSSvvnJoO+12EuI7QyeUTaqxXlxpUbuFpWtiQaJbE3e3iU9XrPAqubspXHxVW5
9SrXn+lnnE2kmbVccmbmRbagahR9Gfg/68vaiST2yrYpXaEhoGM=
=pUzn
-----END PGP SIGNATURE-----

--=-K6jlGKbK059SSsoXUydv--

