Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMRpsf8c"
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8710C19A3
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 08:03:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso25477111fa.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700841804; x=1701446604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IaH4Bu9frde8twj5w3cIqesi8PpNYXJGMIyU9FJfpE=;
        b=RMRpsf8c16bMKP0qgE4Q97kZGRoLX0rN9rnlR4ciaHNr5DXHy3sGV02+erPMY/gnKc
         tI4YSf7gE91mcnFvXPhth2uENEz1aChKi7KvBLF3TBK5PhU94013vsF7ZAk9izsr7vwZ
         3ssaitJcJb9Y/sdLD+7eBJlPll7VDYt/ixNlbouxDKR2/DaoZxvpumLl4Ch3YrbyiiXh
         1cEpkMYOSJMvapZK8j/PMehYBix7uoTWqaZlV2tIDJVBkpmzKYFG1BNXM7jhObp2fg3o
         3Ob01ggbwDIvpeR2auLR2bboD6H1qzAG8gO1+jOiopYCzNsLa42oIx1hYmaHglqHoatj
         NpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700841804; x=1701446604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IaH4Bu9frde8twj5w3cIqesi8PpNYXJGMIyU9FJfpE=;
        b=XDeQmoPeEvzvE+hMbu6WX3tizIH6IcQ3Mgic0/F+WbxvuX2JNseNiUhQGxKnh8Btia
         0T3NgJWEe6Qvk/SJXHwubCpl99zy3o7lVLpbyNlotuGUyur/blnIWMWfFqgwUGdcI2lu
         dfvAaxpoDpKvPUO+5w1dYvUqw7118FcGQHBbJmZ7A9KKii+kUPIgGRlm+3SfTIirB4f8
         DnUQw18ZiKGpbU5/5bm2mhpmDAVUq56xjwaW1hpdtp9WFjMxGfl3Jk4O2Jef1cT21RWj
         uvavdL+ua8y9zuu6DzqBzNaP9LSxa2bBaFGw38IGmC6CVq1WpEa1sYOHRzX8wZMvTESO
         3n1Q==
X-Gm-Message-State: AOJu0YyXDv/wnrNamf/yzbOBfcU/Yu5txZB3L8HKInAUU1SxY98mJIOI
	nzmwgk7YZ3FO3m/UR/Vx4JYAL2LkGM2RDJv/0lE=
X-Google-Smtp-Source: AGHT+IHRFQgbkcNpGPg4jgQCRSiCw+zM3iv3OYNboS6nEuuHhpz1SEdd+HpGFnGs59ANqsA3SnkkVvetT+N7j1vbgbk=
X-Received: by 2002:a2e:934f:0:b0:2c5:32b:28ea with SMTP id
 m15-20020a2e934f000000b002c5032b28eamr2372513ljh.32.1700841803142; Fri, 24
 Nov 2023 08:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
 <pull.1589.v3.git.1700796916.gitgitgadget@gmail.com> <CABPp-BGhHivx9_R6fwL--K5nTvz1sh67JDMtWG7WajxmX=56Fg@mail.gmail.com>
In-Reply-To: <CABPp-BGhHivx9_R6fwL--K5nTvz1sh67JDMtWG7WajxmX=56Fg@mail.gmail.com>
From: Josh Soref <jsoref@gmail.com>
Date: Fri, 24 Nov 2023 11:03:10 -0500
Message-ID: <CACZqfqAq0ijtYO9-1q6h2KQMyxHgLpFOg--d4c9F4xT0nMkvUg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Switch links to https
To: Elijah Newren <newren@gmail.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Elijah Newren wrote:
> As stated elsewhere, I'd be fine with using the archived link if the
> justification presented in the series for using archived links was
> consistent and mentioned both reasons for changes.  But, I think this
> series is fine to merge down as-is if you don't want to go through the
> trouble.  Especially given how long you've waited.

I'm clearly still contributing, so I can come back later and cross
that bridge...

> Anyway, I checked through every link in this series; it all looks good to me.

Let's take this as-is. Thanks for taking the time to re-check every
link, I know exactly how tedious that is :).
