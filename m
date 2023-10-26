Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D98BFD
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+8eD5Jt"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210E6CC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:41:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5287a12.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698360088; x=1698964888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL7fS1tPkQ6HqJvB7mby8lhvONrZLwFpFk2nGCHDpl8=;
        b=n+8eD5JtWS+syK7dIO7O2thvynqH7DHBHER03B1zAk4P8na92MUe16k/B6lh9LFdYI
         NIifYUCJIPi+WOP35CEcYv2k5tbQ16dbyIgM7JkQhlpOj1vT+rXqo8ytsoopLYxrRWoe
         o8MtzyVbLSkYopMHHGMMEShKYOjMXRR36VWIm2TuhyMfmzPgBLK18tkHoUfP2eMykmI1
         8wKfhDkIY6wGbLaRu/VEgtMtzNA5NhRrpUqSyFzt9nQY0LreLvjmQJUoF1qyKL7ZB/Lx
         2iuceYOqptdG1yvjnZ3Hh3y1zA0fejiNczV/gB2e56/R7kXUPp1aH59bx0nv4+vDrBYV
         Q4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360088; x=1698964888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL7fS1tPkQ6HqJvB7mby8lhvONrZLwFpFk2nGCHDpl8=;
        b=fala/+gvAQJ081D3AcjWsWDW4cpqKyNZwuCREDRaZGgJ2OepkTV++ylOZ9YeZcpwV8
         O/89Vjkg8jxGjtSMeHL+Cqk+kNg5CRMiP7A6z1c/P+4qcRmRshNcWt4cZcp6HJ4ZS4hW
         TXsAack3WBsmqzByj6fgqg0umeTnOgOLgOwscj/LvaZO1rxcDOIjFtzcLPxomTYdW8nx
         pdVb77igYLI2h9Rxp0YIJKHD6T2/wPXEtSY5VoCw+YNOhAPVHVbKMKHBMd/r0rWSxX+f
         NeWoBAGVpob0nS6ZP4qpKjC4PrRslh5b1RnXiSvj7IY9X58VjZMls324mxL0j8HOz+ps
         f7dQ==
X-Gm-Message-State: AOJu0YwgYRPmpTbPc7Sb7eWYsapvslJbWWtK/AchFSEmS5CPlzJDRttw
	LZs7XWcqlHxdiL8ksgUTxVSb/2R0skpUrs+G+W//jw==
X-Google-Smtp-Source: AGHT+IGfT3MWpB4dOetgOrQYvfA9mQLTyb1+SK/5fqPk9JxwJ1h2fEQX+k9c1Yqt1Cjj2lK7tcQO3wBsP/oH0DMGnX4=
X-Received: by 2002:a50:954a:0:b0:53d:b53c:946b with SMTP id
 v10-20020a50954a000000b0053db53c946bmr60308eda.2.1698360088185; Thu, 26 Oct
 2023 15:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <849b6ee2-99f3-4aaa-835f-44d3e13befc3@gmail.com>
 <ZTpJFUdE2U6pbV--@debian.me> <CAPig+cSsB-2xxF7uQRU2h219+0-9++M_woLX3vNwiq1Uj1SiQQ@mail.gmail.com>
In-Reply-To: <CAPig+cSsB-2xxF7uQRU2h219+0-9++M_woLX3vNwiq1Uj1SiQQ@mail.gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 26 Oct 2023 15:41:13 -0700
Message-ID: <CAJoAoZ=a30QsMXHz+47haZ=QGkY8-QYccSuY_94mi9h9RMiBFA@mail.gmail.com>
Subject: Re: git diagnose with invalid CLI argument does not report error
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Sheik <sahibzone@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Alex Henrie <alexhenrie24@gmail.com>, Derrick Stolee <derrickstolee@github.com>, 
	Victoria Dye <vdye@github.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To be clear, that patch was for git-bugreport and doesn't cover
git-diagnose. I assume the fix ends up being pretty similar though.

On Thu, Oct 26, 2023 at 3:12=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Thu, Oct 26, 2023 at 7:10=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> > On Thu, Oct 26, 2023 at 07:49:58AM +1100, Sheik wrote:
> > > Hi Maintainers,
> > >
> > > Running git diagnose with an invalid CLI argument in a valid Git dire=
ctory
> > > does not report error. Expected behaviour would be that it reports an=
 error.
> > >
> > > #Example shell commands which should have reported an error but conti=
nues to
> > > succeed
> > >
> > > cd $ToAGitDirectory
> > > git diagnose mod
> > > git diagnose mode
> > > git diagnose mode=3Dall
> >
> > I can reproduce this only when the invalid parameter is a normal word:
> > ```
> > $ git diagnose huh
> > ```
> > But the command errors out on invalid flag:
> > ```
> > $ git diagnose -m
> > ```
> > Cc:'ing people who recently worked on builtin/diagnose.c for help.
>
> A patch by Emily to fix this has been submitted[v4].
>
> [v4]: https://lore.kernel.org/git/20231026182231.3369370-3-nasamuffin@goo=
gle.com/
>
