Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB43C078
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D209D129
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 13:13:45 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d0169cf43so8931666d6.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 13:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698351225; x=1698956025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azz+2f0kITU+tCwFi6A63rUE+Pui1j3b+UvyIfDszYs=;
        b=F//uQlJ+RdJGz6kHUcvVnfJ6iKlobzeB9NRNasGHyTEMDIZvYCCEDcowhOoiqVbrDG
         O21eJmxbXhNphE3nBc+XvL3epqzZn1pvMSenTjsUIq/CXj31laix0fKpmLKXzNehKbGx
         gRm/e4EB3niO042X+4qg/mxRirCK+gOpf7oo+W6KrSfyIpQBffz5Gu04dZHjzJ0X/Jqh
         7x7bYG+odQqAC0aU598DtFjm3j5pO2Hf5UT18IYUknXYz6xQvJitNqoHFv3cALsQYLtZ
         Q2vu2CWQtie80RboiXng4MT5HNhkmPuNJyKo6riWyN5r+3E9CM/RnWxPETrhtxUswgHK
         IXQA==
X-Gm-Message-State: AOJu0YzdobWLOL/Do6KzHF3CV4MyH8ZRhN+cXx3KzRQUZel0MEgyAlxb
	OtvHhrGPmFSS9sM080NQ0GbkqlsxN5K6EzL5U+0=
X-Google-Smtp-Source: AGHT+IGnNRX/j8RkHo9s8uS3wETt7B8S701H0gThTlgnPVO5vhj1+etLgmFJ7CdPffY6R0fPJAScCOi+5vbE0YyWAn8=
X-Received: by 2002:a05:6214:27cb:b0:66d:f94:522d with SMTP id
 ge11-20020a05621427cb00b0066d0f94522dmr766060qvb.47.1698351224716; Thu, 26
 Oct 2023 13:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026155459.2234929-1-nasamuffin@google.com> <20231026182231.3369370-1-nasamuffin@google.com>
In-Reply-To: <20231026182231.3369370-1-nasamuffin@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 26 Oct 2023 16:13:33 -0400
Message-ID: <CAPig+cTO+EUwWGCHtpXYukafd4v3DQjq1CQ7B3EC=vqiK3qFUA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] bugreport: reject positional arguments
To: emilyshaffer@google.com
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, Sheik <sahibzone@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:22=E2=80=AFPM <emilyshaffer@google.com> wrote:
> The test I cribbed from for the newly added one in patch 2 was still
> using test_i18ngrep, and Eric mentioned us not wanting i18ngrep at all
> anymore, so I went ahead and cleaned that up as well.

Thanks for making the various tweaks in response to my review comments.
