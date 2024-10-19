Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1218872A
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 05:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729314428; cv=none; b=p2q/x+1sfNSUtH24OYwLFItgm7b6U1oUwZNjeITIm3AfZgm9jp1Sr9mAIAJ0YGSxYyzGljWI67oDNHK0yugRPJoif67ePqBNsP4EA2JhlV8bKmvLN38Gap5KsRLoAykTTKiSKQOTIgPpdXQQsxmFDHt6Yxsrk1HmD62e3KO2O6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729314428; c=relaxed/simple;
	bh=DZ4w5IQUu2GX8UvBSMUHG77zRfDV/CmxzjIErnO4FQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQy/eydrgUQUiYJskc9DMSF40XjuCQjg5qwIgBIBcO44fzvAwLE6U4L6Xybr4V/QDkBd2fWxN6VtOgEyOPCBM4Gyg8bFFxRXXg5O7ajyq2TUPXVIhokh+AI5pMr3L2pzH1ETsf/0G7zCs2yd9LHpVw3Hyuze+SdhgQdDbf7M1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe53e370eso2735016d6.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 22:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729314425; x=1729919225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZ4w5IQUu2GX8UvBSMUHG77zRfDV/CmxzjIErnO4FQE=;
        b=ngEP5bJ3BlCvrjHYQkD+Nu3EArv1iu44YZHjspZZoNQYakotMmoD4Nx8dOToQm8/NU
         5rLjOUqOXWxOgruQEEHdOm3KJT4PDTluwK3mqlmqeOep+rumJAyRN71b68HZAdW5xadl
         M2eJGS4Y/YdT5cqOg4W7TLZc5QDf9WPvoND2aXPKUMSf2bZki79C/zGnDpSL7Q+70ueK
         zy1N5RQNFPJzt+9DSdLwggUTtvp58y2nXA6rB9o0y69ROXkXBb2XyykCnkrenJvVn1BO
         tzS0wLMwLcdEuYISpK2ybl8eSCjaATNNXq/zk7f6smMrDZBI83UtOzdP2Rjn6V8d1x94
         QmkA==
X-Gm-Message-State: AOJu0YyzQArh2YaUkBOWLqs+ZRGD5FPA3GmuZwDWjWhLa3m16riqMj14
	iryRLcJPh5WtHJRYAadURjKsKiCxoHOchaRozTMUBYS5rMhjieglBKsxAF4kz0fcb1ONP1xxXCj
	yj4UbjdNmoc2Ra5vZF+0uKQbdh/zaaHwq
X-Google-Smtp-Source: AGHT+IFU7gy7elgE90gnR3QbLY+SkSrvj9jHx9Pcp1iZwptsHUnFrOKnBBNyypgf96+6lNhbtkbVIWh+vLldPr11C6c=
X-Received: by 2002:a05:6214:268e:b0:6cb:e981:d7d0 with SMTP id
 6a1803df08f44-6cde1604c77mr30964236d6.7.1729314424844; Fri, 18 Oct 2024
 22:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im> <9be0719ce1b73a82310a06edbcf5de8890fdc220.1729254070.git.ps@pks.im>
In-Reply-To: <9be0719ce1b73a82310a06edbcf5de8890fdc220.1729254070.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 19 Oct 2024 01:06:54 -0400
Message-ID: <CAPig+cTu5AQLq2XZwyX7yw6A=gJa_Z29STG8uOJ4NQheCJcT4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/15] Makefile: refactor generators to be PWD-independent
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 8:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We have multiple scripts that generate headers from other data. All of
> these scripts have the assumption built-in that they are executed in the
> current source directory, which makes them a bit unwieldy to use during
> out-of-tree builds. This makes them a bit unwieldy to use. Refactor them
> to instead take the source directory as well as the output file as
> arguments.

Duplicate "makes them a bit unwieldy to use".

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
