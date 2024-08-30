Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B891D1300
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047681; cv=none; b=B8i82YvOIB0E2lA68zUAoJs6LH+qYwfDB6+fpNs0uK3OYogZP8+4h5gdv0dkvT4LI21+0Ks+PooM+GrrseRoiu8UQ695uOYP6osA2iTDGmooCTA8KShsBQZqNEU/KwDG9NlbqvfrfXHnjgk13b/CAkglpLp9d4zoLmqF7PLrSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047681; c=relaxed/simple;
	bh=uc8IxsV5xS8LJQJWKLGtAYlEZQRiqvB3Q1Aj//yEQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeZ4Hu+uTu2ItdWs06nyfg+Ggp4fg62fY6jMJH16bbLFvBKnPoLvW2BmRYnN9frjvmg04JO89LO7qhq09PqOOk+i5k01jXvdptH7ohvFW8SZW/DHZJ0YsIKvVgUQrDn9mv0VzN22oYytwg6iiVGNmNIZKxuAd332ygvCTBdXIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rrHKh/zc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rrHKh/zc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725047677;
	bh=uc8IxsV5xS8LJQJWKLGtAYlEZQRiqvB3Q1Aj//yEQS0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rrHKh/zcqZxugzKZ1rxOtyOhCgX6luEBKb4X6CXeWbe2s8PEy6eT20bl+35e+jq8U
	 q6bDgDUBUamYM5HJzsyz4dv5aUcA0Lsea2Ht8RVJzGUjj3F8Xjmw3KexgCL15wvDvY
	 cuf1TUW4O3WGmfXz2sJBmYlrdpZn7aHh1xawLFsc6EUc++/n7h14zkZJ3as+rOEGOH
	 RdtglHQt1JYecxz+WJB79Wox8KuXuO8PgFQ65VMnvpIjGs0BAc+54/seEUQpyOZpms
	 ev0O6MEnRHF+sPATlyWwlqbA2461pHslFikNpQzf4ISsUxySTRKF/z0eWLvASFuADn
	 tTbT+qMMkc8R4RbXfoDXCr/D86z6SLNF1ic2OTdSx0noEXVKiArvuPSxuofzMzCro6
	 UwDqnvFTfdAg3B7mou49B1rgWTu1upvOpJr5Yo3Um4Adyy7XfgxPCg7TZ7hod73rlX
	 OzboKQXV3idwnHvd/lkVE//mDz0Yr/5iZOLDBHhO7BYdMvTCQYA
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B7F71260C9;
	Fri, 30 Aug 2024 19:54:37 +0000 (UTC)
Date: Fri, 30 Aug 2024 15:55:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Roman Sandu <r.sandu@gaijin.team>
Cc: git@vger.kernel.org
Subject: Re: Committing crimes with NTFS-3G
Message-ID: <ZtHrV5dOlTpCDV8z@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Roman Sandu <r.sandu@gaijin.team>, git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <ZtEWvQOwLPgjIFks@tapette.crustytoothpaste.net>
 <3eda2715-3b44-469e-85d5-f25504212928@gaijin.team>
 <ZtHe8Vi9aRmY-UMI@tapette.crustytoothpaste.net>
 <fe9d19fa-661d-4358-aa0a-ea419c419266@gaijin.team>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OG1+p4JS2Kvr27vp"
Content-Disposition: inline
In-Reply-To: <fe9d19fa-661d-4358-aa0a-ea419c419266@gaijin.team>
User-Agent: Mutt/2.2.13 (2024-03-09)


--OG1+p4JS2Kvr27vp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-30 at 19:25:56, Roman Sandu wrote:
> The stat output for a random file in the root of the repository is as
> follows:
> ```
>   File: <CENSORED>
>   Size: 91876     	Blocks: 184        IO Block: 4096   regular file
> Device: 259,2	Inode: 4630629     Links: 1
> Access: (0664/-rw-rw-r--)  Uid: ( 1000/romasandu)   Gid: ( 1000/romasandu)
> Access: 2024-08-29 17:41:04.855126300 +0300
> Modify: 2024-08-29 17:41:04.855609000 +0300
> Change: 2024-08-29 17:41:04.855609000 +0300
>  Birth: -
> ```
> Maybe lack of a birth stat is what drives git crazy?

That doesn't exist in POSIX, so it isn't used in Git.

I looked at the Ubuntu git package and it doesn't use `USE_NSEC`, so
your lack of nanosecond precision in timestamps probably isn't the
problem here.

You may want to try using a utility like
https://github.com/shogo82148/git-dump-index to dump the index and find
out what might have changed.  You can use `stat -c` to write the data
for the actual files in the same format, and then run `diff` on the two
to find out where they disagree.  Or, perhaps you can just eyeball it,
in case there's something obvious (like a `uid` difference).

Or, you could try instrumenting `match_stat_data` or
`stat_validity_check` in `statinfo.c` and printing the data that's
changed.

You might also try disabling untracked cache and see if that fixes the
problem.  It might be that there _is_ a bug in that the untracked cache
information isn't correctly refreshed when it was originally written on
a different platform.  It's known that Windows writes different
information into the index than Unix systems and perhaps that
information doesn't get refreshed properly.

One other thought: Windows stores symlinks with a different size than
most Unix systems.  Windows tends to give them a full block size,
whereas Unix gives them a size of their length in bytes.  That
definitely breaks using symlinks in a repository across Windows and WSL.
I don't know if that's what's going on here, but of course it could be
related.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--OG1+p4JS2Kvr27vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtHrVwAKCRB8DEliiIei
gciBAP4p8AKenPhw1ldYtTO6xbTlLB8ARSpTMW1xeJm2xEmwhAEAz3/H7bhD+wde
hRQ84zTEueEM9JP97zNDzwQWK1UJGAk=
=aaCp
-----END PGP SIGNATURE-----

--OG1+p4JS2Kvr27vp--
