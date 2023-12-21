Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A1AD21
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuiQvQjY"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e68e93be1so100207e87.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 13:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703195180; x=1703799980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7t/1olgkT0LkKmsFyDyORZ9Vtayjsvwq2lftuyFqp3w=;
        b=ZuiQvQjY3JftBMHpbaS+BJW996ozbSshEv+kpHk6WW1f2FczdUW/lVpnklNYsjAxfn
         9hHJvKzIzx40UarfCYiG4M2TozhiHVTiwFzvBzAGmsK3hmWHUQAR0+PAN+B8Qyc3F1tj
         X5PAy38GsAvvrzVPdFdLvp879FCVSCys8YIqaAIHnGqmiR63RShIEtgOyl6azwVY3yyK
         vjek1BlO4Cn+x2xuOUtUbpkYxYB2ax8J5N43G4ksnrBFYuMZzcJtBIrh3vECj0RfMoH9
         n5/v0lA1U1zaJZ8kWPcAnJNHseHVIwKNuhL9YYgADAknxiibvlSRHjxdWzWwF5P767U7
         dwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195180; x=1703799980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t/1olgkT0LkKmsFyDyORZ9Vtayjsvwq2lftuyFqp3w=;
        b=ChFxsFd2kexLKvZ2IZ1WIwiDQjZi3CK6xS8j9HfGNjddhU0nRwOhPu22aO2O7NP9nN
         6QcRolCcFuuFCvwGCo4n4JK3LLk//WFHft9JV+pjwry0o056YRegonlvUt3v5UTTLjNE
         gxTPFE3CZ25sYx5NjiAR7v3TNsMbFOIHSocWAhc0ghP0AZPKnap+fRQZLhaYL8+V4rax
         1M9cjpnAfHZEKBGFBHlHrri5kzKxCQjvQfvpDtvhrCz+8XJ1M9QkL2vHIhtVP6NIoLIy
         DuNkEf69LWJWtz/xR5WUWN9qNUHfRC9VodZKCj+V7ibxQkCEJlZi2W4us0tWW3mo/sEt
         dT5g==
X-Gm-Message-State: AOJu0YyTn+D7/LXLGr6hZjFfQzsEVOO67puby2D2qYYTpAIBxMEK4bn6
	R7tP4riKd4EzT+JutsdY/LO23yIBwqo7KT8OqzU=
X-Google-Smtp-Source: AGHT+IHj3Q1HdnbUPbUyXj77x0C/SyW4kLjnVf1Ya1D3nwLu3vwtha7NjetWX/MZAHkU9iuyKaj6GIoNxqeIzkpRs5c=
X-Received: by 2002:a05:6512:14a:b0:50e:4214:10d3 with SMTP id
 m10-20020a056512014a00b0050e421410d3mr149219lfo.69.1703195179768; Thu, 21 Dec
 2023 13:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com> <c0db8336e519cb43767effbe842dc8b97f914a4b.1703176866.git.gitgitgadget@gmail.com>
 <xmqqplyzl1e8.fsf@gitster.g>
In-Reply-To: <xmqqplyzl1e8.fsf@gitster.g>
From: Josh Soref <jsoref@gmail.com>
Date: Thu, 21 Dec 2023 16:46:08 -0500
Message-ID: <CACZqfqAtT_M8T3AxbgZrkgi3GtQ=JZLu4wvh3O0C9dFvCU3rWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] CodingGuidelines: write punctuation marks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano wrote:
> Nobody seems to have commented on this step in the previous round,
> but I do not understand what you mean by ...
>
> > From: Josh Soref <jsoref@gmail.com>
> > - Match style in Release Notes
>
> ... at all.  The patch text is fine, though.

https://github.com/gitgitgadget/git/blob/692be87cbba55e8488f805d236f2ad50483bd7d5/Documentation/RelNotes/2.43.0.txt#L221
