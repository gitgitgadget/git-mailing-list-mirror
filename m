Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B75481D0
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anogvQp1"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-6d9f4eed60eso2042132a34.1
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 09:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702834122; x=1703438922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXOMdGg6yDnqZ3ZnwqSYN28KUAx1xf+VCD8Rfc8Pbyc=;
        b=anogvQp1eiWSrNlvLuDTeE2xf5Ih9hsa2XbxvVgRzeMC5JCe29rKfGseU8bu9VpeKR
         LYefJLr0vhuQ0n7jazBRW0f01z3T58c06h37yKheKgo9PaXtob5W9xxv6WDgp7wT9Yhr
         EBRFKwIgJnhu7dkV5eH2U6jRuuiGvcIkSY82gGFZ3X/DG1SmoqyKaGg5TbeJVDTFXdRN
         9IS43lHzSTo3Hbvlc8yc6NaZfWlFjOP4yn6Wi+uI60Z0WAjff4zaNqUvK7ltc0xSj01v
         h8PurX4g0ULZE7SFKy1EHddBoVKYld1uhC9GFikykSC2PWoTy/mThwTZl0CbCWGGusM8
         FrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702834122; x=1703438922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXOMdGg6yDnqZ3ZnwqSYN28KUAx1xf+VCD8Rfc8Pbyc=;
        b=MxTqzb8eCus2i94wSy0dmR6TJH0XnSPeYqOncM/Rwxqczdn2mqxzqE4aIcgWQ6O7TR
         JWMeVmU4dc3HALlHDFnfRH+v4hRAasiXAXOvo3jWqd6bx4JCp2FhfoaC7YSoHTnesDxH
         DfMRIKTMad4+XUvm+48kNugT3Iivj0CgFzo7ng8WxSxIqcPGhHI7qRK4ixLyEG6d7mCi
         EVAFUWT9LnjXoAi0Ss9jsOgFR/eIPB7+VLGrAdTytrMchv9XLXZN3Ao4+vU0DY57dpuX
         zSZujBeiPtkbK3SnYGaXGwzKu/IXxFhKt3lcLZFEYCq6QLY7p4Pe3VAFJsD8209DIqCf
         pZiA==
X-Gm-Message-State: AOJu0YzFMSR9cqYQrbVnHmjgA4TqrHUsy0Ox8UYHIDBzGSXZCGn+KKUG
	ggHhWegMeSQBlh3KoHYGnQo8B8rIJ4TfSZSGilaOvk4bfhJxkFHkf3AGiA==
X-Google-Smtp-Source: AGHT+IEfkEjXN0f/JlGUOqzcOs73iS7s3Wuw9J4WmVF810HgPcHEuycq6/I45E341R43GJ0+BNSpkU9km3eTu7pIg6I=
X-Received: by 2002:a05:6358:c3a2:b0:170:17eb:204e with SMTP id
 fl34-20020a056358c3a200b0017017eb204emr11775530rwb.55.1702834122088; Sun, 17
 Dec 2023 09:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ=bxz8txyOt6p5L0qfx5DFKfxUhWvHW0pJP+YTbWVfBpvYxg@mail.gmail.com>
 <xmqqsf45nbzm.fsf@gitster.g> <xmqqo7eoiwcb.fsf@gitster.g>
In-Reply-To: <xmqqo7eoiwcb.fsf@gitster.g>
From: =?UTF-8?B?ROaXoOaVsA==?= <wushuripple@gmail.com>
Date: Mon, 18 Dec 2023 01:28:30 +0800
Message-ID: <CAOQ=bxyBVRJN68iLs7g=DjB+J7aHEFgwnGuhS_ub2=q3StiRkQ@mail.gmail.com>
Subject: Re: End-of-line comments are prompted with "is not a valid attribute name"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see, thanks for the answer.
I was fooled by the VSCode highlighting, but also because I didn't try
to figure out the documentation carefully.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=80 01:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > This is totally expected; nothing to see here.
>
> To put it another way, we do not have "end-of-line comment"
> (i.e. the leading part of a line has payload, but the line is
> chomped in the middle with a comment character and the remainder of
> the line is ignored) at all.  We have "commented line" (in other
> words, a line that is totally commented out and gets ignored).
>
> I think it is very clearly documented in "git help attributes":
>
>     A `gitattributes` file is a simple text file that gives
>     `attributes` to pathnames.
>
>     Each line in `gitattributes` file is of form:
>
>             pattern attr1 attr2 ...
>
>     That is, a pattern followed by an attributes list,
>     separated by whitespaces. Leading and trailing whitespaces are
>     ignored. Lines that begin with '#' are ignored. Patterns
>     that begin with a double quote are quoted in C style.
>
