Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203D360
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnMZjo4r"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255FEB3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:08:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc2575dfc7so24122985ad.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698710919; x=1699315719; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc+L6Nx1o5PaY3VLeixMG3v5gV3reIi39Z+LYTmaGeY=;
        b=HnMZjo4rQ5iJGrOGB1nVruy3JCRjIu2zHJquvOEw3QX1U4D3UuidtNinCnemLiWXS7
         H6KBWcjNgd3lTvrD2Z0d85T0bQGx6qvIFV+ROFiKPOFOjlMVQOfAuco56FmQRRsv3NSn
         7xllz4KPBLBnKJR89c4OQDU+qjsoz9f/lld1xYvhnoAxB4qwoGR2J5Yl5YTzfSuxBSkW
         hDmY35L27fCTb1k0vlXltzbKLlQatd5W3lxMDwX26msK4pqLuqZPqbsYh//Y3YHvd8ns
         CZrLLZM/Tnr70jC/VAh0BrjpbGHPTvcpcnAPJYOICySXExg/OKJgw+6QrgHozH14nyry
         SpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698710919; x=1699315719;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc+L6Nx1o5PaY3VLeixMG3v5gV3reIi39Z+LYTmaGeY=;
        b=qId2LLf6CEYpXqoH/amxwIWMuwtcSQbIXhlzipSWKGii6Yv6IPjxpjqxj291wwqRfJ
         fU/6IpxVNuZB6OiQ6qdKygMP9Uoh+RGmIlASDXQ2HbJZni3OzPo4gnxh19Ouhtng7Ukt
         jxI6nkG+N7jzPHElp1EWD+VTXNMIwiCk4LxGrcrSy8pshiLW6OdZunWPdHAzpYdx4KVg
         YRmoF2qyCjBuhWKyQMvVQSZ7R+Ax/1+vpRvoNyuoJfLGaHaTkYyFrxyzAPYPyPfHD5hl
         mjpamO+bJta/CsnzmHdZFY0FkboRBLqURCgg3VmLou8ZbYP/4L68mSh8PoDa9Rl7FxVz
         P+WA==
X-Gm-Message-State: AOJu0YxPO61V4wWCinh7nKlKfJAN2pD0MOVrn7cKC17b8bGeGA6ABEZR
	Gt5XVD5XbACEPFrLkVsE0B3UG1i2U8Cv2w==
X-Google-Smtp-Source: AGHT+IFfhBRFhZnoArWv8yvXwadDENmGVSIPc1nDmu1nkGDacZJrhb8RZ0qEkwtaXJF9RSBBHYt8PQ==
X-Received: by 2002:a17:90a:1c2:b0:280:52a3:711e with SMTP id 2-20020a17090a01c200b0028052a3711emr3505022pjd.47.1698710919358;
        Mon, 30 Oct 2023 17:08:39 -0700 (PDT)
Received: from smtpclient.apple ([2401:4900:4633:24f9:41f6:806e:b7d8:d879])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a4e4e00b0028089fdce19sm44501pjl.52.2023.10.30.17.08.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Oct 2023 17:08:38 -0700 (PDT)
From: Shashank Gupta <shxshankgupta@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: How to get started with contribution 
Message-Id: <FACCA976-EAAF-4B68-8748-D13A11EC6652@gmail.com>
Date: Tue, 31 Oct 2023 05:38:27 +0530
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Respected sir/madam,
I am Shashank Gupta, a IT undergrad from Manipal university Jaipur. I am =
currently in the 3rd sem of my Btech programme.
I am new to open source contributions but I have good knowledge of c, =
java and javascript. I would like to contribute to your organisation but =
could you please tell me how to get started?
Hoping to hear from you soon.
Regards=20
Shashank Gupta

