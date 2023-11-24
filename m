Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g32O+qsu"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162341735
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:32:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507975d34e8so2785870e87.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700839943; x=1701444743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90DWKebH191Gjc8KXOZsvyc25R9c9zlOWeVniPrcci0=;
        b=g32O+qsuGdUGgNIS0cC92Xufu3uM7bL0DRYzteT1QrRh0OXewkxBHvRTd7fJh/QHP6
         AXYa7pDwUq4nlgBCYUvODtoGBlgEgr2Y5jFxHNWV0gucvkkoBhIK/eTL6CCnZTXbPWom
         G9pqb1F6iUxbJ2XGyJ8EH2dVK69pc3ipiXvUC4FZWciUv8EXzYSnB66piQp6LiYNzTtx
         Y+yMIE41UFeNsWhTLoQOqurwh2tasWwqV2NJanHI97W1t+sJU/EiviOklozwlPn6a6UG
         eJT/25cMT29QQL7I4rzg1zM8ho2P0aTTPFhMYwRiokw+RvVuMj0z0PdvJabUHLm17gsl
         eaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839943; x=1701444743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90DWKebH191Gjc8KXOZsvyc25R9c9zlOWeVniPrcci0=;
        b=LII9Q6I3eIBfG89k2PLSXWDvbjqZqnwHkqgX6NKCFMqEAFQ9qsZI60CJc06h8TDNYd
         iu+AsGRhR+XiuRxBrhTYMCxxVbRoYotHGLI2LYCSfNNcprqGXKJPzUw8y6j+5Bv9Lnx+
         ZGlAVnkp4ncGTZotd56wTyRP8Ovd/KbdjZI0Vwt3Bu1WOUs7Vl5JJRet0E9R5MMbt0YV
         OU7qSkvGQvrdlB4Ss48tQYnWdS9ID9QmHZREb7pwMrxmNJKnmiP2xIAYBE9uZmsJv4Qe
         zOMrYrVWImxGhVoRUUwAAFWAKm3pzZBuMGq2wmKB/vHd24prBP2HQ8PVzk38+dFGgYI5
         Puvw==
X-Gm-Message-State: AOJu0YzE8++8LvAZLbWlo4cmZ6Hueu97yx2jd+BIpJ9/j68Wfq4+hvjw
	pJXj71obEOIAPhuF9iUWggEkosKVVkzgf928/mA=
X-Google-Smtp-Source: AGHT+IEPkyt8ETTgylMRIcUHO6W+2gosv87kHmauaNDh+biDAYv5DEljY9Yw61l4ULcxmCSRhz6kyLAEq5BsEv7z4iM=
X-Received: by 2002:ac2:5ed9:0:b0:50a:a2b5:67ae with SMTP id
 d25-20020ac25ed9000000b0050aa2b567aemr2126046lfq.2.1700839943104; Fri, 24 Nov
 2023 07:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <9f0bba69492b345fe7b0c7f9529b025ed98c7e29.1695553043.git.gitgitgadget@gmail.com>
 <CABPp-BFrVjzbVDBWv_zaeScFhZ4Z2v5whSLAVkU_SuerKcujVw@mail.gmail.com> <CACZqfqCksg=uMh=URh-0KEoPA9cvjgDAKPhn+0WZti-y2A540Q@mail.gmail.com>
In-Reply-To: <CACZqfqCksg=uMh=URh-0KEoPA9cvjgDAKPhn+0WZti-y2A540Q@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 24 Nov 2023 07:32:10 -0800
Message-ID: <CABPp-BGVFjdRhtXtm0Wgygu3yrxzDfZG2vxyqHqiFzfQNnOxTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: refer to internet archive
To: Josh Soref <jsoref@gmail.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:24=E2=80=AFPM Josh Soref <jsoref@gmail.com> wrote=
:
>
> Elijah Newren wrote:
> > Thanks, these all look good, except on of the old links works for me.
> > Maybe it was just down the day you checked?
>
> > More comments on that below...
>
> > > -       # Atom: http://www.atomenabled.org/developers/syndication/
> > > -       # RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UP=
Q
> > > +       # Atom: https://web.archive.org/web/20230815171113/https://ww=
w.atomenabled.org/developers/syndication/
> > > +       # RSS:  https://web.archive.org/web/20030729001534/http://www=
.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
> >
> > The original www.atomenabled.org link works for me.
>
> That's odd. As you can see based on my archive.org link, at some point
> they had `https` support (their certificate expired Feb 7, 2021 UTC).
>
> Personally, as a former web browser developer, I'd rather people rely
> on archived authenticated content than content that could be rewritten
> in transit.

I think that'd be perfectly reasonable, I was just thrown because the
justification was that the links no longer worked.  Mentioning why the
changes are being made in the commit message, and in particular that
there are two reasons for the changes, would have been sufficient.

> That said, I'm going to drop this change.

Your call.
