Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8C28E8
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671004; cv=none; b=rmcH3kB5hIaCeUAi9h6+WtEGCMVAI7oQbiF9bQI2ntr93QG/LhJ8+XjLL0pi4i986CWE6v265sPJTZ94f2FZKaIXoY9q6i97Fnwwuc9GQuQWbN+0TqOujWcYmON7KD3ji3ZevHteiN9I+HLChLkExhUGtregT3JV3KT9fusnaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671004; c=relaxed/simple;
	bh=k0Zc7/EgmB3+JI/4nFlFj8kdbRzKWvQ4bGVL05Yz78w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtK6jJK1jBcea4DtmiwSAmf8yyVI622u9fALC7LqMkJOY0euZHLb5ZjhESe/YlSSF4NgCGlFOZEqXZSXBUwUagQ6dlmtgh68vhU4iI3zRmKQFi/dZHM3C7oGQi8Q3Tbx927X9U+U2uhWVvxjwaUOfim7/T4wwICFqaJ9eQhNrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T3pxkIb7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T3pxkIb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732670992;
	bh=k0Zc7/EgmB3+JI/4nFlFj8kdbRzKWvQ4bGVL05Yz78w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T3pxkIb7WINwPTXSKTHrbAXLdG4BWNN/i51FhGsCzpX5aJJ/ZCLQ636M66l4/q2KS
	 X5UOE8x1OCj+cQGTrLMCZrTd7CqQnUtHf8aITMtaWb7GU8VToSjLpyUjLYDrUnMTBb
	 TJXI0qTdpNUKA/FeM0nS1TW+fKJDiBeSBaJ9v7pKDkF1k5PsUMk4VyS96HnZ1r1T4u
	 yAm1JCzRhsh9Bti2EzrMcKWnVv4lz+X+OWwYLD5cbpvo9D/n1cBPmad7GCC3jmtm7l
	 l8n5dco5uMbXYvr+rJkT2L0m0mpLqOqqxHAF7e7uv5TjZDY/wwc1ly1QTXmK8O1pjH
	 8vX0LPNk6CMLW06VUvffGQM3AnRqMV89scU80SBSmw1urvsw3iRioPxHjF4YiLIl25
	 ixBEEegb9a/g+hlW69rXRNw4yOUMQhTCsbNDaVn4CjyfwZgrVSCHGlF7Zxqp1vnfsB
	 DBnUjcdP7a6be2Y0fCRldJH97Ui7g2sE+/u2f0/JLICq6coDyz5
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2600:1700:f991:38c0::39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5D22420994;
	Wed, 27 Nov 2024 01:29:52 +0000 (UTC)
Date: Wed, 27 Nov 2024 01:29:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Peter B." <pb@das-werkstatt.com>
Cc: git@vger.kernel.org
Subject: Re: git support for "xattrs" (extended filesystem attributes)?
Message-ID: <Z0Z2DVuR2PiN-oxy@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Peter B." <pb@das-werkstatt.com>, git@vger.kernel.org
References: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T5IGA+WLaSrdDGSm"
Content-Disposition: inline
In-Reply-To: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--T5IGA+WLaSrdDGSm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-26 at 19:40:32, Peter B. wrote:
> Hi everyone :)
>=20
> I'm evaluating and testing extended attributes (xattrs) for professional
> archival collection use.
> I couldn't find any proper documentation/information on how (well) git
> supports including xattrs in version control.
>=20
> I assume behavior may be similar to any other property-change of
> files/folders?
> Would it be possible to have bit-proof preservation of all xattrs? (even
> larger ones).

As others have mentioned, Git doesn't store this.  There are a couple
ways that one could store this information, depending on what you want
to store.

One way is to store the metadata in the `.gitattributes` file if you're
storing one or two well-known xattrs and the values are well stored as
text in the file.  You can then use `git ls-attr` and a `post-checkout`
hook[0] to set those attributes appropriately.

Another way is to store the data as part of an mtree(1) file in the
repository.  mtree is a file format that comes from the BSDs that can
contain a wide variety of data, including file type, uid and gid, text
user and group, permissions, size, mtime, cryptographic hashes, and a
wide variety of other data.  mtree utilities can usually generate a
manifest based on the state of the file system, validate that files
match a manifest, and usually update existing files such that they match
a manifest.  There's a Go-based version[1] which does support storing
xattrs.  Again, you can use a `post-checkout` hook here.

Since mtree is a key-value format, you can also extend the value with
other data.  I use a similar format in my dotfiles to specify install
location, for instance, so I recommend this as a good way to store this
data.

[0] Git LFS uses post-checkout hooks to adjust the read-only bit for
files which are lockable but not locked, so this is generally a robust
method.
[1] https://github.com/vbatts/go-mtree
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--T5IGA+WLaSrdDGSm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ0Z2DAAKCRB8DEliiIei
gZ1KAP9cJbQo/ep6W8GEkmtNLoHvucO3Uvk/AkX3HKHHqwyfHwEA7bCwiVrjBAdB
CjL4MwBwdHzqtxLCVR8QSenS94fUWAY=
=ZnUK
-----END PGP SIGNATURE-----

--T5IGA+WLaSrdDGSm--
