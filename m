Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578A63B4
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX5TiTU5"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCEC2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 01:05:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc131e52f1so5188765ad.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698825926; x=1699430726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBN3aBMXDLKyKYKS4/I8gRl6/4IcmtQE6RPTNTgMSDQ=;
        b=KX5TiTU5+F3ZgRgGAf4eumw+4JuCy37M8g2mYhujXxiEirSXhjfFg5uCj3GN3hJpJY
         L3aq5jqYr4UaNbdjs2+v/Op7cbw/caaytWDjqi+pxikKuK0mXyeVVAZvscvmcmqszVWi
         4DwF0ugRbNR5SDdgfXiJ07kAY3kam+66or2Mae7bqZ15os1GtRVSGAIxg0SUy3Dx7XsP
         cgsCk3fggIgM3D2tDQW+nys9a7Mwk83r6QCXnVoRArEpcxWGBmXwJUedF4ePnAIjLF8J
         /78jTuPO7oCE2d8FGnakqfE4L8iqsCQt46QFrT76Qqy2ohnVyzGlcsDcRPzoSZcab5o/
         /h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698825926; x=1699430726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBN3aBMXDLKyKYKS4/I8gRl6/4IcmtQE6RPTNTgMSDQ=;
        b=ffT3rMZwy9cXt9LvN13Sq2IjTUYPuG8A1sQZQEGntcbWFDIXpM0HJ3mJ/fhfG6tX9Z
         nUDVQxlfbPaELXs/DaOYGkZjWpk7s8/A8l9geU9dw59/RJD75d0X6ouz46kgv5tq0UaA
         I5AViavw3AWVok6JOZcURleeECQ7mjaEXSqqLcH7hXPyPrnT+MIXSaNGhUey68eZ7IAN
         tagsxHXdnTGcEemsmWBPSJTmY0cmhBHhUGaKRpcjQR3XAh5DMzlxD75p7rH0De/o+ovw
         E2Y5x0c5Sled4JUoUFS1uIcMztFdeb2F177YOibyCmQsSdMsa9x3xsU818Z+VHno+x6/
         e3dA==
X-Gm-Message-State: AOJu0YyTF8hLavgk5d0p8Vy/EIHe85i2JicT//u0ixJoZxQnVm4MwfF8
	DvbFXQIFQivdg5CBfVFB4dn88beQWn0=
X-Google-Smtp-Source: AGHT+IEHFFsK+7WsuFcWCEcc4Uv6fwnJPgWVmIrzYsFk/Z3zDm457QUVJeaj63Fyx06Ib2ycUV3BAg==
X-Received: by 2002:a17:902:d487:b0:1cc:2be7:c0f2 with SMTP id c7-20020a170902d48700b001cc2be7c0f2mr2659622plg.13.1698825926180;
        Wed, 01 Nov 2023 01:05:26 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001c444106bcasm809256plh.46.2023.11.01.01.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 01:05:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 3214CB68D9E6; Wed,  1 Nov 2023 15:05:23 +0700 (WIB)
Date: Wed, 1 Nov 2023 15:05:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Injamul Hasan <injamulhasan2020@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: facing issue in git in a perticuler directory
Message-ID: <ZUIGwqQ95BOQqiGj@debian.me>
References: <CAG4aqRxyY+xeWVc+StqsE3AVp6O2ghFhtW9iHBUFfq+hCiTWEQ@mail.gmail.com>
 <ZUGDuyEao7wWCu0i@tapette.crustytoothpaste.net>
 <CAG4aqRyS2FxMwMgr6Vd_3vMEkFv+wCDq0h-QR4PHeN_2UeMtSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vx5+YqsM3iD6nk1i"
Content-Disposition: inline
In-Reply-To: <CAG4aqRyS2FxMwMgr6Vd_3vMEkFv+wCDq0h-QR4PHeN_2UeMtSg@mail.gmail.com>


--vx5+YqsM3iD6nk1i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 08:29:39AM +0600, Injamul Hasan wrote:
> so my E drive is my built in ssd drive which is my local drive and my
> storage type is NTFS.given in the ss below, there are only 2 folder nothi=
ng
> else and there is no cloud syncing service running yesterday this directo=
ry
> worked completely fine but  now this same directory is giving me this kind
> of error .please have a look of the screenshot below .
>=20

Please don't top-post; reply inline with appropriate context instead.

=46rom your screenshot, you have `Git-Practice` and `Python_Practice`
directories. Are these folders git repo? You can check that by
cd-ing into each dir and do `git status` there.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--vx5+YqsM3iD6nk1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZUIGuwAKCRB7tWyQc2rT
CHeyAP4jeIIgdTKm951k9cCQ7irnQpBSxDnZe7+NCuHtyq1E5QEAhhnD1BztSYc3
BtXDkJ/5TNE7cT6XQiu5cAmkSq9OWg8=
=apZP
-----END PGP SIGNATURE-----

--vx5+YqsM3iD6nk1i--
