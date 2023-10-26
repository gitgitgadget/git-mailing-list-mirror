Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA6262A1
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpzXbhcW"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EE1B6
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:10:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b497c8575aso750876b3a.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698318617; x=1698923417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLDHaUP+PsHy019zQOgNHaOMYi+cXcPaba+A5X06V0U=;
        b=IpzXbhcWKG8rsfiFvEPArMBzqoB6SaGeBTsTeUcXf0tXlsZDu0wiLyPLDVUk4XCXLK
         ol41B2W2PbD39urzlaPMkZn+xd9lSr6RTJ9k6gkxnr/DmoACdFQ4nouqL33mul8sB6Vj
         5NWOHz64iokZ7M1NLQ6xuIDqMQPkbeUMva/Lcs708bJuD22qFTkr6ZnUnyatafzyTm65
         rms2D6i+D2Q3KL8y8ZZgnEPkE+OJmZW/v9pzjR8+HfFnKZ1QP61X9UtKbxoiKW4mVL0t
         AjO+p2gOP67mJt3nXOQdDzuiZC6gkwz3G9GhWG8xaR2urdA+np5TEEHJJi0thAZe5XQU
         jXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318617; x=1698923417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLDHaUP+PsHy019zQOgNHaOMYi+cXcPaba+A5X06V0U=;
        b=Ns0q52EtCf+GbJWp+S9yXzyHT757qyonlwSNcLEXPyp4ecOUg7CWoW9SXplKbCGE3o
         dO6xkjMoqgePl2mrPdPoxAw6+48nffK7rxm+FXj/L4XZ+wQDNIUDv/h25LAMceYP4rOl
         VE2gKsKTr/IY+BEXpAaUucBTUUBaldcWf/FNg8/WbiZodPUVrzuc56mBtAzZybnlTZZQ
         r8paanZ4agISzzMAe2jrfGIVxAAVuALTcAhHkyDHWjsmGdfUasm9Njno6DMPC/wrRjCA
         O/f6AU2owk3luOtOcslynfryh7OlFx5MUi2DbkpnndDQ7b+XrVYPgrOpZpJjSlJc6Fwb
         ITkA==
X-Gm-Message-State: AOJu0YzNS6xHgigXYLKFJlQChPGS3GCCL+Snm4gabK32Suu9/Ei5O4t5
	L3stTDdNqZMgF0bZ9rMl7QI=
X-Google-Smtp-Source: AGHT+IFB+F9yF15/OO1TtOzWTFOPO5XHtXZ/+6BvOM2inFZ03dYbWCL/adTFEAy+GQmz/xJ5272fZg==
X-Received: by 2002:a05:6a00:2d9d:b0:6be:319:446b with SMTP id fb29-20020a056a002d9d00b006be0319446bmr21502448pfb.21.1698318617221;
        Thu, 26 Oct 2023 04:10:17 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w187-20020a6262c4000000b0068feb378b89sm11853422pfb.171.2023.10.26.04.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 04:10:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id AF0A380DEE5E; Thu, 26 Oct 2023 18:10:13 +0700 (WIB)
Date: Thu, 26 Oct 2023 18:10:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sheik <sahibzone@gmail.com>, Git Mailing List <git@vger.kernel.org>
Cc: Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>,
	Victoria Dye <vdye@github.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: git diagnose with invalid CLI argument does not report error
Message-ID: <ZTpJFUdE2U6pbV--@debian.me>
References: <849b6ee2-99f3-4aaa-835f-44d3e13befc3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gw9GB+fd7BLyfwJ1"
Content-Disposition: inline
In-Reply-To: <849b6ee2-99f3-4aaa-835f-44d3e13befc3@gmail.com>


--gw9GB+fd7BLyfwJ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 07:49:58AM +1100, Sheik wrote:
> Hi Maintainers,
>=20
>=20
> Running git diagnose with an invalid CLI argument in a valid Git directory
> does not report error. Expected behaviour would be that it reports an err=
or.
>=20
> #Example shell commands which should have reported an error but continues=
 to
> succeed
>=20
> cd $ToAGitDirectory
>=20
> git diagnose mod
>=20
> git diagnose mode
>=20
> git diagnose mode=3Dall
>=20

I can reproduce this only when the invalid parameter is a normal word:

```
$ git diagnose huh
```

But the command errors out on invalid flag:

```
$ git diagnose -m
```

Cc:'ing people who recently worked on builtin/diagnose.c for help.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--gw9GB+fd7BLyfwJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZTpJDQAKCRB7tWyQc2rT
CHc+AQC0tV8nfb0kU6nWaZWDa9Z+HIOMVG7dggDjAe/hnOqZbwD+OBZrrYt6luWb
PMI+d4DseYhatINVJ1NTiULqTrQSyQg=
=ib00
-----END PGP SIGNATURE-----

--gw9GB+fd7BLyfwJ1--
