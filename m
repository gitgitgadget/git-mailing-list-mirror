Received: from 18.mo581.mail-out.ovh.net (18.mo581.mail-out.ovh.net [188.165.56.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E570D30B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.56.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514353; cv=none; b=j2lPi29dqAzo4fmfyNzXjfywu9O1RJqcTG+QkeNVlSXzkuv9lDbE3Pl6E+CT7UeceNly2GDrs8TK9Y0CZCpSBYzUte0flqhMC+Htd3XLyz9eBsHaWRCUafh7ifLdv0XPVG0FaM5vXr+UgL7OqjevFRXBwR8x+GNc8zaSfnHFqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514353; c=relaxed/simple;
	bh=odYbnuWfLfUaUo3zlOoviKmPMEC7eU+74XhAfl7bx3w=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=oNcDtHZtRfLIMzQHDopW1FJddiUOYYdllCtR1CriEUAYwlXTmoizo0kKztYkCmt4VUr8cnGMhWbQrJlK4ARi4mKw6CZ1o41vIwYqgkiF04FLgW6BijMRRfgVw4KdKImTDg+nXVeiEKhkypieXXZwyEid73WlfmZ9Mu/+jlhrHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strongly-typed-thoughts.net; spf=pass smtp.mailfrom=strongly-typed-thoughts.net; arc=none smtp.client-ip=188.165.56.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strongly-typed-thoughts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongly-typed-thoughts.net
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.139.129])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4Vtr6z2KtDz1HvR
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:50:51 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dr7gb (unknown [10.110.113.85])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D758C1FEFF;
	Tue,  4 Jun 2024 12:50:50 +0000 (UTC)
Received: from strongly-typed-thoughts.net ([37.59.142.102])
	by ghost-submission-6684bf9d7b-dr7gb with ESMTPSA
	id OT9qMKoNX2YzewIA1MJKig
	(envelope-from <hadronized@strongly-typed-thoughts.net>); Tue, 04 Jun 2024 12:50:50 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R00406a9a48f-05b1-481a-9bfa-fa8cca74a257,
                    464C519FAA125C894A134A5B19D6FF63C387AE44) smtp.auth=hadronized@strongly-typed-thoughts.net
X-OVh-ClientIp:193.250.76.216
Content-Type: multipart/signed;
 boundary=2c63e5c06bae13018d25bbff99557271806d5d775c92e3c052482e446af3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 14:50:49 +0200
Message-Id: <D1R8VB91BRR6.3M3651RXOQM5Q@strongly-typed-thoughts.net>
Subject: Re: Author signature
From: "Dimitri Sabadie" <hadronized@strongly-typed-thoughts.net>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, "brian m.
 carlson" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <D19KZ1CBA7JF.27PYPL5X68543@strongly-typed-thoughts.net>
 <ZkPA2Pmz2EB6SOzL@tapette.crustytoothpaste.net>
 <20240514-lively-potoo-of-sorcery-0028de@lemur>
 <20240514-demonic-quartz-hog-be2bd2@lemur>
In-Reply-To: <20240514-demonic-quartz-hog-be2bd2@lemur>
X-Ovh-Tracer-Id: 984880947041218555
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgggfffkuffhvffofhgjsehgtderreertdejnecuhfhrohhmpedfffhimhhithhrihcuufgrsggrughivgdfuceohhgrughrohhnihiivggusehsthhrohhnghhlhidqthihphgvugdqthhhohhughhhthhsrdhnvghtqeenucggtffrrghtthgvrhhnpedvffekjefhfefgudfftdellefhveeuvdfhkeeugedtgfeugffgieeiffdvfefhleenucfkphepuddvjedrtddrtddruddpudelfedrvdehtddrjeeirddvudeipdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehhrggurhhonhhiiigvugesshhtrhhonhhglhihqdhthihpvgguqdhthhhouhhghhhtshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedupdhmohguvgepshhmthhpohhuth

--2c63e5c06bae13018d25bbff99557271806d5d775c92e3c052482e446af3
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On the other side, I just had another idea. What would be best to me
is to actually provide a _proof_ that at least the author acknowledges
the patch =E2=80=94 whether he wrote it or not is another story and I don=
=E2=80=99t
think we can enforce that completely. The goal I want to achieve is that
if I send a patch via email, if the patch ends up committed by someone
else, I still want to be able to have a proof that =E2=80=9CI wrote the pat=
ch.=E2=80=9D

So assuming the committer is not of bad faith and doesn=E2=80=99t truncate =
my
git commit message=E2=80=A6 why not simply adding a =E2=80=9Csign-off=E2=80=
=9D like line at the
end of the commit, but instead of just putting a clear text that anyone
could tamper with, we would sign the date at which the commit was made?

For instance, I could have a git message like:

    Fix typo.=20

  	-----BEGIN PGP SIGNED MESSAGE-----
    Hash: SHA512

    Tue Jun  4 02:49:26 PM CEST 2024
    -----BEGIN PGP SIGNATURE-----

    iHUEARYKAB0WIQRsmRqgbXp8KFc3mc6pQ4aopiUuywUCZl8NVgAKCRCpQ4aopiUu
    yyhWAQCScfP28Py0QbHuqzzOFyjAMwdK0LfwiGfYrfzfv0evlAD9Hd+x8NgvPq2p
    nnnG5tQaHeIS/v8PMP0suy3QiWV8WQc=3D
    =3DRu+m
    -----END PGP SIGNATURE-----

If a create another commit later with "Fix typo." as content, then the
date will be different and the signature won=E2=80=99t be the same.

What do you think?

Dimitri

--2c63e5c06bae13018d25bbff99557271806d5d775c92e3c052482e446af3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRsmRqgbXp8KFc3mc6pQ4aopiUuywUCZl8NqQAKCRCpQ4aopiUu
y4nfAQC5gCwafna0VCv5mA/VnnS5vWCo6OZNFQfce5gHVeOR0AD/cQnKUlBvUPR+
tcMXTVuRCHvZ7Bsgs0LBDk0lUJdE0g0=
=jfph
-----END PGP SIGNATURE-----

--2c63e5c06bae13018d25bbff99557271806d5d775c92e3c052482e446af3--
