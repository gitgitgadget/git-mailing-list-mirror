Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486F6FA3
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da3Jtdf9"
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41CDFB
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:53:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28014fed9efso722145a91.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698915227; x=1699520027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6b0vKFdrU+T/hgWwLAmkNwXQBWzotZgws7NVsjgDl4=;
        b=Da3Jtdf9XEiTau2ln+dlvNlkVGVQASdmK7nvQYGqPHAw0ALELZCSAIHy4WqDqawYU6
         /X2i/c1uH3cfST1DoEMugzcUIUUXSjXVtUufOMZ9dHBaFzIWo0bWO4SGp2ErVUaSKn99
         cJToYHrW6Ukv7hbObbhrSiRWKN0bNiNbIdPFxZUJDaEhj/viqBntaOsQS5hGRumuOQxA
         V4X4gTLdgJko4/i/JyLwfD5tIPpLO5CrVMF7bi7QeppeKTJC5NNdgG2QcO9Bu5Aq+c1K
         XgH65iJzxbBLiCa8fE6WK9svMgymFOOUz7HZ6uhfiCt9ba50r9K1vVtcP7GVPBbki7P5
         tkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915227; x=1699520027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6b0vKFdrU+T/hgWwLAmkNwXQBWzotZgws7NVsjgDl4=;
        b=IHR0p/l0OC6GSIs/+v0SBJuEA261Kr+mVXa1KTghpcOTPTU8Oq1ysBFhVWnIqQZ7s9
         XpPZRmSFdZIIErITTS+Vm744ZB2Au3cV3A6L8cmMZ59GOnNIeF67p6E1kWHbkbKhhmLa
         vk+OO3As1Wy/yvP/Dm3S8l092nnW+LtWyFqY1WdOEjDSJ53hmA1lmkReqNXajSi5wh74
         GKMCZbr2EI9Zr4Qq7ZFU6b+NQvOqEyVv4ueOuheugW92JpRjqXbCrXkbCi3xf6lcsFPf
         nRkvrTVaO8Ac1A0AvrxOPnCmvC55wQ4j7QqBKjxYpLZN2W79kLEUBWRvMvyzwUWOYb97
         k5MQ==
X-Gm-Message-State: AOJu0YwJhmHxlLW2iyC7UQQPDpxuqZawnIZCpKWXQRaf57JjH++5huv8
	B9ctAOSE37j07wYXRAZ7yZzH3cnLkkTz+N+pmfU=
X-Google-Smtp-Source: AGHT+IFiNbiAXafEB5B1isvNkqB0EGWZXiWROPsxKQP1giArqPnT/3diMH2clhLvZCYtVldqa2UDc5v3KWMyaOkkb9U=
X-Received: by 2002:a17:90b:1a8d:b0:274:616e:3fc4 with SMTP id
 ng13-20020a17090b1a8d00b00274616e3fc4mr14608023pjb.34.1698915227163; Thu, 02
 Nov 2023 01:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231101192419.794162-1-sandals@crustytoothpaste.net> <20231101192419.794162-2-sandals@crustytoothpaste.net>
 <xmqq8r7howsq.fsf@gitster.g>
In-Reply-To: <xmqq8r7howsq.fsf@gitster.g>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 2 Nov 2023 09:53:36 +0100
Message-ID: <CAN0heSrv7MPcEwkq4uEtv9uBbqm4FLKQLE3gdsEbqKkxPXOj5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] git-merge-file doc: drop "-file" from argument placeholders
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Nov 2023 at 00:53, Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > From: Martin =C3=85gren <martin.agren@gmail.com>
> >
> > `git merge-file` takes three positional arguments. Each of them is
> > documented as `<foo-file>`. In preparation for teaching this command to
> > alternatively take three object IDs, make these placeholders a bit more
>
> Minor nit.  Don't we want to say "three blob object names"?  Unless
> we plan to grow this feature into accepting three tree object names,
> that is.

Hmm, yeah. Or just "three non-filename arguments". I do wonder: doesn't
this mean that the second patch could/should possibly move away from the
notion of "object ID"/`--object-id`? (That's not trying to shift any
blame from one patch to the other, that's my honest reaction.)

Ah, yes, I thought I recognized this. Quoting your response [1] to v2:

> I briefly thought about suggesting --blob-id instead of --object-id
> simply because you'd never want to feed it trees and commits, but
> the error message from read_mmblob() the users would get mentions
> 'blob' to signal that non-blob objects are unwelcome, so the name of
> the optionwould be OK as-is.

Maybe you having a similar reaction a second time makes this smell a bit
more?

[1] https://lore.kernel.org/git/xmqqo7ge2xzl.fsf@gitster.g/


Martin
