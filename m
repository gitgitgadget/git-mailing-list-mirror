Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1074776B
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiGBoIaF"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e34a72660so4919965e87.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703089788; x=1703694588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1B1P+D01p3WI6SY00oEGuCV29paAOeF6MsCYk/tJ64=;
        b=eiGBoIaFkjFSW5ZF/pGybYp9kCtFdbOwfuxnIourG9flINMLO/0pw3nYMMe7Olc6m6
         OxNwU0sIwp3FKudhb1IaL7k1w7o/2U6YldV4RqYIV2OYyYGKaO4muxkDdYysbE5WbN4G
         AH1Z06eS/IfYoWGh6PFlI4auqM/ngZ+1cqeUEwlrdnhOJxpsXPwq6A9hn6lOoDcTuE0G
         ouzjoa+Gckd18bGdYFH/eZw4uEImbXyv9UaVXJa18qRxt3VkZ8iGbOXytf+LsCFA79KI
         9snb6Bm/9v5Q9mK7rv8rlrNA65v7WgaIxkoirqEuSpf2DrzZ6dBf/Vb04/+BnvDGy22d
         ZnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703089788; x=1703694588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1B1P+D01p3WI6SY00oEGuCV29paAOeF6MsCYk/tJ64=;
        b=QrAj3ZrHeuO+tzaMupNxiXO6ixxrZZF9rGdIL+YOVk7kFq18f0kjrcRdi80TjwsJL4
         E1IyAXL2xpOIBIClxX9szAboi99WL0cLL/lvfLj2x/mcQofpPcNWG8TxysdcSw7hgyY2
         CDIbjpWHljAZnYuX1XOSAXIKykxJGtdLu52DunzDMFpad9p/zrbQ+9+z6NkqBzSKbb28
         3Dm1sBMI2dHJQJHUlmzEScGTaVBx1FnGFHN+VaL+hY/nN0114OSMFozUh9BFKMO/zWMV
         tGPXlhWobyVPsENZ7q8bO8nufy+jKJUx2YwODLi/+sPthauTcrYJfGA3K5XpXsAlGOrC
         bhXQ==
X-Gm-Message-State: AOJu0YyK3Qe1yQeAzRWWBurxVJVG9Yx8Ewm81vRQVZRVGIOuKMRLPfF3
	K5TjmcON2ni4q1AyiwPbuAgPqkU9ROSCTl2oTBs=
X-Google-Smtp-Source: AGHT+IHg0CUeL3hOIM3DMg8ri2nHiEg7YkreDRKIP9Ku/02gbnbLjTLe0T4v/YWEMmt05ZK+9SltToaoYCu8bJMyigY=
X-Received: by 2002:ac2:4902:0:b0:50e:31bd:14e3 with SMTP id
 n2-20020ac24902000000b0050e31bd14e3mr2855584lfi.126.1703089788222; Wed, 20
 Dec 2023 08:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220070528.8049-1-mi.al.lohmann@gmail.com> <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
In-Reply-To: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 20 Dec 2023 08:29:36 -0800
Message-ID: <CABPp-BHBncDqCSvGm6Ow2D2+JQLf_3htwnxZ-RWV+tsxiH1rhg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: fix reference to synopsys
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Michael Lohmann <mial.lohmann@gmail.com>, git@vger.kernel.org, 
	Michael Lohmann <mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm getting in on the fun by adding a little nit-picking of my own.  :-)

On Wed, Dec 20, 2023 at 7:46=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Am 20.12.23 um 08:05 schrieb Michael Lohmann:
>
> Thank you for this patch and sorry for the nitpicking below!
>
> > 437591a9d738 changed the synopsys from two separate lines for `--abort`
>
> "Synopsys" is a software company.  A "synopsis" is a brief outline.
>
> > and `--continue` to a single line (and it also simultaneously added
> > `--quit`). That way the "enumeration" of the syntax for `--continue` is
> > no longer valid. Since `--quit` is now also part of the same syntax
> > line, a general statement cannot be made any more. Instead of trying to
> > enumerate the synopsys, be explicit in the limitations of when
> > respective actions are valid.
>
> Had to think a moment before I understood that "enumeration" refers to
> "The second syntax" and "The third syntax", which have been combined
> into this line:
>
>        git merge (--continue | --abort | --quit)
>
> And it does make sense that we can no longer say "second syntax" and
> only refer to "git merge --abort", or "third syntax" and mean "git
> merge --continue".  In other words: References by number are no longer
> valid after a merge of some of the synopses.

Thanks for explaining; I also missed that in reading over the original
patch.  It'd be great if Michael could update the commit message to
make this a bit more clear.

> > This change also groups `--abort` and `--continue` together when
> > explaining the circumstances under which they can be run in order to
> > avoid duplication.
> >
> > Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> > ---
> >  Documentation/git-merge.txt | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> > index e8ab340319..d8863cc943 100644
> > --- a/Documentation/git-merge.txt
> > +++ b/Documentation/git-merge.txt
> > @@ -46,21 +46,20 @@ a log message from the user describing the changes.=
 Before the operation,
> >      D---E---F---G---H master
> >  ------------
> >
> > -The second syntax ("`git merge --abort`") can only be run after the
> > -merge has resulted in conflicts. 'git merge --abort' will abort the
> > -merge process and try to reconstruct the pre-merge state. However,
> > -if there were uncommitted changes when the merge started (and
> > -especially if those changes were further modified after the merge
> > -was started), 'git merge --abort' will in some cases be unable to
> > -reconstruct the original (pre-merge) changes. Therefore:
> > +It is possible that a merge failure will prevent this process from bei=
ng
> > +completely automatic. "`git merge --continue`" and "`git merge --abort=
`"
>               ^^^^^^^^^
>               automatically

Do you perhaps mean "completed automatically" (i.e. change both of the
last two words in that sentence, and not just the last one)?  That
would make sense to me, and I like that wording a little better.  But
I think either you need to change both of the last two words of that
sentence (my preference), or neither of them.

> > +can only be run after the merge has resulted in conflicts.
>
> The connection between these two sentences feels weak to me.

This sentence is a bit more problematic than that: Even when there are
no conflicts, "git merge --no-commit" will also stop a merge, and one
can then use either --abort or --continue.  So the assertion made by
this sentence that you're reviewing is not accurate.

>  Perhaps something like this:
>
>    A merge stops if there's a conflict that cannot be resolved
>    automatically.  At that point you can run `git merge --abort` or
>    `git merge --continue`.

I like this alternative wording; it avoids the incorrect assertion and
uses something equivalent to the "completed automatically" suggested
above.
