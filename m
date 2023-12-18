Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD551EB24
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b9efed2e6fso2867136b6e.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 10:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925764; x=1703530564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cacg9aDhlbg7ijasRhZGBBTWq6lmAIVBurfbWDw9AT0=;
        b=FSiGLS2chm2VkqVW4x8J/kPrSQ9GprgD7S+dyqJkYTtIu2zuUEya5H5zR5wJtYYrMH
         h6SukHLAeFKKeEobCRvEKbQWqUR8Exhh6Arftxds6ki8BgR1dsciwua3ly/3I4ZEJ2Fk
         Kdcm9QSvsTWvU35DJaXsLI89gZQZGsPv+zFkouPlQLzYTWEisnJYujPlZJ9o0jN2dgmh
         tISfbJ0qablIhN5af1IhR8ow/ZJ/PgjbNZajfVrhk2ZNrTGDNGtxDXE0GoKy4ESIxseK
         eMLEVGU463teXu6y9XJv0Wp6fRSWj8yFUUHeVllnhA6O4RVyqmdm+IozFXgdfDeLKX5Y
         VU3w==
X-Gm-Message-State: AOJu0YxapK0ycfuO05dcqkd4qiiOQ9FNMqBXnJcA/KZoiLXtd6LiUqBF
	id2spnCROUOhRioGo3tucenKItxE/Eak1TXeMZuNc5jR
X-Google-Smtp-Source: AGHT+IEiibKnF9Rajx2KY0/js6hBovwQy5ypGFlwcFlDAAuNJF2WfHM5klfLJPQiwOBvDgeo161J2I4D1f3i+J9PKgw=
X-Received: by 2002:a05:6808:3c43:b0:3ba:989:c342 with SMTP id
 gl3-20020a0568083c4300b003ba0989c342mr20556592oib.14.1702925764544; Mon, 18
 Dec 2023 10:56:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>
 <20231217153140.1831-1-shreyanshpaliwalcmsmn@gmail.com> <CAPig+cSJ=RcJtYKzT0Kj1-0nJT0YxA=KPYV=5H80_inJYS_Vnw@mail.gmail.com>
 <xmqqjzpbh3kq.fsf@gitster.g> <xmqqh6kfe4am.fsf@gitster.g>
In-Reply-To: <xmqqh6kfe4am.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 18 Dec 2023 13:55:53 -0500
Message-ID: <CAPig+cTXyfuuY17NmsfDO_5VpeMgXLpqf-Me8wtNs0nCgOW0jA@mail.gmail.com>
Subject: Re: [PATCH v2] test-lib-functions.sh: fix test_grep fail message wording
To: Junio C Hamano <gitster@pobox.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org, 
	five231003@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 1:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Here is the version I queued.
>
> --- >8 ---
> From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> Date: Sun, 3 Dec 2023 22:47:59 +0530
> Subject: [PATCH] test-lib-functions.sh: fix test_grep fail message wordin=
g
>
> In the recent commit 2e87fca189 (test framework: further deprecate
> test_i18ngrep, 2023-10-31), the test_i18ngrep function was
> deprecated, and all the callers were updated to call the test_grep
> function instead.  But test_grep inherited an error message that
> still refers to test_i18ngrep by mistake.  Correct it so that a
> broken call to the test_grep will identify itself as such.

This rewritten commit message gets directly to the point without
wasted words, making the purpose of the patch, and its justification,
easier to understand on first read. Nicely done.

> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
