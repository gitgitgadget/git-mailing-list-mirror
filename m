Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367FD2E5
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUcwXuTF"
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B51DD
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:10:07 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da041ffef81so4673183276.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698729006; x=1699333806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXBSnea96tx7NJ7t8mPkHC66g6HfRVIwpzzNzoVF8+I=;
        b=HUcwXuTF8KYj2My/71EHJ12B9ZPlOLBQXhAOIxAKeZ72tNP28WwQkFnHUyiggD7Jun
         MubTO5I8JTwGJV9knldr2OYR8fRXBekEhylnbZnF5p0VuRbS98b03g1ZXDRY+0J5ylqh
         jisF11mcJ6rNmgdxfivEY/CnFTRPC8OXWlIJ6Am1m/vkv7yQw+cScd2fKN6DF1WtAgF3
         eEt/R1SdlPgYbI8N5l94r8iZVDeGJ53QzFYQMQPtOccHVfJkm/mYx0l+uKl+xagRXM4F
         KoA0H61qY7C0JTgr2+dbHZuSZ6yvCIzHTYTEzPSFNaVLMKyzhT0zieqtFgxS2J1f4x9C
         THng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698729006; x=1699333806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXBSnea96tx7NJ7t8mPkHC66g6HfRVIwpzzNzoVF8+I=;
        b=qliUWvu7UQd4nM/QSaoece5smASOzset5T4SMOl5upD2XX0mfFjGdSEca4hGocowoy
         CuMpOjNjjt1yyDMheEgAg6YVlSb+TDgaMDHUoJ3MbPLas6Rn5qmvzEq8nLa0CdtHNWxd
         uKWDPJSBh2cwaIam8OussevW+3hHqgHB7knIrhTlkmU11cRVT8oq3RrvZQSFcRc+qziu
         8yvrrfE5WAHaQtOxO106kRE6HFBDBsetDhe2oD0jruo5RvECaw8RunWuSepuKHe+XuHg
         ZVVxE3Y7a8X1S4SpzgHtB8S0TOKilN8ZhpHnXrmJsx8drkF+BKYFlv1a3gNggFx1vD96
         QVzw==
X-Gm-Message-State: AOJu0YwaaRYRP4DSMx6HNeTyjWhx97Q9J1tGJbXJ6EVe21sPuTGm7GDJ
	96HeszigmLF5FDVhO+xym8LcwIs5VMDoQgVuIc4=
X-Google-Smtp-Source: AGHT+IEBOh6Kxs5XCz2qxaq07KONacDt2XrcYVBZCOqbDBAqwzuBDHZT68usZj3tTtyEsj5BjBdv/1xkGWJi1KgLK9Q=
X-Received: by 2002:a25:4104:0:b0:d9c:a920:9ae1 with SMTP id
 o4-20020a254104000000b00d9ca9209ae1mr9492149yba.32.1698729006592; Mon, 30 Oct
 2023 22:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
 <ZS2qZtYDvItovjqg@tapette.crustytoothpaste.net> <CAGP6PO+SeZPzD21nErX=Vq=+d6oy-kg+diu=irot3enOhpQNMg@mail.gmail.com>
 <ZUAk6dPJyhfb7UBM@nand.local>
In-Reply-To: <ZUAk6dPJyhfb7UBM@nand.local>
From: Hongyi Zhao <hongyi.zhao@gmail.com>
Date: Tue, 31 Oct 2023 13:09:55 +0800
Message-ID: <CAGP6POK2yABRhJHQYfOFZ2h6BSy9XU6aZbnBaA11TJiEnBAa6g@mail.gmail.com>
Subject: Re: Method for Calculating Statistics of Developer Contribution to a
 Specified Branch.
To: Taylor Blau <me@ttaylorr.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 5:49=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Oct 17, 2023 at 07:37:46PM +0800, Hongyi Zhao wrote:
> > I want to calculate a certain developer's contribution based on
> > different standards of code line count and the importance of the code.
>
> I agree with brian that "number of lines added/removed" is not a perfect
> measure of productivity ;-).
>
> But I think that there is a slightly cleaner way to compute the result
> you're after, like so:
>
>     git rev-list --author=3D"$who" origin/main |
>     git diff-tree --stdin -r --numstat --no-commit-id |
>     awk '{ s +=3D $1 + $2 } END { print s }'

See below:

werner@X10DAi:~/Public/repo/github.com/OrderN/CONQUEST-release.git$
git log --author=3D"JianboLin" --stat --summary origin/f-mlff | awk 'NF
=3D=3D4 && $2 =3D=3D"|" && $3 ~/[0-9]+/ && $4 ~/[+-]+|[+]+|[-]+/ {s+=3D$3} =
END
{print s}'
8519
werner@X10DAi:~/Public/repo/github.com/OrderN/CONQUEST-release.git$
git rev-list --author=3D"JianboLin" origin/f-mlff |     git diff-tree
--stdin -r --numstat --no-commit-id |     awk '{ s +=3D $1 + $2 } END {
print s }'
8519

So, your method and my original one give exactly the same result.
Therefore, I can't see what their fundamental difference is.

> Thanks,
> Taylor

Regards,
Zhao
