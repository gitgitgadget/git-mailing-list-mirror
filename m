Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC73717C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549031; cv=none; b=pY4yXpt4HczbyMVE5ZY/0KEIFV7gRzRuhezYqRB0gdbP0lDnV7WVEZXiiEoPN/9KLKYbwqWXD0rI3cct/B60ipHMh+FCibg/GFlWJI6IusnRsMxsY/XpxaSwL484EmhTXavJESKg42ftsU0kqTZCBbviFKRqDdcxqWaeU7Gtnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549031; c=relaxed/simple;
	bh=nd9l6e1yUFh10aBrFlSJ15Km83co+kKmtJRKDuRzSWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6N9785za37lBT3h1K0oZh0E3CGjLM+hnwP+k1hQHHwR5niDwx55jCKTjeVQmK23K7hDRNPLWB5XfAj0O1OUZ59MpF4tTzoGDe6ktlHXyPiIKNquKGjdcdNhTH5gz73X5imIioqs3CDjhz/q2x2cRq5zOH8R/+XXTGsDJN0ZA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oYLt1x42; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oYLt1x42"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E9AB45B3C4;
	Mon,  4 Mar 2024 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1709548446;
	bh=nd9l6e1yUFh10aBrFlSJ15Km83co+kKmtJRKDuRzSWY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=oYLt1x42MduwJOV5ALdkYtA55I8ZCCVzoXoRgXm2VuOfxy25IIz7OX6tWXeICtrOs
	 284nAxPDFiXJnJ1F+Yfs0TD0sUO0cYI7AakVqnM7X4/JCVaTQ+ARnBnlF+yFAfTuGr
	 ecliFDYNRKhK2cgPYb4T0Uc17EesUA/g1TnOBXySQ2kL5k7b/UL9BRWnbaCKft3FSG
	 hYHp/lrCEuehTffJtcjIbSco4YtK7oscc+RlwD2hSJZqqpIbBEgvQahRDd0Lqq6RuC
	 ej0bdh+ScsH881B9iClcWTudfp8fYNK9HRFrW1KguMCkH9SHaE2bHliQhHPrYPJm0k
	 BZGZ0PmxnFtZ+5KMHG3wClhmrAg7nqgEAPQyTwFF5wTefN+P8ao5cWr2SvXvpWH/O1
	 q16fkyGbvJjojhIG9UVa8zgc+XAGo/WJ5aykOYZrN0sOeXcf+EpirAsRUyKub1H9e8
	 M3bqQpjnr80ldmI+6SPmxvak79AucTsMMgfF3SCpDCdAz50IRm4
Date: Mon, 4 Mar 2024 10:34:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Ayoub, Toufic" <toufic.ayoub@philips.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Support with finding git objects
Message-ID: <ZeWjnaZ64DvTRldM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Ayoub, Toufic" <toufic.ayoub@philips.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <AMXP122MB01810E9B1195953D9AD0C8C48E5E2@AMXP122MB0181.EURP122.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7JlxpN9oLLgTWkh"
Content-Disposition: inline
In-Reply-To: <AMXP122MB01810E9B1195953D9AD0C8C48E5E2@AMXP122MB0181.EURP122.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.12 (2023-09-09)


--x7JlxpN9oLLgTWkh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-01 at 19:06:29, Ayoub, Toufic wrote:
> Hello everyone,

Hey,

> Hope this message finds you. I need your support regarding an issue my te=
am is facing.
> We have a code in our SW which shall display the date of the git commit. =
There is a path in the code that if it is executed on a platform where git =
is not installed, that this commit date shall be found by looking at:
> 1.      Reading from HEAD file the commit hash
> 2.      Searching for this commit hash under .git/objects
> The problem we are facing is that sometimes, when the default master bran=
ch is updated with the newest commit, this commit will not be found locally=
, even after doing git pull and so on...
> The commit can be found with:
> 1.      git log
> 2.      git cat-file -t <commit hash> -> it returns "commit"
> 3.      git reflog
>=20
> but the strange thing is that we can neither find it under .git/objects/ =
nor under .git/objects/pack (although that is the newest commit and shall n=
ot be packed).

I think you're maybe making some assumptions about when loose objects
are and are not created that Git doesn't guarantee.  For example, if
you're doing a `git pull` or `git fetch`, it is entirely possible that
the objects downloaded remain in a pack.  In fact, by default, Git will
leave large fetches as packs to avoid an explosion of loose objects.

Note that the name of a pack is based on the hash of the entire pack
contents, not based on the items it contains (although obviously those
influence the pack contents).

> Can you please provide support by:
> 1.      telling me it that is an issue or is it expected?

I believe this is expected.

> 2.      If that is expected, where shall we find this commit object to re=
trieve the commit message and date from it (without running git commands)?

Sorry, but you're going to need to use Git commands to do this.  You
could also use libgit2, but that doesn't work with SHA-256 repositories
or certain other features.

> 3.      Or recommending me some other solution

I assume that you're building this software on a machine that _does_
have Git, so you could generate a file during the build process that
includes the commit date, commit hash, and any other information you
want.  This is easy to do for compiled languages, but it's also possible
to generate something like a version.rb file for Ruby or the like as
part of your build process.

In the interests of reproducible builds, you will of course want to use
the commit metadata and not the actual timestamp of building.

If that doesn't work for you, maybe you could tell us a little bit about
your goal with this process and what you're using it for, and we can
help you more then.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--x7JlxpN9oLLgTWkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZeWjnAAKCRB8DEliiIei
gcMUAP4m70U+iD01fkFr089K1AHy4hVpBxJV+qB+sFP3TRYxGQD/Z/VLXCLfaGuz
oEc4ey4kvXJSD/IMZDZfFNk/Ztk9sw4=
=2MMv
-----END PGP SIGNATURE-----

--x7JlxpN9oLLgTWkh--
