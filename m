Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790176DA1
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN+P9wPZ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so2324273a12.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 13:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703195757; x=1703800557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UreGqwr5/KJy2gO1uDtPGcrXsNJ+/sNeEc+Sb+WlBJ4=;
        b=GN+P9wPZp65R8Z1AXXIGaSnTlTu6gRHGyOLsNnEeqKrGiVPaQWBkG68zihL0ylowEC
         kdbIApxg8rD05xTs/9b412bHE62Oif2CIgd0uk0ygAU2mGX/yPy+aMEs4F0CVCn/5Anx
         EKKsi9THe+VAzVFbBOQLUdWXyBHeukXxr1a6BhAgIZNskM8bhJxoG5yiTdCRamRqOD2k
         YIgBFKijyeBaglIS6/YKvdaGp4mRXnyByKjezZotiaj28jc39Yj6iu0rdkgjstwvCu6k
         Josne3pFUIQmtcbHclyrOt8Mp0OIOmF9GBjNMMP+ioereIvFOyDbteCg2XIJMqma7Qrk
         mRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195757; x=1703800557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UreGqwr5/KJy2gO1uDtPGcrXsNJ+/sNeEc+Sb+WlBJ4=;
        b=DAYjaOKYFYq9q9aUM0jyhPqV+CiqES7kA6dVgz1H/rKONbIKnRSFC86TvBOnn9tWY7
         bWPz0K2Hwv4XfIj/M8rOfA2zvoarAIyrFlvgbVxGaZW7N9laMT+LN3nMhJ/gusq+fZkW
         GUJ/A0f41eZfkzijIdDkxFgvUI+wpE5cOzpP3iD4oZB8eHRu4+HgiNUftuQVweN8LJ+9
         2hjZ4qI32iiqTTKxkIpfMHzWRVe9wUIDPfJD1j7LONiaTAFYgmvL+fo1RqJZHNcQxVON
         Nit2cQlJdeqA4g4T6Vm+ZrsP/1jrvSiW/bWZzXto793kOvGFrL7bX7FGoJoWkYqpZmIC
         8rCw==
X-Gm-Message-State: AOJu0YyZCVuZd5T8nJQu+q/MOZu5pNzdtju/pHdpDEHuoHHWxpeI5KsJ
	8sA/r7zwTLBXUddVWkF9s0DTe2MPh1+RqODKwMqfFt7kpqs=
X-Google-Smtp-Source: AGHT+IEsyds8O+caOXWGHj/hIQDiKzShXajfuoabParzb9dUHEKOAuMFJ4AVfZpiuuyyV+6H8CH31B9JBYA42SCwm78=
X-Received: by 2002:a19:ac4a:0:b0:50e:4a5d:2bce with SMTP id
 r10-20020a19ac4a000000b0050e4a5d2bcemr164209lfc.12.1703195735858; Thu, 21 Dec
 2023 13:55:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com> <8848572fe2c7432ede85e042bc2558fd8b3e8b1d.1703176866.git.gitgitgadget@gmail.com>
 <xmqq4jgbl0iz.fsf@gitster.g>
In-Reply-To: <xmqq4jgbl0iz.fsf@gitster.g>
From: Josh Soref <jsoref@gmail.com>
Date: Thu, 21 Dec 2023 16:55:24 -0500
Message-ID: <CACZqfqBWKepr7A2O8Wp_8FqD5h9=O6kQUqEjN8Z1fOdks1TYPA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] SubmittingPatches: update extra tags list
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano wrote:
> "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +. `Co-authored-by:` is used to indicate that people exchanged drafts
> > +   of a patch before submitting it.
>
> I am afraid this misses the essence of what Co-authoring means.
> You may have shared your draft as FYI to your colleagues, and they
> may have tweaked phrasing and responded with their reviews to help
> you improve _your_ work, but that may not make them your Co-authors.
>
> I think the "intent" counts more.  If people closely worked
> together, exchanging drafts and agreeing on the final version among
> themselves before submitting, with the understanding that they share
> the authorship credit/blame, they are Co-authors.

. `Co-authored-by:` is used to indicate that people collaborated on the
   contents of a patch before submitting it.

?
