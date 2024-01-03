Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D51CFAE
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+u2z9bU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so859246666b.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704299594; x=1704904394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJqkYji9erDfAiR0Xb6668cT0eMYlBfGy3zzgu5hdZ8=;
        b=a+u2z9bUkUvAIn0Qz5kJLQ0hY94MQfg92HuvK1k2HrZSM+7WWUXKxtafkomDf2kDyM
         B/tOZ/HdgxSgjRu5tUPkwjQo1FTtL9KriYOMErPfnvYCFYAhRAICqVbI/nsJRiXGSWaa
         J0mCkwy+rbvDxD7boGSDeAg//3aEe6r7STBj+wCtEk7/MENd/IQsyXgmIrsbcCq2cI2P
         uaQTaAbO0w7JAwraB3k3F7wDTDGNDSgpUetYsc+B8tDSDLYoP3fY4OgK5a6kJU3Fid3u
         ygkaV2Ze/2GN4MJ0lgr+q6BUhYF7yJIiyI6ENBZKWhoolfPrpMlDocc/kQrZRaLKUtqA
         z3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299594; x=1704904394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJqkYji9erDfAiR0Xb6668cT0eMYlBfGy3zzgu5hdZ8=;
        b=BiZViZfC8gD+Sf2ZlFUZmmdgmcyphW8VGs1x68xN7zx+eW1l1OjqegvqXCug1dUByp
         T9yPSM5jw/S+BBAAleb7us/mvkr0ufudqPIdhZhjNYA6TArwtaxG++maLLPhWchem5zb
         X4Jx3xqxLvcB3Fs4wuw+tPS2ZzcPi6ex8bswddIfIUN5B0+QkT8mhhEpZLdbPcy0ww4O
         mE4uXS6RdQIWbv4phrn4UOC+kjMesJbL2BTlveYmsX2I6eNPrr1Z0RFC70SodQLeTBF2
         x4KnCrtwLYH4hiRRINM8eyIvssMtGY/V1AtrjIvvYQsXYFLSDi5ybd7QOzkdl0EZG9M5
         VRGg==
X-Gm-Message-State: AOJu0YxlpYO1nd0ms+lb4wj9JOBwOtGI5gSmS6J4LFjayy/lCmxiXH65
	3FRAFZ7hRLUkNgF0qbsQ5zhfTZ5bwAIWvMgCVy0/8F6p9WY=
X-Google-Smtp-Source: AGHT+IHPtUzG+tDgeUeaQW622bYIpI02pR9460IAO1q2KcOpQMKSs3tBneGEcM77g9OhKBAWU9FnRkVKm7fbQUjr78Q=
X-Received: by 2002:a17:906:d511:b0:a23:645f:af3b with SMTP id
 cq17-20020a170906d51100b00a23645faf3bmr5392050ejc.1.1704299593445; Wed, 03
 Jan 2024 08:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com> <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
 <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
 <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
 <xmqqzfyfoy2w.fsf@gitster.g> <CAEWN6q2XeDDLvSM-ik_-HVqpeyYZLWpPwoj2SUyB9L9NyMJPLw@mail.gmail.com>
In-Reply-To: <CAEWN6q2XeDDLvSM-ik_-HVqpeyYZLWpPwoj2SUyB9L9NyMJPLw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 3 Jan 2024 17:33:00 +0100
Message-ID: <CAP8UFD38X5sT2qTB7P4oeOgWyc3W2Y4gp6DO3VZrAELSS8TzbQ@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Zach FettersMoore <zach.fetters@apollographql.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry for replying only to Zach instead of everyone previously.)

On Wed, Dec 13, 2023 at 4:20=E2=80=AFPM Zach FettersMoore
<zach.fetters@apollographql.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >>> > $ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> >>> > Merge made by the 'ort' strategy.
> >>> > e274aed3ba6d0659fb4cc014587cf31c1e8df7f4
> >>>
> >>> Looking into this some it looks like it could be a bash config
> >>> difference? My machine always runs it all the way through vs
> >>> failing for recursion depth. Although that would also be an issue
> >>> which is solved by this fix.
> >>
> >> I use Ubuntu where /bin/sh is dash so my current guess is that dash
> >> might have a smaller recursion limit than bash.
> >
> > That sounds quite bad. Does it have to be recursive (iow, if we can
> > rewrite the logic to be iterative instead, that would be a much better
> > way to fix the issue)?
>
> I don't think an iterative vs recursive approach fixes this
> particular issue, the root of the issue this patch is fixing
> is that lots of commits from the history of subtrees not
> being acted upon are being processed when they don't need to
> be. So the iterative approach would likely resolve the
> recursion limit issue for some shells, but in my instance
> I don't see a recursion limit error, it just takes an
> extraordinary amount of time to run the split command
> because of all the unnecessary processing which needs to be
> avoided which this patch fixes.

Fixing possible recursion might be an improvement on top of your
patch. But without your patch the test case it describes would anyway
take a lot more time than seems necessary. So I agree that your patch
should definitely be merged anyway.
