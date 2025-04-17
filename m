Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824D185935
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744862309; cv=none; b=fd+wGuBGQ/PQ2y0uGxfCuA4wX9kyQoY7QvsgAP3eDKs8UFWNw5hH879bxJArKKWf9NQELYi2X8TDFt9/HNG3hkK9SEInMsFIxucjUonS8WcwSPM/FfupvRRPVirEUJka41zr452vBOcqO5iKvdFPQimPmOKKwKqNDYiRkEpaklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744862309; c=relaxed/simple;
	bh=xlrF8VuSLuiblNKgl81Thduhx5+OPqteNGPNgHMyoNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byZIoSYDas/VMbZkyONb72YY0/t8lhu9I4Riq4raKJiObVr88brRXDY7asUjKcZBVh5oc4CEjusNm94fXWWeLGnjbNq2Y7G+RksCj1em4Bn/F7RjguTGEOzrmaAj2YFmtUmfZNjWxtZpEVMMZ3LFgelssKX0exxbBFVzNLrsZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 547F33430FF;
	Thu, 17 Apr 2025 03:58:26 +0000 (UTC)
Message-ID: <da10dd26-a7bb-474d-8c9a-cac32614d296@gentoo.org>
Date: Wed, 16 Apr 2025 23:58:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: install shell completion scripts
To: Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>
Cc: Akshay Hegde <lists+git@akshay.is>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
 <Z_RnJEyvtGh_0kFo@akshay.is> <Z_SJSKrUdiWzg4pw@teonanacatl.net>
 <xmqq4iyxs02r.fsf@gitster.g>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <xmqq4iyxs02r.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------W2RocyohfA5ExaiCpN4udxOU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------W2RocyohfA5ExaiCpN4udxOU
Content-Type: multipart/mixed; boundary="------------RglhwT3FEC54x5ksOLU0ln0t";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>
Cc: Akshay Hegde <lists+git@akshay.is>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
Message-ID: <da10dd26-a7bb-474d-8c9a-cac32614d296@gentoo.org>
Subject: Re: [PATCH] meson: install shell completion scripts
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
 <Z_RnJEyvtGh_0kFo@akshay.is> <Z_SJSKrUdiWzg4pw@teonanacatl.net>
 <xmqq4iyxs02r.fsf@gitster.g>
In-Reply-To: <xmqq4iyxs02r.fsf@gitster.g>

--------------RglhwT3FEC54x5ksOLU0ln0t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/9/25 1:42 PM, Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
>=20
>>> Most people won't run into this since if you have this installed in t=
he
>>> standard locations, it should just work, and the zsh script does have=

>>> logic to look for additional paths it may be under. I just wanted to
>>> mention it for info.
>>
>> I wonder whether it is proper to install the completion
>> scripts relative to git's $datadir by default.
>>
>> I think the default ought to use the pkg-config call to get
>> the completionsdir variable, as the zsh completion script
>> suggests.  I am presuming that's something meson can do
>> rather trivially, just as it would do to find the compile
>> options for git's various build dependencies?
>>
>> I don't know if that becomes too messy to be worthwhile when
>> determining whether git is being installed by a normal user
>> in $HOME or by a privileged user in a system-wide prefix
>> like /usr.
>=20
> Yes, exactly.  We left it out of what Makefile does for that exact
> reason.  Distros will do what is best for their environment, and I
> do not think, unlike pkg-config used to figure out distro specific
> locations when doing a system-wide install, there is a location that
> will make everybody happy in the context of per-user installation.
>=20
> If we were to install these completion script from make or meson, I
> suspect that we'd eventually need a separate make variable or meson
> configuration item (whose default value can come from $datadir
> unless there is a better setting that already exists in our system)
> that is only used to specify the location completion script.


bash-completion looks for scripts in a few different places, with a
common theme that there is a "datadir" followed by the literal path
bash-completion/completions -- some values for the datadir:

- $XDG_DATA_HOME defaulting to ~/.local/share
- entries in $PATH / the dirname for the absolute path to the completed
  program, if they match */bin/ or */sbin/ will calculate an additional
  datadir value of */share/
- $XDG_DATA_DIRS as a :-list defaulting to /usr/local/share:/usr/share


This is very difficult to get wrong, you are virtually guaranteed to get
essentially any conceivable layout handled. Entry #2 on my list is
pretty much the ultimate recourse, since as long as you leave meson
datadir and bindir alone you can install into absolutely any prefix, no
matter how weird, and successfully invoking `git` itself will as a side
effect add the correct bash completion file.

And that also means that distros automatically do the right thing --
just configure with prefix=3D/usr and we get
/usr/share/bash-completion/completions as expected

With zsh, things are a lot shakier. Canonically, there is a designated
loader list for all zsh functions, including completions, and that is
$fpath. It doesn't attempt to do anything fancy like indexing into $PATH.=


The default zsh ./configure settings will add these two directories, and
nothing else:

/usr/local/share/zsh/site-functions
/usr/share/zsh/site-functions


So, it works if and only if you build software using a prefix of /usr or
else /usr/local, and if you install software in $HOME then you are ummmm
encouraged to have your ~/.zshrc manually add some directory of your
arbitrary choosing.

Oh, and it also doesn't work on Debian, because of
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D934926

(I'm aware of this bug because when Joey Hess said "The simple fact is
that as an upstream author who used the debian locations because they
were the ones that worked on my system, I get bug reports from users of
other systems that it's not right for wider uses of zsh." -- I was the
user who caused him to file that bug in the first place.)

tl;dr on Debian, the directories which you are allowed to use are

/usr/local/share/zsh/site-functions
/usr/share/zsh/vendor-functions
/usr/share/zsh/vendor-completions


with the intention that you use the third one. They seem adamant that
"vendor-completions" is such a better name than "site-functions" that
they will require all debian packages to manually move their completions
from the latter to the former, probably after running "meson install"...



So, my personal feelings on this patch are that we can and should
unambiguously install the bash completion, but it would be reasonable to
defer handling zsh until someone figures out how to do it correctly,
which may be impossible.


--=20
Eli Schwartz

--------------RglhwT3FEC54x5ksOLU0ln0t--

--------------W2RocyohfA5ExaiCpN4udxOU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAB8XgUDAAAAAAAKCRCEp9ErcA0vVzKI
AQDCRyhEK3rxoel5rmXWqyour0gxZhVoeh3slrM5MDc+UAEAtMUVimrlIvtRPWFzz6UJOvfnDr/H
/oOep8Uqajs8qQI=
=Au8J
-----END PGP SIGNATURE-----

--------------W2RocyohfA5ExaiCpN4udxOU--
