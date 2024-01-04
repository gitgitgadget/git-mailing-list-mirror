Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428B20DD2
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcXmISJV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3f8af8297so1831945ad.2
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704364755; x=1704969555; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzKrhXxPEKNuMcvzTIsg1XqfRJxal0rMEOJdwkHW/A8=;
        b=EcXmISJV+84b/fZsiOwOe2n7LDyc5L8Pe2uW1LtzRPh7tLsZS+WbgBCZCUT07SwvGo
         wVJotcp/I0VDZIWbf6y9s21OsGS094ci0Jelj5blvcWtWxUlTpoEq4u/epGMkiWngCSp
         fI6sF/ypoSm0p02R48HAU/pnhquA6yOQKBHp2ZEwEmDsWDfUFEi037B7dA+oG8MLHpP0
         ceWo3SmjuDsfB+tduAZjtojxeQGLe9gvwLtj1X7spH4piJD10WqiE+RtdZKxEHMkmhF7
         hYHVf6diaT9RLHKm34aW2X68KvPC2uxkyj2ka/sDq3rk26zGNNaSYne1SWgJJpPQiTUN
         NodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704364755; x=1704969555;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzKrhXxPEKNuMcvzTIsg1XqfRJxal0rMEOJdwkHW/A8=;
        b=gEed+QW9D8tvABqYJSDoFMia56pcCnJvGTlcMj8uMIJks0Yp7gshBcakiglhnXOPJU
         L8CtLTrJTZZ3oFfn92zDZWvTivm4PeCNI413HRwE0pQHxxtMNj8DzEUMJhQE3uBu7KHO
         UYH3w6GE0DbjT/mPM9MMbNQjg0RQ9CC31undWnQ9l4BvoKJR+2HabjBr+p2wKxH56eK8
         6OYL6R8shcnxxCBZfNuGJHGeV1msvwmo7jrnsdi/gHJcizLPDcdR7/vVHcM1zSVTy2U3
         nshDtjhzsJtBLc+xYUjoDCHOoLOPuRf3rVloA4UBcZxmxV1AlRFWlMoJk7WWOyRQbRNR
         2PWw==
X-Gm-Message-State: AOJu0YzJoQfdmnVp6SE9wu95jlyfhimb39grhJEN49NkQd1m1J8mAvlY
	VaCcTZkKv4hnrlg7R4EOaCo=
X-Google-Smtp-Source: AGHT+IFn05UhOdL0Y7WxsXf8nnAIcLQUtIPHtal5rHhbiP6O+SKlx2wkuNbEh3hDbaNjxB5leUO3KA==
X-Received: by 2002:a17:902:6548:b0:1d4:1dac:9fa9 with SMTP id d8-20020a170902654800b001d41dac9fa9mr280554pln.72.1704364755269;
        Thu, 04 Jan 2024 02:39:15 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001d34126d64dsm23275951plg.222.2024.01.04.02.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 02:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jan 2024 16:09:10 +0530
Message-Id: <CY5UVPHIH8VQ.2I0V9GX4W1A30@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, <gitster@pobox.com>,
 <johannes.schindelin@gmx.de>
Subject: Re: [GSOC][RFC] Heed core.bare from template config file when no
 command line override given, as a microproject.
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
X-Mailer: aerc 0.15.2
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
 <CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
In-Reply-To: <CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>

On Thu Jan 4, 2024 at 3:54 PM IST, Christian Couder wrote:
> On Tue, Jan 2, 2024 at 11:17=E2=80=AFPM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
> >
> > Hello,
> >
> > I'm currently an undergrad beginning my journey of contributing to the
> > Git project. I am seeking feedback on doing "Heed core.bare from
> > template config file when no command line override given" described
> > here
> > https://lore.kernel.org/git/5b39c530f2a0edf3b1492fa13a1132d622a0678e.16=
84218850.git.gitgitgadget@gmail.com/
> > by Elijah Newren, as a microproject. I would like to know from the
> > community, if the complexity and scope of the project is appropriate
> > for a microproject.
>
> Thanks for your interest in the next GSoC!
>
> My opinion is that it's too complex for a micro-project. Now maybe if
> Elijah or others are willing to help you on it, perhaps it will work
> out. I think it's safer to look at simpler micro-projects though.
>
Thank you for your feedback. I will wait for Elijah's response on this and=
=20
perhaps look at other microprojects in the meantime. Although, I think I wi=
ll=20
be able to do this with others help.

> > e.g. in builtin/init-db.c :
> >
> > static int template_bare_config(const char *var, const char *value,
> >                      const struct config_context *ctx, void *cb)
> > {
> >        if(!strcmp(var,"core.bare")) {
>
> We like to have a space character between "if" and "(" as well as after a=
 ","
>
> >              is_bare_repository_cfg =3D git_config_bool(var, value);
> >        }
> >        return 0;
> > }
> >
> > int cmd_init_db(int argc, const char **argv, const char *prefix)
> > {
> > ...
> > ...
> >        if(is_bare_repository_cfg=3D=3D-1) {
>
> We like to have a space character both before and after "=3D=3D" as well
> as between "if" and "(".
>
> >              if(!template_dir)
> >                    git_config_get_pathname("init.templateDir",
> >                                            &template_dir);
> >
> >              if(template_dir) {
> >                    const char* template_config_path
> >                                 =3D xstrfmt("%s/config",
> >                    struct stat st;
> >
> >                    if(!stat(template_config_path, &st) &&
> >                      !S_ISDIR(st.st_mode)) {
> >                          git_config_from_file(template_bare_cfg,
> >                                         template_config_path, NULL);
> >                    }
> >              }
> > ...
> > ...
> >        return init_db(git_dir, real_git_dir, template_dir, hash_algo,
> >                       initial_branch, init_shared_repository, flags);
> > }
> >
> > I also wanted to know if the global config files should have an effect
> > in deciding if the repo is bare or not.
> >
> > Curious to know your thoughts on, if this is the right approach or
> > does it require doing refactoring to bring all the logic in setup.c.
> > Based on your feedback, I can quickly send a patch.
>
> I don't know this area of the code well, so I don't think I can help
> you much on this.

Appreciate your suggestions above. Will keep them in mind while sending the
patch.

> Best,
> Christian.

Thanks,
Ghanshyam
