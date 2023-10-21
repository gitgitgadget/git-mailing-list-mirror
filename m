Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176A7EA
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu3yGM5t"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F8D67
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:22:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca74e77aecso19056775ad.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697851371; x=1698456171; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK1c2a/xvTIlWUURBNUSJ3AIvBwG6iT+9ion6VO2QdM=;
        b=Vu3yGM5tExSjLe++ybO9L8vFREspbnVuk2yB2/KaMZxJg588PaPke2Wg4gCg3y6e3d
         7k85abs8e0B0FbbFC1fD8CySQAwdtrfTsSfVv2XBEfWpcldczR+pOA5nartM8q8StDZ9
         thpb4HvTjsjkERhRspbh2pUPy16JMhr0r66XzAFdk0oMB6+QXdaZFWIm8CDFzz+2Ehvv
         sFhBuKN1dzU8BvBP+CeyAu3etRNFK/mMj/Vi2mVfkXc/K8jGYLk0rBzi6O4YFNWLaIgE
         aUvanZkgqlr7z9VjFjs4n1A5rJribAfoYA7QqoBGfI4SfCLAaynVqrbBtywwfjK/oNYj
         GVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697851371; x=1698456171;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK1c2a/xvTIlWUURBNUSJ3AIvBwG6iT+9ion6VO2QdM=;
        b=FUWa/a+dj4rqXUTg1PGmfcld9JFue9jyad/mc23HxiLyQkdXGOWRfol6dcu4taLXO8
         9Ft+mHKoBEQccvnzEjwdUGL/MiFb0xJguQxxWBkEBkcD2Dw9xplYNA0Nxc/4SzeYrRks
         SLFsGBb0TduqkzBe822xiaDKb9u93mCq5PQ3x32fEE4AiMfZj5MJqER8q6SXlUgqJoAk
         xbq2OdJiylQepd3Du4RhJM0OdSNNzQEAjRv4rMg39NwWo5fu9DXMAW2nAeHtcnLka7y4
         bLzRg6e6l0r5EOoSs0aNgVPlIqEJYqYQfjtCTYLLK4pFUEvug8g4Ry/rAi+p2MlBhmv8
         IMaQ==
X-Gm-Message-State: AOJu0YxdQtp9gABd+DVXAYonOI3/Mt4v40iLvR6VVUUSe2c6k/OkZwT0
	BKVm60YG8mUOgx7OYIWZh1QJ6IheRU/sbeD1
X-Google-Smtp-Source: AGHT+IELtvyIALrLv8NzZr5P/DEppQOgAlu5jQZQiCgzMz3pTK/HO3pBtiMc+TT/TCMi3CO8U5oIPg==
X-Received: by 2002:a17:903:41cc:b0:1c3:9928:7b28 with SMTP id u12-20020a17090341cc00b001c399287b28mr9456000ple.6.1697851371497;
        Fri, 20 Oct 2023 18:22:51 -0700 (PDT)
Received: from smtpclient.apple (220-136-130-168.dynamic-ip.hinet.net. [220.136.130.168])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001b8622c1ad2sm2110010plg.130.2023.10.20.18.22.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 18:22:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
From: =?utf-8?B?546L5bi45paw?= <wchangxin824@gmail.com>
In-Reply-To: <xmqqv8b1s0pf.fsf@gitster.g>
Date: Sat, 21 Oct 2023 09:22:36 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE904895-230C-436E-B7DE-499E6E503DB9@gmail.com>
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
 <xmqq5y32zgnk.fsf@gitster.g> <42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
 <xmqqv8b1s0pf.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> 2023=E5=B9=B410=E6=9C=8821=E6=97=A5 00:44=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =E7=8E=8B=E5=B8=B8=E6=96=B0 <wchangxin824@gmail.com> writes:
>=20
>> It is my official name. But the email address is not a valid one. =
Should I rewrite the commit message?
>=20
> We try to keep the name and address on Signed-off-by: the official
> one that we can give court if/when some copyright troll sues us (see
> Documentation/SubmittingPatches:sign-off), and one of them (if more
> than one developers signed off the patch) must match the primary
> author's name and address.
>=20
> Thanks.

Sorry about that, I am not quite familiar with the process. I mean I can =
receive emails at both @qq.com and @gmail.com, but <foril@foril.space> =
in the signed-off-by trailer in the commit message doesn=E2=80=99t =
actually exist.=20

Given this situation, I am unsure of the next steps to correct this =
issue. Would it be appropriate for me to use 'rebase -i' to amend the =
erroneous commit message, followed by a force push to update the PR on =
GitHub? After this, is the correct following step to add another comment =
with "/submit" to finalize the changes?

Sincerely apologize for any inconvenience my mistake may have caused and =
appreciate your guidance on resolving this matter. Your patience and =
support in this learning process mean a lot to me.

