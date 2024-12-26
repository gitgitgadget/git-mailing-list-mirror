Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325435280
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735232789; cv=none; b=TfZOEjPskUFTWxzPAfPiwgaJau0Y2Co8jDKjPsKKSIojUEHZzx7aH+4qtTvE+AqidVnx00oZ6YHnzQVy/j3+TyEfcS95sxjOSr7qHd3aA0yWsDN9eQ18a8132lncP4S7ExFym18cD9l1avRx6H9SYBtkWz9Gpwz+pCwVdb8HUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735232789; c=relaxed/simple;
	bh=CckasuQ2QW172ztL/V/S512YrNZU47Ql0mYmxLDVGJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlKQqIm5bD2XoYgE5lt04hTLvdHDGS+Rexk0I0Uf8teUtFp8DyWTDl+VZh5/YDlpqyg2n2auJWUoh4NVK75SISiSlttbTOgSZG8O1O0lcWPWCQOx3zUWfKdyHXVL/hbqP+TON1fCdNWGrtOaq7s4eXTQe9UcdUuK3xhMz5czOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2OYj8fw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2OYj8fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A11C4CED1;
	Thu, 26 Dec 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735232788;
	bh=CckasuQ2QW172ztL/V/S512YrNZU47Ql0mYmxLDVGJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2OYj8fwOz0/4lDWDtEnSLnY2rg72evBK+7cm/IxSiiYz7pADbgiHyCAr8FfbvUpL
	 gnLr7pm4LxFO+lIH/cq+Q7sfESHGD42pS7rBu3PlHRH6As3JCsF0CtI11kv7uN8yS2
	 8qqb6uhmDbgGTDKRMEtXpKYyFzBnNbLiTCikXpxS5GOKZvOHtc9RuY3BICkkk2nrYt
	 uTc38CPwMLmb95mfiXtuGFPo2QfR+14HgUSAodhaPv7324g4YY/5fD9SJHX8k9x0/y
	 TJqBwMiyELGF2WANu3Whn/KrnONrtJYXi5/suRndfhuwGDwNZMf9ayBLg11AhfE3U0
	 ZRKcfvUxPKaLA==
Date: Thu, 26 Dec 2024 18:06:25 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
Message-ID: <jwatyfdnn65ot2s3i4uhrseh5kbkudsqv2a6bzmz2xncdzly6v@7gi4gmajls3g>
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
 <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
 <5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
 <8734ieyumd.fsf@igel.home>
 <elrdfos3fkzjdmhvyxbshsbt6nw723mr3m7blw7ghghnresxi6@vvj7u6jwlgur>
 <xmqq4j2qzb6d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2aufxthb42abfzcs"
Content-Disposition: inline
In-Reply-To: <xmqq4j2qzb6d.fsf@gitster.g>


--2aufxthb42abfzcs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
 <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
 <5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
 <8734ieyumd.fsf@igel.home>
 <elrdfos3fkzjdmhvyxbshsbt6nw723mr3m7blw7ghghnresxi6@vvj7u6jwlgur>
 <xmqq4j2qzb6d.fsf@gitster.g>
MIME-Version: 1.0
In-Reply-To: <xmqq4j2qzb6d.fsf@gitster.g>

Hi Junio,

On Thu, Dec 26, 2024 at 08:00:42AM -0800, Junio C Hamano wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > Hi Andreas,
> >
> > On Mon, Dec 23, 2024 at 10:09:14PM GMT, Andreas Schwab wrote:
> >> On Dez 23 2024, Alejandro Colomar wrote:
> >>=20
> >> > Anyway, it feels awkward that git-log(1) skips the last newline whith
> >> > --format=3Dformat.  Should that be fixed?
> >>=20
> >> If you want terminator semantics, use tformat: instead of format:.
>=20
> Or, "--format=3D%H" should do the right thing, as that is a mere
> short-hand for "--pretty=3Dtformat:%H".

Hmmm.  So many times having read that part of the manual, and I had
never noticed that.  I had never seen that tformat existed, and even
less that the default was it (when there's %placeholder string).  I had
always read 'format' instead of 'tformat'.  :)

Thanks!

--=20
<https://www.alejandro-colomar.es/>

--2aufxthb42abfzcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdtjQkACgkQnowa+77/
2zLaJg/8CTMKziWTfWcDGaAgHT+mLNR/+cvf2TApQAIfhmlUsSIUQ+bldRExHJ7O
DjUOarQKvtNiIlyk+SBcih6G5pbyQfGCS3+RL3icLePj5ncUKTWnAhV14o+42RaY
2/anVCQo3Reg/H28PABoQ3AFZVaaeGeKq6MmZuW412KDpPrEchyGMIdpUdi+KaIy
vCxNvvH20F0NUh8EhJXv/DC5cGNdSJ2jWNOAlyeOUYtI2yd0VcLiB6SVmEdGWFoP
YXkt3f+G7OtGby9cKqKAAHCF5lxvdOrfDF7kMg/UXQQYx2ZRMumroykNvmNgOeVD
zWJbW4DyAneHoRBG67quYoufsEaxZM/P7JS/QxwZH98KIy64gbZRSiBmDUxnIogy
3L2mSE5wlhQntPoWy/GkPKKCUCYBxzwMDRmxc39jaqtPsPzz5VasOsDwT8iyXFGO
cDQUNZzzJRBbAuhm6nFjPi7BVEpcfyW3aIDf8U1kdW04baBvisNYW0cvjuY3RqpC
IzCGeFyeLzkS62KbiM3QObBYAY0b3zr1sToPqyDB3ottcAKbMp0mTHy/cMaDOlrQ
xOzhkdbzt5aRWp5qvpPIoQ/MhXT56ADhaS3QXhg1BTGUaR//EfTpWwpC8MhotiUo
SpuVdhJnoJakuIjCuXTx2Bvauoz72qvAUZzQ5HD8k98vuKq8TBM=
=J1GU
-----END PGP SIGNATURE-----

--2aufxthb42abfzcs--
