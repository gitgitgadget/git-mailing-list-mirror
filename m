Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0B5C8EC
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399929; cv=none; b=oy7p7Kb11RGUxJLT6p/f0rUkVkX/nsTA2Wt68ioZ5Rb8O/1E1agYXtRUzrQdFounnzKhHnisVKU+VbAjYvXYGg/UJa2gaoQBfLwH02uJ9yJSiOBAms8owQPZZZUlT1tLvZ3Cj3tNMfgxZZBT6AdtceYETSSyhvF4UYvG6ghU3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399929; c=relaxed/simple;
	bh=RIaVeubz+DhQ5Py+QHYPxGAKRUvm3R6WW3IYDD1gmNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8DYqBh2OYVkv6GKSu/mqvlojgU4nN7zACxA6RU/Zn8KElFdFKSYwoKoROZSrPkJ1OqrFwR/Q3c/W7gTzQW9Vjky0Fknf49NVMS1D3MCU0rV9uf3B9mgoiWKf4rUsKrj/X6Cdh7rgVEortnfjkBB7fsC6DCQ/6I6K6xBgdfnB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6962a97752eso34492346d6.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399926; x=1712004726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIaVeubz+DhQ5Py+QHYPxGAKRUvm3R6WW3IYDD1gmNg=;
        b=vqGg/czzs7tIXMw3KDzQUV/TI3mXY5ZRh6YOciqzrlu0idndMxlIVyZBJo3q5ESopw
         NivcIJ8y7YE6TmBnsKnreQw25EbPziYpgmBqhvTPYR/WzArBvZNYTvNQpJZ6UbXZgIxg
         /tdRwraBiX9OjVRgaVinILBGHCsEijTmHzXbhLV7sWO2fhw9qUEbM8oVMSJsvcQW9RkN
         ltQX27j8dIkVUT5wNVxkGs2EdDG25eiGc6NVIttOrm8Reavpqkn+0HPjYRfFydIPEybj
         z8FV5JveQDcav4L6HPh0Z0zVsz++H3xY6HkDuzpmkC8QrUrgt0zvfy3K7kykjCLaBkZS
         TF6A==
X-Gm-Message-State: AOJu0YzX+IiXVFtFfacaI/PjeeC7lTO671Hvj7zkZViuW/ToO/duWxGa
	H7LG1KmW/zRB4PP5Xw3AC2M5uZsfaXbu7a0pigZWPW1aUVXYAGNV5ktresSQh36QLKMSybWGAXj
	p5aaD31RwZxijvQuydYMExBhh5rH4XmhRqTE=
X-Google-Smtp-Source: AGHT+IGaLkiYzSXb/slegpLB6ShF1d0v3CSmiaN9G/jgO1Stqk0kw4uDnXUnZosNM3HJN3V67OqKzfmSVlTjLD+cMTE=
X-Received: by 2002:a05:6214:c21:b0:696:5d0b:e0c5 with SMTP id
 a1-20020a0562140c2100b006965d0be0c5mr8585420qvd.16.1711399926488; Mon, 25 Mar
 2024 13:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
In-Reply-To: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 25 Mar 2024 16:51:55 -0400
Message-ID: <CAPig+cRLUra6RObK82nvm1S_goK8q2CXe3A7EeCFA7xqhJCdMg@mail.gmail.com>
Subject: Re: [GSoC] Microproject help
To: vk <g@vkabc.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:40=E2=80=AFAM vk <g@vkabc.me> wrote:
> For the microproject, I have looked into the lists for 2024 and it seems
> that all the projects have been taken except for `Replace a
> run_command*() call by direct calls to C functions`. However, it seems
> that the issue has been solved. The command I ran to search throughout
> the repo is `git grep 'run_command*('` and the search result returns
> run_command functions which I assume are essential.
>
> If there is any low hanging fruits that you can suggest to me for the
> microproject, that will be great. I will also be searching throughout
> the mailing list to see if there are any potential microproject to work
> on.

Searching the mailing list for "#leftoverbits"[1] can be a good way to
discover little tasks which may be suitable for a GSoC microproject.

[1]: https://lore.kernel.org/git/?q=3D%23leftoverbits
