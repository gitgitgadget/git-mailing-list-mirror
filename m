Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/XYg7nP"
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11871BD0
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 18:22:34 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6be0277c05bso2239498b3a.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 18:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700878954; x=1701483754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJNy7sGD7u1Vton5LINcP5gkYF/3SFwFDXGUQHIGGPs=;
        b=R/XYg7nP4GZwa7aaZIFXUpKsG6xE4bajl5ETCM/Hcp1A4Zz5y0nA9LRJBKWoQySOMh
         xfGWIqyA4DpCs+9hKLdPVJIgFmJS5bm7tke1CSc9d2niIOrdCwiF3Y+v3LH7ciDclMRR
         niX9C0A9XGygdiOA2BewqtQ/DSFXju2dvXtPvXcV+Iotc2QfROCYZj9ewaC/HLPmAD+0
         p/aIk7hBJmnU2+QXS/Dh0WzxgpD5hnRvFPZqSNrwxAix2af9nivKRn9AIdNFLAcT0jtQ
         tpzzyOvXOaZ0O01Xw3CcydySGbEok7uGpUXg2Uu5LtEPRMHiM0Pz02ojkCXYhzXgRhUr
         5F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700878954; x=1701483754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJNy7sGD7u1Vton5LINcP5gkYF/3SFwFDXGUQHIGGPs=;
        b=sdDzzXZAEKybn/2jCxjC7UBefleE4yciYO95QroINJiMM7lKkibbspiajRbCjbwJrn
         AstuAben6SSJkj0kcsE7p2fQyUy7AMH3aXVDOLTtJCEiCupSNEBNXrLK0KDKX4DERypf
         xC/4bvNkzurU9Mn/lMLlevKu57/PfVwb56ZkcJJiSlN2S3M/WTkai2u5wBnECRHkcc/O
         IvE/tKKaRH+fbFGkApC2HeVQNco3ne3V/GdckKf+ihtyVHv9wp4olt2mLDIBQOdpujMw
         sKsH8KBff65aIZzNHH0z/OZNG2nxggXgpcTSwHedcReIXSID/GZc0+xGC9jgmOd2OLo7
         mAtg==
X-Gm-Message-State: AOJu0YyJOXkPUWjUakbQHuY+ZcgjXzm0FIcZTphf5Ymnz5Gn1cqGevAP
	815p/6kZKg2kgnEc/ZiwqE8=
X-Google-Smtp-Source: AGHT+IFW1/g5fFqIJM0YQRiFfOubDSQj0k4GIT3X+Xlp7PfjUpF5z+yPenlJ6dvcfT99fkPG3gu76g==
X-Received: by 2002:a05:6a20:9145:b0:18b:5a8a:4333 with SMTP id x5-20020a056a20914500b0018b5a8a4333mr5700041pzc.19.1700878954180;
        Fri, 24 Nov 2023 18:22:34 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b001cfa718039bsm1718224plg.216.2023.11.24.18.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 18:22:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 80BFB104B6639; Sat, 25 Nov 2023 09:22:29 +0700 (WIB)
Date: Sat, 25 Nov 2023 09:22:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "H.Merijn Brand" <linux@tux.freedom.nl>,
	Git Mailing List <git@vger.kernel.org>
Cc: Todd Zullinger <tmz@pobox.com>,
	Michael Strawbridge <michael.strawbridge@amd.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-send-email.perl w.r.t. recent Getopt::Long update
Message-ID: <ZWFaZcgzwEP13geI@archie.me>
References: <20231124103932.31ca7688@pc09>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u6itdnZ/jKeaDf6z"
Content-Disposition: inline
In-Reply-To: <20231124103932.31ca7688@pc09>


--u6itdnZ/jKeaDf6z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 10:39:32AM +0100, H.Merijn Brand wrote:
> Patch attached

Do not send patches as attachments; send them inline instead. See
Documentation/SubmittingPatches for more info (hint: send patches
with git-send-email(1)).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--u6itdnZ/jKeaDf6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZWFaYAAKCRB7tWyQc2rT
CNjRAP4hiuqG5vmJVTbuhnm4Oi/2B7YQ7hLddSZ+kX0uZFojrwEAtTyDWZvZGiup
umA6t2viSsKh1L1blvzx0amN4sHHTgM=
=9iiH
-----END PGP SIGNATURE-----

--u6itdnZ/jKeaDf6z--
