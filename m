Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CC1BC39
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559439; cv=none; b=JlunWrGqu9FaR2KaPK/2ZJg/Q4Hs7fr62y1gLjCVYOZld2729fZiA1GUii1gZW8L18bUBp1GyitazPbq8WNtPQ3r+A/Z5Qdf0GG/cps7HSTf5vFpFKhfUg7GNNPR/HzBkRM3GhTp7V2xn0cT2TwlRU3eJrRj9YTldD5W1cnPt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559439; c=relaxed/simple;
	bh=ItDXF0eDjaHtAG/HtTbadQVhLJ0ZSDkgjOmpPNYYmjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jApOtJg+GdL/zVzQQT89t55gPBoXGlOGLpbTfZInij9kmfw/c56CGq1cfpSszzrGdZVe2LkBANZD87C+XB6TvIva70St1o6mD1G5tecMiod/fMxWyoNfxQYAo2Rj8HeeXmkFyGO25stG7g1W/9MsjHqJBcTBOAE8kMQaRUiDpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6962a97752eso30475396d6.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 23:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559436; x=1713164236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItDXF0eDjaHtAG/HtTbadQVhLJ0ZSDkgjOmpPNYYmjc=;
        b=WIxV2CjC0yApCd5079aQXJku67C/4hiRdzQ0pIDP2ZqEeSwprGeLrC2etHTKvyTljp
         d1XSPUzvb+PbHEO6Fyofa4KJUXwF30PIZ3x1RPrmAeY0s+U1RZrS9nXpSaJJBiDDKjuJ
         L3b37KLz+dmlPtYCNxj6Uqy7MF6v96MZiRTSADnyc9pS3I+trZExGEwy9yVbnh/XCtx3
         9hcs2MQqryqdvoSeJCGQcylnJqP+PZVWqCpDcsq0rXr/zh2FMUb7VhoIyF8xQ61NKBlZ
         /VbynAVEFQtjDk37Q2Z2GN1oVxRpEvWeTkLoGbfK8TdeKYgXVv8hGigV1A4f2VdLdjme
         ybgw==
X-Gm-Message-State: AOJu0Yw4O+P7E5x6EElfbLxhe2Z0jspHlm0KXUc3jNknzZWP8t/WdTup
	lBpIG7mtMvP3YJe+kkZW4nOsR32PqVZsOOmV7iG3UDEN194CCjbJQaKoCTJsdr9CcNQPS/IWstO
	nFXQjft96g1sy4cAIKmQJLIY3sng=
X-Google-Smtp-Source: AGHT+IH0CkBVIhzVzOzTC/MxIeCLJstxea5PVENEjyGadnmzjJkFrxxAIlbIXR6116DyOGbGIst8L6/ecUg5HKOEt3M=
X-Received: by 2002:a05:6214:20a8:b0:69b:1200:a8c1 with SMTP id
 8-20020a05621420a800b0069b1200a8c1mr3965961qvd.31.1712559435759; Sun, 07 Apr
 2024 23:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im> <cedf5929d1ea989cbf87bad48e35c0d191b624c3.1712555682.git.ps@pks.im>
In-Reply-To: <cedf5929d1ea989cbf87bad48e35c0d191b624c3.1712555682.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Apr 2024 02:57:04 -0400
Message-ID: <CAPig+cR2cN=oKiy4T4_Ue85VEAWXwxq_3Rh3mHuYWNx2DFv_Lw@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] t0610: fix non-portable variable assignment
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 2:47=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Older versions of the Dash shell fail to parse `local var=3Dval`
> assignments in some cases when `val` is unquoted. Such failures can be
> observed e.g. with Ubuntu 20.04 and older, which has a Dash version that
> still has this bug.
>
> Such an assignment has been introduced in t0610. The issue wasn't
> detected for a while because this test used to only run when the
> GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "refatble".
> We have dropped that requirement now though, meaning that it runs
> unconditionally, inclluding on jobs which use such older versions of
> Ubuntu.

s/refatble/reftable/
s/inclluding/including/

> We have worked around such issues in the past, e.g. in ebee5580ca
> (parallel-checkout: avoid dash local bug in tests, 2021-06-06), by
> quoting the `val` side. Apply the same fix to t0610.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
