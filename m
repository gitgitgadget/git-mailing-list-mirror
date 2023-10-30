Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651520EC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="xPNTK3mn"
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAEA10C
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:31:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d10972e63eso310038966b.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1698658312; x=1699263112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fpfsfVnag+DqR2Ej8t1sn0y3D2krSg9PamWGNx9wYaU=;
        b=xPNTK3mn2IEZnLfjp2Jgj3zyWFPJYbSL/g25/6usKTWDme+FzTlX/BZing0W1vDJhU
         RsZ5u6NrBqLDsxc9b3st8lBBnyMw2IdQuX3480/zxxEKzOWF/4U/DTbXOZMHXRXCfAPd
         VPs+JI89hb7WIY8eXaP7E26Wvwj+7OwNhdLkGZIYlhy2Mt1NQdC7oVfWklWeUN/Ltn76
         JYk3MSMn05Z6obUl6bU66dpJem7V+goVAvvrh8eeY+k6CEDNoIwn8yBPyTt4jqhwdrrs
         oJ9hDIstXt8kAHqb+nyoTOLviMfBM/7S97pKvDp1a34DXeK1Vh1+R7dWNzZhAndlFykV
         ruRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698658312; x=1699263112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpfsfVnag+DqR2Ej8t1sn0y3D2krSg9PamWGNx9wYaU=;
        b=dGkIw1BvG2PkhIahDnMeL8rgb8R/jaOedTRnvYgHVD7s13JoF7Bt2bQku6jZD2sDdN
         dysGiVB9iKQZv3o5r7uaeydR6N7eLQcy5DvbtAt9+fmvdGqcY5rBcYY+9rt9pw3+ZaQz
         kP9qQ0lCVGqi/VscBQPz3GH1Fo9jp21+48EelMLoLYY7jGAUfnXmBK7rZSAv8BCIeuFn
         sLNQG0HCdyIvW9QDKvtYb037tFciXPTQalIcJe7ImsvNGV7jNdul5EXH3d9Mzg9x8zr/
         MaWgNRd1UT/foP9ajhiEsTxCLPUkepojOvCGgikS6PxhIDPzdOMDn3kpif/of3w6A5xI
         owBw==
X-Gm-Message-State: AOJu0YzF/1nPZvd47Rso7KYCqw6609Cqnc4bggYegkZHJl4Dh2HesjKQ
	FXkDAOKtwakuL0Xnt6xWZAURaiuNlyvHPQjZ4eET6cO6MhvWBX4u8grgJw==
X-Google-Smtp-Source: AGHT+IHVaGXqsZPv1FefJK/Jiwsexne7PdNx81pPSDQQwnksiGc2AV0dz0PilFgciczv2UTGfubQlTfLBGGr5BGOUpI=
X-Received: by 2002:a17:907:720f:b0:9be:4bb0:64f with SMTP id
 dr15-20020a170907720f00b009be4bb0064fmr7220726ejc.54.1698658312147; Mon, 30
 Oct 2023 02:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq1qddhtpi.fsf@gitster.g>
In-Reply-To: <xmqq1qddhtpi.fsf@gitster.g>
From: Robert Coup <robert.coup@koordinates.com>
Date: Mon, 30 Oct 2023 09:31:36 +0000
Message-ID: <CAFLLRpJCPxRMJEs5GxNuqmANn+DpuSAfGb9C94qvPuPNDdaWsA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2023, #09; Mon, 30)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

Any thoughts on picking up "upload-pack: add tracing for fetches" [1]?
It received positive feedback from Taylor and Peff, and I submitted a
v2 [2] addressing the comments that Peff has re-reviewed. Any further
comments are most welcome.

Thanks,

Rob :)

[1] https://lore.kernel.org/git/pull.1598.git.1697040242703.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com/
