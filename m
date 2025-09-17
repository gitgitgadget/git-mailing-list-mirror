Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645B1F5820
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095178; cv=none; b=Wt+lrpR9O5QrLB5mMRLLahPICJQ+YNulWW123jfZ+FV9Jl5LG70JVhMQu/j3BQMVrTwQIaL2rwjetgiA2uOmb1B/kzkyFKhPl0T9a69IProzj2eKTnmbizqZkZYkF7fMxTDT3ZiFr5xqHLieEr+OjVrjOsPNxUnk1YMfyxFsRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095178; c=relaxed/simple;
	bh=EhZWIka+GbZzcnYQbo9HP4aXQ2NNe5p7/D0w84lIqFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZG+PA+8u6SPbpEQWXxYpthqdJVTf/fQ1+ZmIR2PbpgXhrPiYePlrxCIgptOBffzENcediMTpNEncVtel2qb3RZr6vGlObQCTTc/Z/JsTjPHI2Fdm5XXU3hL1wEkk6zqvCgxr+zcsUB32byh1y6Nd6bpDY6Px9l/lPdT4nBxpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b494e774bfso14568181cf.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095176; x=1758699976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhZWIka+GbZzcnYQbo9HP4aXQ2NNe5p7/D0w84lIqFc=;
        b=exNh0iyUHNsKK2G8GY9DITb/qEJSx990d+3jhNJaEbkLWMCUlrp2PE3E8rI/cKMzIf
         IUs7uQxKq0wAlFZf1MDLV2oQG+XcTLsndzX1MZQVyPWIqfm2cPh57s327wRDvHuDwNYO
         GGZxZCCOCJb36tMrdH8r7IV//jgQRh1s+G+eISeP8DJSFIjCTB8ICcb4Nmu03e9gqvC2
         gefqoU89NFstU0SlDI+4inZRAVLQOKhRhX0iNk24RFMCAnrfKcaWdE8YdrPpNH/iCYjQ
         Ta5pMhHdjnUpDCmwh1+BqYnHQ8lx4HyqWSOBTzmtt1kpdrY9c18dIB0IkOut9rw6ItrN
         bVKQ==
X-Gm-Message-State: AOJu0YxOTot/1gB+cWAIbijxyEuPLcCp8yUHdGA2jZneDnMpoaxzv7hY
	+JpKGEmbVz/k/5ase5U7QQbzxjh0I83sBkLo7WjfPmH/yh1B5s+NTg/1HFfBpyeAlXff8DttFlI
	5RybV3hkXm119VnYEmMepMEVCflk5YhQ=
X-Gm-Gg: ASbGncuTZN33QivA4NxTJyP70R8VNb1E+pI/gdIV7lbh54rOHPkSDVXe+DMijdq5kAC
	AxNA08SvDV0gKrjQTQ15H9XUGkdr1sfv2ZrCbCEzbbG4k1hO5DIuBAIFiKyoYZ1tk9TwUNRk/4i
	yaLk4n3cwYoTjVdT/o6evY/+aCWRQqSgIyYYLMIwD68UTTpo9oo3U+iIOdAyCps4azedAUEsyMS
	RpcTZz3bmq4hcgaCjvqL0cuyGbWnwBbUxtai8YL
X-Google-Smtp-Source: AGHT+IF2gvSRCMJMMBD/TrpnsQlHcag2D9F/fCCFz/QeNk/hhmJbPO4lim+xSk+AvK1TylNz35LIx5B73CWslkcGwD4=
X-Received: by 2002:ac8:5e53:0:b0:4b4:9175:fd48 with SMTP id
 d75a77b69052e-4ba5fdec15cmr8981551cf.0.1758095175889; Wed, 17 Sep 2025
 00:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <7fe85f0eaca88fd3084bccff6754c57a919e7d4f.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <7fe85f0eaca88fd3084bccff6754c57a919e7d4f.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 03:46:03 -0400
X-Gm-Features: AS18NWC1LUIo0pWDvo1wJhRa0XPBJknDkGxJF2pcfqjQE7kp-3U4L5LBqgz5ZIw
Message-ID: <CAPig+cTDUM5nVbBF5L3k+Gr5xYxXdH2ungVvkQ9QVbZCqMsLHg@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] make: merge xdiff lib into libgit.a
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> make: merge xdiff lib into libgit.a
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---

Please extend the commit message to explain why this change is desirable.
