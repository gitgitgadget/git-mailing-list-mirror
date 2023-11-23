Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtrIQXoX"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B64D5A
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 13:33:56 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so16731841fa.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 13:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700775234; x=1701380034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afDTyezBQWtOzPNE/xf/XSx1mVr4Tg7Qqk7cvfQfwV0=;
        b=WtrIQXoXw3uepoUEsnq54VPz8vmlWjFo6Bn/N11tHeVUl5ndjlcmsmM2/MD7Fu5ER5
         QweE3q/eEGDtk6QsD/s97x35vx7Vb+ZPPL6dHHSHNGRiM4exHF2lf2Gq19PqwNII7DTU
         3WWoKChCSXb6i8cGP/6jGSyd0EbiL8Ey6AJxV17lFy/JUqZ9ylBf3fkGknXnNGjT7GCP
         NZ/D8TibrUIV1u5J1ZBuEJLOjuX1N8qJsNxLZ10MVaMjwKdz036L7v9HhfZCJ7Sh31Fa
         34NREyT1TtJQ9lYVLcti3XT9Mp+/IETaMxqaABoHGDng5oEvb+zZrFhrHQ2DiPCW35ti
         j4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700775234; x=1701380034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afDTyezBQWtOzPNE/xf/XSx1mVr4Tg7Qqk7cvfQfwV0=;
        b=lh9gaYNTEJ9k43yMINpSkIWdroZEg7oO9NeEwLp0bYvICMxLdeufwB9TVohEzpplom
         SjTcGHupZTVzdiCVEElBoadLphEhATmbrevGZWHOJ8FHDrnkDf+TbQCuczvYdI6jY8Ph
         euGMnMG4AVZofZoJNiruxWki5ceUyzy6+Coc3NBJcL7Yd4XuwgseNJy3Xdspeg2dKQ03
         ydqn+2QhFM8kNxPyYPyx9dQeZQEUbhp+LYMi0pMAPd1e81QpsJQcQAnll/AXBQuLoLoj
         AJ0PG2sAiKaNYkq1uZ69Nb+Ekb/pZky4/TcN+KVQ20a4WksKM07CepmakR5RxKuzopHM
         gK4w==
X-Gm-Message-State: AOJu0Yx9pAOE6s3jjF6AezjXh2HQ3pxystX7QjlfgqRkjfa7kEWNUTea
	Va4UUn+5k2FT4HlIfIlZVDufHhw3fIy/sbTDSDhhXYanR6c=
X-Google-Smtp-Source: AGHT+IFJfm2ABKg24e8c5778/Hx1P9h94DjQGNVZdlLgnvKRsiUr+CQsksVIqEssAZ4JePx4P/GG6GzzqnRsBVrtIWQ=
X-Received: by 2002:a2e:3a19:0:b0:2c8:87bd:7c06 with SMTP id
 h25-20020a2e3a19000000b002c887bd7c06mr381218lja.13.1700775234292; Thu, 23 Nov
 2023 13:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <9f0bba69492b345fe7b0c7f9529b025ed98c7e29.1695553043.git.gitgitgadget@gmail.com>
In-Reply-To: <9f0bba69492b345fe7b0c7f9529b025ed98c7e29.1695553043.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Nov 2023 13:33:00 -0800
Message-ID: <CABPp-BFrVjzbVDBWv_zaeScFhZ4Z2v5whSLAVkU_SuerKcujVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: refer to internet archive
To: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 2:47=E2=80=AFPM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Josh Soref <jsoref@gmail.com>
>
> These pages are no longer reachable from their original locations,
> which makes things difficult for readers. Instead, switch to linking to
> the Internet Archive for the content.

Thanks, these all look good, except on of the old links works for me.
Maybe it was just down the day you checked?  More comments on that
below...

>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  gitweb/gitweb.perl       | 4 ++--
>  sha1dc/sha1.c            | 2 +-
>  t/lib-gpg.sh             | 2 +-
>  t/t9816-git-p4-locked.sh | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b6659410ef1..f12bed87db9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8192,8 +8192,8 @@ sub git_feed {
>         my $format =3D shift || 'atom';
>         my $have_blame =3D gitweb_check_feature('blame');
>
> -       # Atom: http://www.atomenabled.org/developers/syndication/
> -       # RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
> +       # Atom: https://web.archive.org/web/20230815171113/https://www.at=
omenabled.org/developers/syndication/
> +       # RSS:  https://web.archive.org/web/20030729001534/http://www.not=
estips.com/80256B3A007F2692/1/NAMO5P9UPQ

The original www.atomenabled.org link works for me.
