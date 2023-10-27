Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772C6128
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvGy4gkp"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D7E5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:12:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso3796106a12.1
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698437545; x=1699042345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnw1u8jSsBnnH/IKKbNFJwQbmN7rcyNi0JkTI387sGA=;
        b=FvGy4gkpTBeyeVjhrYMJ0cI7yHAu0EebfDgZYt1j7qCBZ79h63ugTXk8Weqxekkr9R
         n46YvbU6yA/3Poo4ikX7q6WfVmRrWNzIlhJAEQTsng7P6NhATN+Towgi/s0DFaSnhrDf
         vSRdHeMxI7nPqeB2r1ouS/FSI3HyH518BRqISV+lLG35EvvEsLo2w9pf6+xIi7mEZyrd
         CPzHwFaGPUtje+aBLxLQN86XHQAOaHJdQiKUBjFtNHREDCQqS8/hiUdih9R4qky57p9X
         JKYjEibpAIwQQ05A1KeGC5kisHbRD2kFi5XLMTPLi9u4F02yzhCq4C6feESvFIIHsZ4G
         /+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698437545; x=1699042345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnw1u8jSsBnnH/IKKbNFJwQbmN7rcyNi0JkTI387sGA=;
        b=PgBWCky51Vd9ZPr11YrxDIit34W7xNAgGmjyZ3MIZhV7FwkT3C4zPWcZSZrHa+3npi
         3NdCtjQE5SS2F2FtYZhdORUQ1NAf3D45AZo1gqBEs7MxQoUxl2MZGpNxfZFyN6IceVHY
         lXrJPpznlS0MNyxUrULr45Fc/DphW5a+Nu/rNKjI/MqiyCZlsoH3A69buloFyVkgD9cB
         i/RjoRju2P/+fo4yfAWXE3ea8JXRG+NvFN3M+qHQGf2reyIyPSSZtc2T/XvIH65dxxk0
         Wp1i70n3ee9/x8ZFEApkejiMeBIY/6lF4vJo6GK6Lnt/P9f2Y5xTCYnWsFyvuOXyWPzB
         W0MQ==
X-Gm-Message-State: AOJu0Yy+RKeZ7FdrFKKQXVREdrSoC677Piy4EQ0t51axnF9S0xM+iOr4
	IY5vL7j1/LASAvIAmtGQZRePFssZMRqyN2L3oBg=
X-Google-Smtp-Source: AGHT+IEOIrdlSFbM+VZQVT5N2rtStNKZvISD0Zi+AdZ/biBOXv1AthiSFFYJFhHXzZIz4AUKmAKeZvg54IJ2MKtJn18=
X-Received: by 2002:a50:d795:0:b0:53f:3b4:a3c5 with SMTP id
 w21-20020a50d795000000b0053f03b4a3c5mr2878099edi.22.1698437544837; Fri, 27
 Oct 2023 13:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com> <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
In-Reply-To: <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Oct 2023 22:12:12 +0200
Message-ID: <CAP8UFD26X4MPbJs4KfNOgicLMb-wiuFZj3Hw17acMmmc_=vcqQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] unit tests: Add a project plan document
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com, 
	calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 12:22=E2=80=AFAM Josh Steadmon <steadmon@google.com=
> wrote:
>
> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions). Describe what we hope to accomplish by
> implementing unit tests, and explain some open questions and milestones.
> Discuss desired features for test frameworks/harnesses, and provide a
> preliminary comparison of several different frameworks.

Nit: Not sure why the test framework comparison is "preliminary" as we
have actually selected a unit test framework and are adding it in the
next patch of the series. I understand that this was perhaps written
before the choice was made, but maybe we might want to update that
now.

> diff --git a/Documentation/technical/unit-tests.txt b/Documentation/techn=
ical/unit-tests.txt
> new file mode 100644
> index 0000000000..b7a89cc838
> --- /dev/null
> +++ b/Documentation/technical/unit-tests.txt
> @@ -0,0 +1,220 @@
> +=3D Unit Testing
> +
> +In our current testing environment, we spend a significant amount of eff=
ort
> +crafting end-to-end tests for error conditions that could easily be capt=
ured by
> +unit tests (or we simply forgo some hard-to-setup and rare error conditi=
ons).
> +Unit tests additionally provide stability to the codebase and can simpli=
fy
> +debugging through isolation. Writing unit tests in pure C, rather than w=
ith our
> +current shell/test-tool helper setup, simplifies test setup, simplifies =
passing
> +data around (no shell-isms required), and reduces testing runtime by not
> +spawning a separate process for every test invocation.
> +
> +We believe that a large body of unit tests, living alongside the existin=
g test
> +suite, will improve code quality for the Git project.

I agree with that.

> +=3D=3D Choosing a framework
> +
> +We believe the best option is to implement a custom TAP framework for th=
e Git
> +project. We use a version of the framework originally proposed in
> +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.c=
om/[1].

Nit: Logically I would think that our opinion should come after the
comparison and be backed by it.

> +=3D=3D Choosing a test harness
> +
> +During upstream discussion, it was occasionally noted that `prove` provi=
des many
> +convenient features, such as scheduling slower tests first, or re-runnin=
g
> +previously failed tests.
> +
> +While we already support the use of `prove` as a test harness for the sh=
ell
> +tests, it is not strictly required. The t/Makefile allows running shell =
tests
> +directly (though with interleaved output if parallelism is enabled). Git
> +developers who wish to use `prove` as a more advanced harness can do so =
by
> +setting DEFAULT_TEST_TARGET=3Dprove in their config.mak.
> +
> +We will follow a similar approach for unit tests: by default the test
> +executables will be run directly from the t/Makefile, but `prove` can be
> +configured with DEFAULT_UNIT_TEST_TARGET=3Dprove.

Nice that it can be used.

The rest of the file looks good.
