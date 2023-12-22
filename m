Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1D199A1
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLP51WFi"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-203fb334415so1060180fac.2
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703252623; x=1703857423; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXCb3GBFlUdaO6YiwtLdPva8Cnj0nh6DrPMkngzzVm8=;
        b=hLP51WFiNbqI/AMYa4g8uKLYI8K9HhEmXQkZlPg0RBVqgZu9nWM7p8szmNlEVklrCU
         3f9JnV/qDLnQkx4/11i7JFBsYOq9vERtZIKlU3sVij3666TbwPvtAxASxpyRhYAR5aSL
         9579WfYFjCzCTo3eNicxmhLJ/gKrGPWesRK3Z6uGuN/t5d7Wz4qfKwsoSjy/pekLCjMZ
         wYpvRItl1gKkLthwKG9A7Htadlg3v+B+kRXM3HgN6AOHD7JDy9U+A04EnxTaFW4Mk0vo
         iAJ5y+XRnEa8sIWMlNZdNgtsiNGLyRUxQzYnlOwNp3i0Cui6JXytN/2W7GnJvrUrGyNk
         J14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703252623; x=1703857423;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXCb3GBFlUdaO6YiwtLdPva8Cnj0nh6DrPMkngzzVm8=;
        b=VivUK9SgBykoa/gwZo1vqbLTl+rs9g41+CcavVSkDCsMuTOhowtU1PXGgjCCWD35QA
         ys4IgSG4ztMv9orlkwsy6jEJSO+BSntZMJiB/mPVKbCKbDwra4jSDQukomkHiuLhC+57
         6bnAoSuvcUFzvDBJ4m2wtKFeSPwqnRNJjXtIHy3fVjHuiD6vVjhwJg7VbuxQHHsbbA5d
         cpGFfR02tnUUmNy0G1nJfDsNVbogMkoEIk/hJ44szMe5NNuGamZK8OwewQ6/8zuAjHN0
         bTGizxO3ytMfseVjQgbNAla+QhgOPX4j1qMXGhszqhohTV4+hAooX0GYWvTZjt9+w/fl
         E3Zw==
X-Gm-Message-State: AOJu0Yyl1GqOPmAlrgpf22XyrJkkFaSxb+UmtrX7i7ANwTKv1PEDzoaF
	XaUNFs+XamekUx3PBd7Y6/ibS8VB/rg7otqxxVg=
X-Google-Smtp-Source: AGHT+IFW4t9DTmDFg5g7VjTkrvcR3DCVPz3xyXfefzDYNLIuXvZilvEsnlglX9wY++JloNjFH2QAiCwmAmMq0uMBxXE=
X-Received: by 2002:a05:6870:1494:b0:203:f9ea:2f37 with SMTP id
 k20-20020a056870149400b00203f9ea2f37mr1541601oab.25.1703252623396; Fri, 22
 Dec 2023 05:43:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Dec 2023 05:43:43 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 05:43:42 -0800
Message-ID: <CAOLa=ZR0mM_rVBa3LG-etpgYGCpiXinCZ83hcWLVeZVUhKH3UA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Introduce `refStorage` extension
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:
> Hi,
>
> this patch series introduces a new `refStorage` extension and related
> tooling. While there is only a single user-visible ref backend for now,
> this extension will eventually allow us to determine which backend shall
> be used for a repository. Furthermore, the series introduces tooling so
> that the ref storage format becomes more accessible.

Apart from small nits, the series looks good to me, thanks!
