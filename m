Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546A1FBC
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2E+0J+w"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44BFC0
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:41:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so822254a12.2
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697794888; x=1698399688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBw67ydQrZG1FlDG4zw5Q+Ilgle998Fo3nVfFF1uQ3M=;
        b=d2E+0J+wtDx+QA2HOAK8LPoQ/diI5WFp2lu5HbouZbKGyaHODiGb35gnFUva6FRz2L
         YMXMMSNjjrTflAflZxRRMZIF1sIuEnItWn9DT6xgCJFmfrHDAh8OIt1/WLUuqvpMkE1h
         eDIgIiO3F4xZX3f+Q9Nrt+rNTKmRtyEsGY0qA51HEMttKjfWTgbinSgMq1KMqvV1pRR0
         v6mWh8Le40COUpBM+u88Ife6/JHjtTf79Eafi5EisOh0XUv0d/9XkZjYcXyQDhGn7qYX
         E0yK6ys1GN06GwtLccDKkuE2uDlrduZNHN4Hl8kmgI8tbyyelbaLmeyR60ctVWKawAZi
         ESzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794888; x=1698399688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBw67ydQrZG1FlDG4zw5Q+Ilgle998Fo3nVfFF1uQ3M=;
        b=VzcGEQSVBPB1eX0mVhNH4XIlWtKR6mPa8vDvpgZiNJSVBVykGt0PpXQJ+wL7ZLosRL
         BBGHAgVqfyuMvQGNxWGWm1qbcznfAiY/2fPd1Dmqv1twlVFk5AijROoyr0WFO0R4S5bJ
         hkAYc5rCjXT9ii+TT1Pr1CxH4vCfI6AZhCQsTQqM1m0lyohkH1f09DH19eHqrTMIlZQQ
         MN4ME48A8p2Iw4t7D4Xz2L78msBnMZ2qO5YLNfzQscYcIe4FuJff2Eob9J2fqnbp/6dH
         1TSXN5YKBd8j/TdcQaGQwHWpHgAnLWbFVSwGra7YCBCRlMbqjx9GNsjTclwAkNXZEFt1
         N8rw==
X-Gm-Message-State: AOJu0YwElZSx7r4SDUOCDAW34/2ACq3xoeMkF/8Jd7eUKOwNWd81xWi2
	7nlsTS8LfCyqFx558yaY7VB83CxODnPBUCfnPFs=
X-Google-Smtp-Source: AGHT+IFDd3lmglevbMsUH8ZxYbOJVhdlJtBN25SD8e18XGT0S0wnFnT40hTEIuU+1UTDt7vynMllAYp1PpQpU/fy5wk=
X-Received: by 2002:a50:d09c:0:b0:53e:7a2d:a4a2 with SMTP id
 v28-20020a50d09c000000b0053e7a2da4a2mr1000612edd.39.1697794887898; Fri, 20
 Oct 2023 02:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
 <20231019084052.567922-1-isokenjune@gmail.com> <CAJHH8bFXVnFgjoCD+JU2uw77JAWUiKU+G=ub9Xg7xYJ_MwXPQQ@mail.gmail.com>
In-Reply-To: <CAJHH8bFXVnFgjoCD+JU2uw77JAWUiKU+G=ub9Xg7xYJ_MwXPQQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 20 Oct 2023 11:41:15 +0200
Message-ID: <CAP8UFD1U0cz3CDdE_0d0FUgPKP2pX-ZcVDJqz2tW-+rnZ7rvQw@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/branch.c: adjust error messages to coding guidelines
To: Isoken Ibizugbe <isokenjune@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Isoken,

On Fri, Oct 20, 2023 at 6:28=E2=80=AFAM Isoken Ibizugbe <isokenjune@gmail.c=
om> wrote:
>
> On Thu, Oct 19, 2023 at 9:41=E2=80=AFAM Isoken June Ibizugbe
> <isokenjune@gmail.com> wrote:
> >
> > As per the CodingGuidelines document, it is recommended that a single-l=
ine
> > message provided to error messages such as die(), error() and warning()=
,
> > should start with a lowercase letter and should not end with a period.
> > Also this patch fixes the tests broken by the changes.
> >
> > Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> > ---
> >  builtin/branch.c          | 66 +++++++++++++++++++--------------------
> >  t/t2407-worktree-heads.sh |  2 +-
> >  t/t3200-branch.sh         | 16 +++++-----
> >  t/t3202-show-branch.sh    | 10 +++---
> >  4 files changed, 47 insertions(+), 47 deletions(-)
> Hello Junio, I would appreciate your comment on this.

Please don't expect Junio to give direct feedback on all the patches
sent to the mailing list. This patch has already been reviewed by
Rub=C3=A9n. If Junio doesn't review it and if this patch is not mentioned
in the next "What's cooking in git.git" email from Junio, it likely
means that you should send a version 3 addressing Rub=C3=A9n's feedback
about the commit message.

Thanks,
Christian.
