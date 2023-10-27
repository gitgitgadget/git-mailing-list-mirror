Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3BA5B
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTXE79IG"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FCD1B6
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 18:08:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cac925732fso12823785ad.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698368901; x=1698973701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KF+fSXPvoJEsQZsmtSdzrKoaeViIcTLj5P7tu2KUZpw=;
        b=WTXE79IG85QUP1znX7o55iEPhsPVoHVwwfcctL/mao5kG8SThc/dhHJB+FeshrheVH
         8AYl0sZfsgYeHo+OMnHFK9X/tF6wBJZlBHSv9tZ+DJt9eEUAsaaZvuHWL8ySTX6F8NGN
         6dSvmI4ilNYyv7mvECpt3uMAkTvlOO1iLITAwGyKY+wDok6HzF8/ctXivcOWrwbYTWBb
         l2Ie1Q92fd2hprgTXSJxx/jGrfA5gJd3vHhGcyh5idbG7MaOaTSUSpf+fWOFhOhMNV7x
         7v2z/l8KD16fqXs/JhvtP0rbxxFElPEp1TAVjAIVv4xCPPzm0c9WZTsxMaFD5O1vG0fh
         eh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698368901; x=1698973701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF+fSXPvoJEsQZsmtSdzrKoaeViIcTLj5P7tu2KUZpw=;
        b=V7lga6G8cqxd7NrL/hEEmx8JI5bptz0sW5ORRrx1sUd/Ln5fjy34Q4m8dhgAmC6/+w
         8Rg60I74i3g2QPjt17aMJ9U7/DeyVt3lfR6IhhvLl3KqnmwsaoThU9Di/dd/HYHbm05s
         8hO6eFMTmoojOrBSpGbH5nZqC++/tjtVLuI9HxXYJDEiyYjx75fonX6D1ljl41IdwBnn
         AKtRA2poK0XInoWsXvtwq62NMEbFZ7RqUWMCpMp1cDQmjuOvUoEj6kE7z3uNfl3Bj2uI
         50Vffqte6tX//sjdJq7h0toCglyHvlXIrETKyh5CspHZHjq1hcdZ/J2EecIhTx7eab49
         W5fA==
X-Gm-Message-State: AOJu0YwDZIeQvy0Q3j9JbPStpSfKxNk1yZ6W2R9s/kQf4CtYbgZhBqMz
	+1O6eRAywfiDsXe38j78tIQ=
X-Google-Smtp-Source: AGHT+IECV4/54l6rX1UCImw3u+kdsubboru4oq+o5EMW0ODCtHgh4wj5w3l/Y+chvqU5zVTRe8igsg==
X-Received: by 2002:a17:902:c411:b0:1c5:bc83:557b with SMTP id k17-20020a170902c41100b001c5bc83557bmr1615328plk.51.1698368900610;
        Thu, 26 Oct 2023 18:08:20 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b001bc5dc0cd75sm310620plk.180.2023.10.26.18.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 18:08:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 3BA64819CFF3; Fri, 27 Oct 2023 08:08:14 +0700 (WIB)
Date: Fri, 27 Oct 2023 08:08:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Lior Zeltzer <liorz@marvell.com>,
	Git Mailing List <git@vger.kernel.org>
Cc: Andrzej Hunt <ajrhunt@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: ls-remote bug
Message-ID: <ZTsNfgJV1JN2y-Aw@debian.me>
References: <BL0PR18MB2130C672D503E49F955E04E8BADFA@BL0PR18MB2130.namprd18.prod.outlook.com>
 <BL0PR18MB2130A3CA5DEF0DD7199F2979BADFA@BL0PR18MB2130.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oKlGejh+/OWpFIn4"
Content-Disposition: inline
In-Reply-To: <BL0PR18MB2130A3CA5DEF0DD7199F2979BADFA@BL0PR18MB2130.namprd18.prod.outlook.com>


--oKlGejh+/OWpFIn4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:55:24AM +0000, Lior Zeltzer wrote:
>=20
> >uname -a
> Linux dc3lp-veld0045 3.10.0-1160.21.1.el7.x86_64 #1 SMP Tue Mar 16 18:28:=
22 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Gerrit version :
> 3.8.0
>=20
> Bug description :=20
> When running ls-remote : sometime data gets cut in the middle
>=20
> Reproducing :
> You need a few files with a few repo names (I used 4 files with 10 repos =
each)
> Call then l1..l4
> And the code below just cd into each of them does ls-remote twice and com=
pares the data
> Doing it in parallel on all lists.
> Data received in both ls-remotes should be the same , if not, it prints *=
**
> Repos should contain a lot of tags and refs

What repo did you find this regression? Did you mean linux.git (Linux kerne=
l)?

>=20
> Note :=20
> 1. =C2=A0without stderr redirection (2>&1) all works well
> 2. On local repos (not through gerrit) all works well
>=20
> I compared various git vers and found the bug to be between 2.31.8 and 2.=
32.0
> Comparing ls-remote.c file between those vers gave me :
>=20
> Lines :
> if (transport_disconnect(transport))
> 		return 1;
>=20
> moved to end of sub
>=20
> copying ls-remote.c from 2.31.8 to 2.32.0 - fixed the bug
>=20
>=20
>=20
> Code reproducing bug :
>=20
> #!/proj/mislcad/areas/DAtools/tools/perl/5.10.1/bin/perl -w
> use strict;
> use Cwd qw(cwd);
>=20
> my $count =3D 4;
> for my $f (1..$count) {
> =C2=A0 my $child =3D fork();
> =C2=A0 if (!$child) {
> =C2=A0=C2=A0=C2=A0 my $curr =3D cwd();
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0my @repos =3D `cat l$f`;
> =C2=A0=C2=A0=C2=A0 foreach my $repo (@repos) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chomp $repo;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print "$repo\n";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chdir($repo);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 my $remote_tags_str =3D `git ls-remote=C2=
=A0 2>&1`;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 my $remote_tags_str2 =3D `git ls-remote=C2=
=A0 2>&1 `;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chdir($curr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ( $remote_tags_str ne $remote_tags_str2=
) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print "***\n";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0exit(0);
> =C2=A0 }
> }
> while (wait !=3D -1) {}
> 1;
>=20

I tried reproducing this regression by:

```
$ cd /path/to/git.git
$ git ls-remote 2>&1 > /tmp/root.list
$ cd builtin/
$ git ls-remote 2>&1 > /tmp/builtin.list
$ cd ../
$ git diff --no-index /tmp/root.list /tmp/builtin.list
```

And indeed, the diff was empty (which meant that both listings are same).

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--oKlGejh+/OWpFIn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZTsNeAAKCRB7tWyQc2rT
CFP6AP9n+W5ZCGhyGk831dyWVnc9/DgjPou3+y+cfyjTDVK+FQD7BMescDsJlmXd
sFqIzjAKpA6VuyotrdqbCOmycqdMkg0=
=OrOh
-----END PGP SIGNATURE-----

--oKlGejh+/OWpFIn4--
