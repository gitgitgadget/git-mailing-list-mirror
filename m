Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127657F7C7
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338458; cv=none; b=cCnBl5ipCG0AavzHQsOEvCa0WCkOKnFG1zsLRNRA2HdRXKZ14FRHO2XySyQcpt+CtrIbDBJtPoecPyqjUhxfAACSIlp9bJAMjSlBIvF6ZW67xaetQOO6pykyiY1qKwhEoXFV3Vu/n+MMWwZR+lZEKGTRl087IxhR2lUGYDlFqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338458; c=relaxed/simple;
	bh=EFkmjT1Pgx0Spf3ddkA8U16eKe3TtaJyEc3M063Qx+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdxEh9HuDEdPyBfKAuJkHynbmEoFvEKUvxaBbIVAHPp8EDEkct231UFDiWg4YnRK1ZnqVwr3kShQ7dAmZbwyvh6oTxCWpncUsgHdbcoqrSLfS6PBkxHMklvE590k9v+uRhOBk72FFMBOD0duTPTZQa4ui0+1JOmODEfwvakiADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XaN3kgMa; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XaN3kgMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721338453;
	bh=EFkmjT1Pgx0Spf3ddkA8U16eKe3TtaJyEc3M063Qx+s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XaN3kgMaI8rQTdt9fwMc9kiRGxPYYsQerOrx16Vo5D2JcpHrS91fYnRRLtGZPIIkk
	 miTEUXkZn8mvTaRGDT15WB7SkvCZCr7TylWfJp1pIVYRmUFuQkqbYeA4uR09T2KYBU
	 j+6MRpweH5LiwQinQBWhX6BffT1/9E/Lr27XMismssqdP7iOaVwjuHBsLFf1A1dHIc
	 IVrzs1e1uaEZqgW16ymRKZJuKT/l3Oi6AWNidC6S7cbFDviAwdV2PeN1eJpp51lgkH
	 jJe4u1mbOW8sN3OPCKWaHCEkoEG478YtbradDoET2iBYkTQbMUiGaatYhCwSX7z50A
	 pVz/xRQe0QvS+sgMG3LVSNQvFR7YmU24QmvXRpr3kGHSw3UDU0+gX0LB6pkbrxL9EQ
	 ELe9Oi52RXN8HDfUp6vciNPiQancBymMvErBmRMcoJ2coTB85uHlMd4idHgEEMxdsG
	 EoCsDO3H/xk4cTXPigcQ4G9ZsgIzE4xVFhrB4tcVCik+LRKX+OD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A9895209B0;
	Thu, 18 Jul 2024 21:34:13 +0000 (UTC)
Date: Thu, 18 Jul 2024 21:34:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeffrey Barish <jeffbarish73@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug
Message-ID: <ZpmKU60benuHLXmA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeffrey Barish <jeffbarish73@gmail.com>, git@vger.kernel.org
References: <CAKjFfK_vcD-36LqYDMfEEjMARGQKFMQbKH7GqUPzrEjU-_HuQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FkCnAcmWKLyqPUqS"
Content-Disposition: inline
In-Reply-To: <CAKjFfK_vcD-36LqYDMfEEjMARGQKFMQbKH7GqUPzrEjU-_HuQw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--FkCnAcmWKLyqPUqS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-18 at 19:10:54, Jeffrey Barish wrote:
> --=20
> Jeffrey Barish

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> I did:
> <create a new repository>
> git init
> git add .
> git commit -m "Initial commit"
> git remote add origin https://github.com/jeffbarish/wax
> git push -u origin master
>=20
> What did you expect to happen? (Expected behavior)
>=20
> I expected my files to get pushed to my repository.
>=20
> What happened instead? (Actual behavior)
>=20
> I got a popup window demanding a password for a username that appears to =
be a random string of characters.
>=20
> What's different between what you expected and what actually happened?
>=20
> The files should be transferred, or, at worst, I should get a request for=
 a password for username jeffbarish
>=20
> Anything else you want to add:
>=20
> I am prepared to delete my account and start over, but I do not see a way=
 to do that. In any case, I wonder whether there is a better solution.

I'm not exactly sure what's happening, but I have some guesses.  I think
there's somewhere where you provided a personal access token as a
username.  While that works on GitHub, it's not the recommended
approach, because, as you've just seen, Git prints the personal access
token as plaintext since it thinks it's the username.  If the token
starts with `ghp_` (or `gh?_`, where `?` can be any character), then
this is probably the case.

To determine where that comes from, you can look at `git config -l
--show-origin` to see if you've set some sort of `insteadOf` setting
that rewrites the credential into the username.  If so, you probably
want to remove that, and instead store it in a credential helper, since
the configuration isn't a secure way to store secrets.

It could also be that the data is stored in your credential helper as
the username.  You can see what the credential protocol has to say about
this with the following command (I recommend piping it to `less` so as
not to leave the password in your terminal):

  printf 'capability[]=3Dauthtype\nurl=3Dhttps://github.com/jeffbarish/wax\=
n' | GIT_TERMINAL_PROMPT=3D0 git credential fill

If the string of characters is in the username and not in the password,
then that would explain why you're being prompted for that.  To fix
that, you can take the same output, change the username field to
"jeffbarish", change the password field to your token, and then pipe
that to "git credential approve".  That should set the right data in
your credential manager.

That might also bring up the prompt window you've seen before.  In that
case, you may change the right side of the pipe to this:

  env -u DISPLAY -u WAYLAND_DISPLAY GIT_TERMINAL_PROMPT=3D0 git credential =
fill

That will prevent any sort of UI command being run.

If you want to just erase credentials from your credential manager, then
you can do that with this:

  echo url=3Dhttps://github.com | git credential reject

Then, the next time you're prompted for credentials, enter your username
as "jeffbarish" and generate a personal access token from the GitHub
website (in Settings =E2=86=92 Developer Tools) and paste that in for the
password.  Don't use your actual GitHub password because GitHub doesn't
allow pushing with a username and password.  However, if you're using
Git Credential Manager Core as your credential helper, it _will_ ask you
for your password to do an OAuth request and issue a token automatically
that way, and then you do need your actual password and 2FA information.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--FkCnAcmWKLyqPUqS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZpmKUwAKCRB8DEliiIei
gbsOAQCWsrXRBE6xxqQVfSYh4thIgAvIA28wHdhp2NyfAg9ymgEAyBeE6XICbMqV
0UB/CRqIHhE6PaujeSiiZSYa++XhOQ4=
=Irga
-----END PGP SIGNATURE-----

--FkCnAcmWKLyqPUqS--
