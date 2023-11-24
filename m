Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGCJtH9d"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AA2D53
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:20:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso2059402e87.0
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700796041; x=1701400841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/A/h/Dos6Pc10ddEMGoVNnojM6+b3o0y6NbP58McesM=;
        b=FGCJtH9du5M3TiirP8iPwjf9YsDung35O04IhP2Z0PeMyONAgryTjWCIc6fanud/nC
         g8XKr/nLslT3kD2F7oLKJqrVBvDeGf1kn9cTiy4YYFU2YHI07mM27PqOuxdpBrMKeCFb
         cUbDn1AqKloM+lIEjtbnzaatzqMIDdF7B240KN1JCwD989frRgGRoFI2AUFF8mCtT2vV
         OyqC8gQnPridNNZEXev9ijeVNvK9WlTjjJ56fAgTdICqiCqsAN2qP+Hwd6pRrGCjeKMo
         K1MbdgopU1X5qWrzZmFPhe8+bla8xw1z237r4st4NwgWAm5y2LFbwy+fby673ybH1ACJ
         KObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700796041; x=1701400841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/A/h/Dos6Pc10ddEMGoVNnojM6+b3o0y6NbP58McesM=;
        b=oHLQTXgmT1Xtg1V/GYLCZd++3wRzf3kIP/P8vPsVuZqPJkI5yRU4gJPd5BHUkReDdr
         ZzKaug3jBhGVf+a19mQjVAgTWf3Y54YhKvPaPE6/vL1PKuFQE14tzgn0dJh02W6HRw2U
         CF62NFkWwLjZyNXxiunM7oNOEIEMaEUqshbNxuO15A8NXl6KdNzq6WEyVSnEe3ZciAYU
         XDVZYSYmgVE95YvbIrR0f8KnOma5zwO8fxmYqFcaomvBD7e78s0IiSToTVGddyeE3sOz
         pQrrPWRzjOTwO6lk2NmYHGN+qb1C2aatrqCbYjOHQybceCKjY3OVdP/HtoyXRF61YU+L
         wB/w==
X-Gm-Message-State: AOJu0Yxn/hObdoLf2vD2B8/4SNUjlk+o60o+iaX/rLzfwhtdPfBMmV1X
	s62Egbq5W/vCKqktyv/wnCOEZfIVTAbgbIPyQP4PC5J1WIc=
X-Google-Smtp-Source: AGHT+IFofCx5tbJTykcIJzt1eWNOrtGc6k+3QQAeXW+b+6yYMHbJI/DMDAYzdXKLsoiNy8SmMvH2uuqJGcb+DlcHT94=
X-Received: by 2002:ac2:4156:0:b0:509:471e:f111 with SMTP id
 c22-20020ac24156000000b00509471ef111mr606470lfi.57.1700796041221; Thu, 23 Nov
 2023 19:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> <80eb5da8ed45af4306e7bb28403e31e285efb3a9.1695553042.git.gitgitgadget@gmail.com>
 <CABPp-BF4dEaa_Ha4uwzVi3fcVKuCuWO=JLHF5RoUANoNCOfk-w@mail.gmail.com>
In-Reply-To: <CABPp-BF4dEaa_Ha4uwzVi3fcVKuCuWO=JLHF5RoUANoNCOfk-w@mail.gmail.com>
From: Josh Soref <jsoref@gmail.com>
Date: Thu, 23 Nov 2023 22:20:29 -0500
Message-ID: <CACZqfqDYrsvE5RMFTosjC+T-vGB+5GkwuVWGbeNTxqpvihxv7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] doc: update links to current pages
To: Elijah Newren <newren@gmail.com>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Elijah Newren wrote:
> > It's somewhat traditional to respect sites' self-identification.
>
> I don't understand this comment; was it meant for patch 1?

I'm trying to say that these sites tend to redirect to these forms as
opposed to the previous forms.

It applies to both commits.

The reason to retain two distinct commits is that ideally the https
only commit should be easier to review as it's generally just adding
an `s` (in one case I've added a trailing `/` before a `.` that was
used to end a sentence and which would result in a broken link if a
user clicked on it...).

> Ah, you did fix the http/https thing for json, you just moved it to
> patch 2 because you also added the 'www.'.  Got it.

This confused too many people. I'm going to swap the order.
