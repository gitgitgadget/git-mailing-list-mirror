Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D710E7
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67ab5e015aaso23159706d6.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 16:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702860694; x=1703465494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeviBnm65PvSKcXfipz7EPXZUzn/zLdXfz1dHOxz5TQ=;
        b=Out0fHOdOd5y0XneHRbeRKBGmJb6tiWfdBpcS0um9l3trVNzcwrWUeXo+cXKwrBI+7
         mOQ9VxuwAGcvBTcLuuU1OYKgQ+9HdN3CvYlNYP8RszcPYVWTTMkUc+ZDLhq4I4o69TR5
         uyZgq8navTWOlpGVVPAxLrl6xttsRoMF5YGNFGwDDWgY8mjDiADwBYlyHqZyYJCOiP26
         Jq7IKHKBQNwrZ4tbdFP3ppHdJ+3eHfIJDvx4VSpf4ETy6HzllJ2nNhKsrel8EidW5+lT
         jA2AYgIcVmfzZI+6nNLsFTXtwkelyZthNIVUSBndoBC0Nf3snRonSRfUMmQJBpe8DxOI
         9G4w==
X-Gm-Message-State: AOJu0Ywjc8+8x4cmoZtQyrkaJvtd5v9S8cSlkM375KqaXIaFBxDKbIoG
	yDiswWyXQd1BBcUdvaVY75XPLWTKnuNZwfyLQIs=
X-Google-Smtp-Source: AGHT+IHZ3CDM1hKh8wO01tEnTrbNDwVE5D8TgRKjaD23HAS/W1OpfG2DoP6OF4/auRbTkj177fS4Dy1fgOilzyOs3iE=
X-Received: by 2002:a05:6214:f21:b0:67f:2eda:8eb6 with SMTP id
 iw1-20020a0562140f2100b0067f2eda8eb6mr4729367qvb.37.1702860694519; Sun, 17
 Dec 2023 16:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com> <20231217153140.1831-1-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20231217153140.1831-1-shreyanshpaliwalcmsmn@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 17 Dec 2023 19:51:23 -0500
Message-ID: <CAPig+cSJ=RcJtYKzT0Kj1-0nJT0YxA=KPYV=5H80_inJYS_Vnw@mail.gmail.com>
Subject: Re: [PATCH v2] test-lib-functions.sh: fix test_grep fail message wording
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, five231003@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 10:32=E2=80=AFAM Shreyansh Paliwal
<shreyanshpaliwalcmsmn@gmail.com> wrote:
> ping.

Junio was on vacation at the time[1] that this patch was submitted, so
it's quite possible that it simply got overlooked or he hasn't gotten
through the backlog of emails which accumulated while he was away. So,
pinging is indeed the correct thing to do, and the patch is obviously
an improvement, so hopefully it will be picked up soon.

[1]: https://lore.kernel.org/git/xmqq34wj4e55.fsf@gitster.g/
