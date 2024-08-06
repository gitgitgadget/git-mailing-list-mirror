Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42B44C6F
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 03:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913336; cv=none; b=bPQNU76f7B6dnqC5OODxS1rPSw9ghwCeQYF+ovKBuiii1TUhPPr/UPmojIzE+Em/pwxDJPMolY8Bn7uJzx6WCLUHdSBY7gBddZFzmzSRGIYr77qkgmQ3nZaGB9CYGTJlDNZLLLYQPYK/V57rrOtBTt33ZUyLjS2tBGVs0R54HFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913336; c=relaxed/simple;
	bh=xhiANiyo7uBLmrvFqoOWObREQ6Khz8RfCRC4msVMCrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjDHtqUF4kdNllG7B3/jSliYFCmTLmjWUMG/cpEhp0rle9y5tzx8oT4RqvgT73NKAk3ahnaLt6u05EbGwAjy+FGfW9Ol1DMzt1momQbiGSl6rsnD89N1VK4vZTwN9gqnH69dDEu8gcRLRjrEeei5Jmjzmz5XAbyUvDMAwjseUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5f46191b5so1070866d6.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 20:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913332; x=1723518132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAVEuEg8Mjf85d5f9cYPkkrhoYwF9iQjqT/gdV4bK08=;
        b=Zfvg+ttiEK7CCLBeM/30U8d0iJglou+r7Q1VDxhi3fPr3EKoy5EmjuSW8ngTw+WnYW
         4Nv8V0I9lUOCFwyhFlG7DmkEtJ+fa8iusc737j/d10OrYb0BaWzFl3cqqsRjMrjxaZyU
         x0iWYQZtxAhX6AeuwAqXThSSdstgYifH1j3FUudYC9iV++R9u3A4i9bkqDIyadmneVqc
         kavCxDMe5GxhJXmihbWGzEILDH8Q5OrIAdPKlj0TQpJoe92U1go41wfXTJx8WTSsXpU6
         9habSLBgqiaprYQ3m657b4EIoucxa0VdObvPIiLqu7qvCDG34jc/Kv1XvK8jAFZlsmom
         by2Q==
X-Gm-Message-State: AOJu0YyUvWysEY7kBWPDLB/xrew1aHCFojmQemCA/40pdpqmfAQ3SmiD
	4wi8D0sXvvOi88UjPWbzrI7LkD9pp8P9pY4H+aezdmB8wvyxZQqvXdiiDHEPX6NUcpB81S8Xdpy
	NOMxU4kkKqNuQh5yVJrl9ATibyFs=
X-Google-Smtp-Source: AGHT+IGnURTbf+SjeXOBFWQO352wh+y+Ar54HXWqQwIiBVzy21FbFjGI8Un8G6P7pWXoFC9Okq+7K7XUv1vsKg+1UnE=
X-Received: by 2002:a05:6214:3a08:b0:6b7:9bdd:c5ac with SMTP id
 6a1803df08f44-6bb9845d291mr159163356d6.54.1722913332505; Mon, 05 Aug 2024
 20:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805235917.190699-1-abdobngad@gmail.com> <20240805235917.190699-9-abdobngad@gmail.com>
In-Reply-To: <20240805235917.190699-9-abdobngad@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 Aug 2024 23:02:01 -0400
Message-ID: <CAPig+cSzq+6bua=T7w0M-+7+2zbzfD6ihXLkWfondZ8NbqUG4A@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] [Newcomer] t7004: Use single quotes instead of
 double quotes
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:00=E2=80=AFPM AbdAlRahman Gad <abdobngad@gmail.com=
> wrote:
> Some test bodies and test description are surrounded with double
> quotes instead of single quotes, violating our coding style.
>
> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
> ---
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -1585,7 +1585,7 @@ test_expect_success 'creating third commit without =
tag' '
> -test_expect_success 'checking that first commit is in all tags (hash)' "
> +test_expect_success 'checking that first commit is in all tags (hash)' '
>         hash3=3D$(git rev-parse HEAD) &&
>         ...
>         git tag -l --contains $hash1 v* >actual &&
>         test_cmp expected actual
> -"
> +'

We need to exercise a bit of caution when making this sort of change
because a "..." string differs from a '...' string in shell. For
instance, in a "..." string, interpolation occurs as the string is
scanned by the shell, whereas a '...' string is taken as a literal.
Thus, in the above, when it was using a double-quoted string,
expressions such as `$(git rev-parse HEAD)` and `$hash1` were being
evaluated and interpolated into the string _before_ the
test_expect_success() function is even called. On the other hand, with
a single-quoted string, those expression do not get evaluated when the
string is scanned, thus remain as-is when passed to
test_expect_success() as an argument, and they are evaluated only
later when test_expect_success() invokes `eval` on that argument.
Depending upon the situation, this difference in evaluation context
may have a significant impact.

As a practical example, consider a test with a body like this:

    echo nothing >nothing &&
    git add nothing &&
    git commit -m nothing &&
    hash=3D$(git rev-parse HEAD) &&
    ...

If this body is inside a double-quoted string, then `$(git rev-parse
HEAD)` will be evaluated and its value assigned to `hash` _before_
test_expect_success() is called, thus also before the `git commit`
command inside the test body (which is almost certainly not what the
author intended). On the other hand, inside a single-quoted string,
`$(git rev-parse HEAD)` will be evaluated only once
test_expect_success() runs the test body, meaning `$(git rev-parse
HEAD)` will correctly be evaluated _after_ `git commit`. Hence, `hash`
will have a different value depending upon whether single- or
double-quotes are used.

Having said all that, in this case, you seem to have lucked out and
nothing broke by changing the double-quotes to single-quotes around
the test bodies.

However...

> @@ -1800,16 +1800,16 @@ test_expect_success 'mixing incompatibles modes a=
nd options is forbidden' '
>  for option in --contains --with --no-contains --without --merged --no-me=
rged --points-at
>  do
> -       test_expect_success "mixing incompatible modes with $option is fo=
rbidden" "
> +       test_expect_success 'mixing incompatible modes with $option is fo=
rbidden' '
>                 test_must_fail git tag -d $option HEAD &&
>                 test_must_fail git tag -d $option HEAD some-tag &&
>                 test_must_fail git tag -v $option HEAD
> -       "
> -       test_expect_success "Doing 'git tag --list-like $option <commit> =
<pattern> is permitted" "
> +       '
> +       test_expect_success 'Doing "git tag --list-like $option <commit> =
<pattern> is permitted' '
>                 git tag -n $option HEAD HEAD &&
>                 git tag $option HEAD HEAD &&
>                 git tag $option
> -       "
> +       '
>  done

... changing the double-quotes to single-quotes for the test _titles_
in these instances is actively wrong. In this case, we _want_
interpolation of `$option` to happen in the title string so that the
output looks like this:

    ok 167 - mixing incompatible modes with --contains is forbidden
    ok 169 - mixing incompatible modes with --with is forbidden
    ok 171 - mixing incompatible modes with --no-contains is forbidden

By changing the title to use single-quotes, you suppress interpolation
of `$option`, with the result that the displayed titles become rather
useless:

    ok 167 - mixing incompatible modes with $option is forbidden
    ok 169 - mixing incompatible modes with $option is forbidden
    ok 171 - mixing incompatible modes with $option is forbidden
