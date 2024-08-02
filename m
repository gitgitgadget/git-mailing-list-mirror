Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD51ABEAB
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628857; cv=none; b=s0JHPRoOM+UUXC/lHInDVP9j3E+0jbuuF/a+lMx6wCOJRwSbDh/Ev8L4tNLE16n+7G3qPDDc7lQWXTTlYmWLdQtxwcVd8ZCzM7HEmQrSUUbFU7I+IyAEwMqyBDVzcNLmeipP7dAsFYxBCm0ByS0EVEf+ZHiWKU+eWLrsH3dqkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628857; c=relaxed/simple;
	bh=8jfSHZTETvZNOksGdxUL9PzePeGc46RIwQ0kdlAWadk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOyk17f3ItHPuSVnoGU7Cq42z68wbZVM4g6MFlJMaEsLbwUv7CfSpY1a1+FYWmofn2tuk+BFPQ1bqsuxYalp4QgKblEd14Wml9YEzF1DswyodiYVtHSVXvyP0x3qpHT8F2rFxudMcmtGrrycjPmDXPNAWhmUaeKMIdIiF98KThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qSGNdsD4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qSGNdsD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722628852;
	bh=8jfSHZTETvZNOksGdxUL9PzePeGc46RIwQ0kdlAWadk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qSGNdsD4cfkSGievRuNkrgAvlsaO9vUrhAhYzIlrCDglyht9UuqjdVtxcVG+qCzeJ
	 +ky+hr09JmblW/G1+0xn7WQC9X2GiVpSVUAeBsrqUCAYbeF9moa2N8MkH/+qsBFARp
	 RtIigTEKwS0z3PeefXARphuvBB5l6aP5eMXJ7wcoUUNKctoo6RAi50FAlRtV3pkP0D
	 0tJxIM+LAV6UUw+DG3u6vBFCfTzKLUJWyJ57VbvTjbFtCbgNNQ+laOoKhfdjipFtmf
	 6i7bLlOUuDg2sH0fLf9pQR1gQnEiZogGHSAz88KP6oRMel0vlvYBmU11GiGITpgZ1A
	 U3/8O/LKrJlGEi60klqI1VnhVacG9v2RABjoUZAPa80l4yCKF343LpiWRWx4GcsYXk
	 J7bEUB825J/9V48pL2a6WN+h0+RIZizZ6K7dsgGJ6D7YHyBQLh9inkm6WItYZuBMGA
	 Fg7i18RbU7NFiUiXT7NHXirqoPUpzum7JMrzFt/ipzlEn0E5Maz
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D5E5F209B9;
	Fri,  2 Aug 2024 20:00:52 +0000 (UTC)
Date: Fri, 2 Aug 2024 20:00:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Salman <mjsalman@pathcom.com>
Cc: git@vger.kernel.org
Subject: Re: Merging problem
Message-ID: <Zq0684YmxLqqsSRk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Salman <mjsalman@pathcom.com>, git@vger.kernel.org
References: <3db395fe-8d32-4a33-8f16-7df95f3ff194@pathcom.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EU5CWE/+zXkgfsJJ"
Content-Disposition: inline
In-Reply-To: <3db395fe-8d32-4a33-8f16-7df95f3ff194@pathcom.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--EU5CWE/+zXkgfsJJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-02 at 18:41:48, Michael Salman wrote:
> I am new to using git and I encountered the following problem
>=20
> 1) Created a repository using Notepad added a file (FileA.txt). Put one l=
ine
> of text in the file. Did a git commit -a. so far so good.
>=20
> 2) I created a branch (my-branch), did a git checkout my-branch
>=20
> 3) Using notepad loaded FileA and changed the first line of text to
> something else. Gave command git commit -a no problems
>=20
> 4) Git checkout master looked at FileA nothing changed
>=20
> 5) Did a git merge my-branch. No conflict reported
>=20
> 6) Loaded FileA in master the text of the first line had changed to what =
is
> in FileA from the branch
>=20
> Your help with this problem would be appreciated. I hope this is not due =
to
> my lack of understanding

Let me provide a small shell script that reproduces your report so we
can make sure we're on the same page.  Here it is:

----
#!/bin/sh -e

dir=3D"$(mktemp -d)"
trap 'rm -fr "$dir"' EXIT

cd "$dir"
git init -b master
echo "step 1" >FileA.txt
git add .
git commit -m 'step 1'
git checkout -b my-branch
echo "step 2" >FileA.txt
git add .
git commit -m 'step 2'
git checkout master
git merge my-branch
----

Now, let's look at what happens if we add `git log --graph --all
--decorate` to the end of the script:

----
* commit 4dd858b4e2b96ec24055d3a19d87e2080c4f1393 (HEAD -> master, my-branc=
h)
| Author: brian m. carlson <sandals@crustytoothpaste.net>
| Date:   Fri Aug 2 19:51:42 2024 +0000
|
|     step 2
|
* commit a1bf54082762cdcffec185d4cf6eef2c753af535
  Author: brian m. carlson <sandals@crustytoothpaste.net>
  Date:   Fri Aug 2 19:51:42 2024 +0000

      step 1
----

What's happened here is that the commits on `my-branch` are a strict
superset of the commits on `master`.  That is, `master` is an ancestor,
and there are only new commits in `my-branch`.  When that happens, Git
does what's called a fast-forward by default, and simply updates
`master` to `my-branch` without even invoking the merge algorithm.
That's why the contents of the branch are those of `my-branch`.

The reason that Git does that is that it's much more efficient and
produces the same results as actually doing a merge.  When Git does a
three-way merge (which is the default behaviour), it only really
considers three points in the merge: the two heads (in this case,
`master` and `my-branch`), and the _merge base_, which is usually the
most recent common ancestor.

When it does a merge, Git determines if there is a change in a
particular file between the merge base and each of the heads (not
considering intermediate commits).  If one side has a change and the
other does not, Git adopts that change, regardless of what happened in
in between.  For this reason, you can see that the merge base is the old
version of `master`, and that's also one of the heads, while the other
one is `my-branch`.  So one side never has any changes because its the
same commit, and the other side may have changes or not, so it's safe to
just update the branch pointer to the new commit.

Note that you can merge with `git merge --no-ff my-branch`, which will
do a merge, create a merge commit, and avoid the fast forward, but the
result is the same, as mentioned above.

So I think this is working as intended.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--EU5CWE/+zXkgfsJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZq068wAKCRB8DEliiIei
gXgNAPwMNCgRvXh95vl2hCCjN94UZvVlOknP/Epv9eju6zMirwD+OerjTgCsVwdD
OFN9K63PaAiP6Se+Gac4H2fJ7eR3agU=
=Nmmy
-----END PGP SIGNATURE-----

--EU5CWE/+zXkgfsJJ--
