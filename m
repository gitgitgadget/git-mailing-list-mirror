Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubsado.com header.i=@dubsado.com header.b="p1w+XxQu"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C1E1A5
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 18:20:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so3433925ad.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 18:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubsado.com; s=google; t=1701915604; x=1702520404; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrhKObJg9nzfMEQ8m3I4bCjzkk2dplRAFzb1KlbFbUE=;
        b=p1w+XxQumw7/SLClcfPeXpkD7bFZ0Qi5CVnHp0m8ky9YvHs6H21mEyZEnSLlrQKM+K
         GJuKEeiRmzJMTWSxEnW/7YurKkYlsoHJlbWxoObC1ytIG1HavN8MDzxqmJi0Ns4OK+43
         t0QHUHeyxjBtnFrczG64UtRjTAvytK9HujM0zTTOLMCiNyKxO0zTuiEO1DS6aHChE7ux
         r88cumR54XV3xO/D2nP/zzCgCJwfbbzTuoDH9fiR1LISwCMoDiefyiZ+5XB1hqqaOivh
         fKc7HToudUdFJO9ctjiHUzm4pdtvJe/KBtwj2rg2li/5lOwdEz9GgHrdCGQJe5IN8Pxe
         jNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701915604; x=1702520404;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrhKObJg9nzfMEQ8m3I4bCjzkk2dplRAFzb1KlbFbUE=;
        b=DmNePkZv48YDvQsNybUF/WJ9WeD0H7S/NiM7B5Dpik/yCOBLVG3jY//aTZywGO9KXF
         RkCTVFHrM5LH2lnbyhNH14VPCuUAXJ8wtxmg4LyuVFV8c00+jjo56B5TQfNcd2oFH0bl
         cHCALM1tKICky1YB3Lk70HO/Ht+uEeMjE6T2M84vxZYBSLyz5IHAJgMnQPWUPIpdz+l8
         pnu0wr8hW/i9g42c1A3IE8Ib0nAx+/HYQ5fSR7PUHCL7HG8uokTlwQnoZWin/+dxkqd8
         fm3LHt4cd6Jr5OqMi1dX1N7Pph2cVP7hvDUTz9CNaMDqu7dY4CE1tokCUlIseNp4BJP8
         C2hA==
X-Gm-Message-State: AOJu0YyCV71BhsL08pivxudADjDkOZRF0Paymg33eytg0Euh+D2SnyZq
	g8SBk+V3rhm/Q6wWs+C4xo3o4zWcyyIDuILfuiP3gA==
X-Google-Smtp-Source: AGHT+IHZTSOcZL/j/NTjzfC23XrBfXKlCp1AtQQJrzoVxZOMqj7sgV59G2UoVuA/k4+HYU5ufmNifw==
X-Received: by 2002:a17:902:f546:b0:1d0:c4d8:3e50 with SMTP id h6-20020a170902f54600b001d0c4d83e50mr1761323plf.74.1701915604229;
        Wed, 06 Dec 2023 18:20:04 -0800 (PST)
Received: from smtpclient.apple ([198.59.164.90])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001d055328e1dsm132041pld.223.2023.12.06.18.20.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 18:20:03 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: git switch has fatal dependency on default fetch config
From: "Jeremiah Steele (Jerry)" <jeremiah@dubsado.com>
In-Reply-To: <20231206191148.GA103708@coredump.intra.peff.net>
Date: Wed, 6 Dec 2023 18:20:02 -0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94F78A2F-8AAA-49FE-A0A0-D63F1DAE3D31@dubsado.com>
References: <634F40AF-25F8-4FE6-BDE3-08798E699A9E@dubsado.com>
 <20231206191148.GA103708@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

For me, the main convenience of upstream tracking is for "git status" =
ahead/behind info, which requires you to have already fetched changes =
from the remote. For my "normal" work, I have a small set of branches =
set as default fetch refs. When I need to work on a branch not in that =
set, I fetch that specific branch. (I'm not interested in downloading =
and creating hundreds of branches when I only need one.)

The requirement to reverse-engineer from the *default* fetch refspec =
seems like an odd implementation choice and a major shortcoming for =
storing tracking configuration. The vast majority of the time, =
origin/branch will map to refs/heads/branch on the remote anyhow. When I =
have a command that sets up tracking configuration, I would expect to be =
able to specify the remote refspec somehow, rather than having a hard =
dependency on a configuration value for default behavior. I feel like =
the following sequence should work as expected (with a limited default =
fetch spec), but there are several things that go wrong:

% git fetch origin feature # should fetch to refs/remotes/origin/feature
% git switch feature # should find origin/feature, create a local branch =
with the same name, and set up tracking

Oh well.

Thanks for the response and the explanation.

> On Dec 6, 2023, at 11:11 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Dec 05, 2023 at 07:41:28PM -0800, Jeremiah Steele (Jerry) =
wrote:
>=20
>> Changing the default fetch refspec for a remote breaks git switch:
>>=20
>> % git branch -r
>>  origin/HEAD -> origin/master
>>  origin/feature
>>  origin/master
>> % git remote set-branches origin master
>> % git switch -c feature --track origin/feature
>> fatal: cannot set up tracking information; starting point =
'origin/feature' is not a branch
>> % git remote set-branches --add origin feature
>> % git switch -c feature --track origin/feature
>> branch 'feature' set up to track 'origin/feature'.
>> Switched to a new branch 'feature'
>>=20
>> It seems like I should be able to fetch a remote branch and track it
>> without having to monkey around with my default fetch config. Is =
there
>> a reason git switch has a hard dependency on the default remote fetch
>> refspec configuration?
>=20
> I think it's required by the form of the tracking config, which is
> defined by a named remote and a remote branch, like:
>=20
>  [branch "foo"]
>  remote =3D origin
>  merge =3D refs/heads/foo
>=20
> You explicitly asked to track "origin/feature", which means that Git =
has
> to be able to turn that into config as above. It can handle two cases:
>=20
>  1. It's a local branch in refs/heads/, in which case the remote is =
"."
>     and the "merge" field is the name of the branch.
>=20
>  2. It's a ref that can be found by reversing a fetch refspec. With =
the
>     default remote.origin.fetch refspec of =
refs/heads/*:refs/remotes/origin/*,
>     we know that "refs/remotes/origin/feature" comes from =
"refs/heads/feature"
>     on the "origin" remote.
>=20
>     But since you used "remote set-branches" to limit that refspec, we
>     can't do that same reversal. And "origin/feature", while we do
>     still have it as a ref, does not correspond to any remote ref we'd
>     fetch. So we don't know how to set up the tracking config.
>=20
> The notion of "tracking" really came about as defining what "git pull"
> does. And without a remote that fetches, "git pull" does not really =
make
> much sense.
>=20
> I'd guess that you are more interested in being able to just use
> @{upstream}, especially as the default for things like rebase, etc. =
And
> that could work without being able to actually fetch the ref. But =
those
> two things are intertwined in Git. You obviously can still base a =
branch
> off of "origin/feature", but you'll have to specify it manually when
> doing rebase, etc.
>=20
> -Peff

