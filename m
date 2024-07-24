Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5C13BAEE
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857197; cv=none; b=qI5VaCnkaXCl/N5A8fpl83L41wbvLDru0wByn25bZlZx7SGPXD2NXvzCUVSbcjCp5oUX9RX8RvWT1Nddn2HGUYAt0BbNzy0wApUmtb18k5YQzJF0fR9EoyWIbxbedUBM31jL+BRuM+LELDusxl+fi185f0pTN1mvbL64BnS8Ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857197; c=relaxed/simple;
	bh=1f7jaXhBGgdWltDUhXUsZapHg5LeP7pvTHtET5TsFNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB14m97fNn4ktDIzVRstmzBIJowvKpwO3LFsUnY1TwXUvCrhlpZVsB62o3QT+Ox5nNe/XUw2YaHYdadV/Gq6G7IcJXxLueItIN3bz2P+lsWr2X1cw+YgIo90yS0CgCB3W0wGqm/y0VjEaESM+/Jau6exEl/5Dvb9sUl2s+L3MB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso201133276.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721857194; x=1722461994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju3Ic3r3GIbK4UV4927ci9x5rWCTYWzJZ1supTEB/I8=;
        b=JAqSrlaez97nULTktByWZWPRp3NZt2R9fY9hHPwvSh3F0Rnokpm9yCru045JXugHP0
         pSLV7d1W4iLbYLAIRy6CjGODE6lGX2SDDTzq/cVMiHt4RL/otZLjMjjerMQmUh+NGLDp
         qZu6HwgZ0XFodugdoLcKgKzcLRgb5+CY1WxZXlwTvvnMr0UVEy3P7icmTBVdS52v3Cyf
         mfJpGqZU9yko1wD5jHqU3DrLYD0VRJfxURgIErf/I/zKto38kpuaaLc9ODKgDE70v9Hb
         z07QXZAYot8e1r0gKS4VL7XnHZzs95xdD7t+qCMNU2BFNlWLweyTwScXdR8eyZme+pnz
         CWsA==
X-Gm-Message-State: AOJu0YzjWG2wO9up/hHS7q9iGLkLZ7xpxQaGTDMnG539FyLfswDdSI8o
	Zz8xCHW0dZzbzlzVyxP2+2tvUifamiM5Obi0EDqfplOJfl3ly1YiW3lHLZlOFAs7c+7vf1fz6qi
	jFNUcYOvpAa6uRlqJmIrwpLpAU0I=
X-Google-Smtp-Source: AGHT+IFu7UEcMrc5rzwvvNPeLiiSiDrfICjuNL9lbgsEw4+ue30SOx5cCY2SXxNBpgCRRVkmXZDV91nAXK2dN90ZS9c=
X-Received: by 2002:a05:6902:240e:b0:e05:600a:2b69 with SMTP id
 3f1490d57ef6-e0b232de63amr876544276.50.1721857194491; Wed, 24 Jul 2024
 14:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqsevysdaa.fsf@gitster.g>
In-Reply-To: <xmqqsevysdaa.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 24 Jul 2024 17:39:43 -0400
Message-ID: <CAPig+cTmWVXXXTay9TrAP4LkLB44eqTh-e2Wx5wo-k1wFR6dOg@mail.gmail.com>
Subject: Re: [PATCH] ReviewingGuidelines: encourage positive reviews more
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 5:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Let's add a few paragraphs to encourage positive reviews, which is a
> bit harder to give than a review to point out things to improve.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git c/Documentation/ReviewingGuidelines.txt w/Documentation/Review=
ingGuidelines.txt
> @@ -72,12 +72,29 @@ guidance, and concrete tips for interacting with patc=
hes on the mailing list.
> +- Do not hesitate to give positive reviews on a series from your
> +  work coleague.  If your positive review is written well, it will

s/coleague/colleague/

> +  not make you look as if you two are representing corporate
> +  interest on a series that is otherwise uninteresting to other
> +  community members.
