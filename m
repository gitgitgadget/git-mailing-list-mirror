Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396D6AFAE
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962575; cv=none; b=X0WjVLpEzM8DaNGS8UUUzbjVxdXac67CC8WPAs0J/uJqjU4US9mPh7ysQpiU+HpFpGa9vghYMMRKRZdB4UphPf57qxwPeOCpjk4RbTt+KyRkwIK8NBlaNbOutE5RricwHv9xE1hKc5p+7skCAdlmZs4+EvWCjY8ENh3nXIOLfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962575; c=relaxed/simple;
	bh=nDZC+9iDv1eMJvSHDyDam8SyRd/gzoYvJ35lt2KxkNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvLJEQ+vgZphfvsEiqqerv2be3GbRpIR4yH3TnqlZeBWDHhzZ0+szQnjRfI+vxXCNp8fgS6awaNOKuyhm5kHBncQq1JghEkJrkIIKM8ktNdAmQ8lCJvalyQOPm3Asd5YcVysqfa6cvgk/RRBEVTxWYr9Ldk9Fx7HJrpHG1f/OyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6917352b3f1so1419066d6.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 12:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710962572; x=1711567372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDZC+9iDv1eMJvSHDyDam8SyRd/gzoYvJ35lt2KxkNc=;
        b=bdiEVHx/tCyTWG5k9tlVO9kRtvB3oKUOwQGvgQp5fnBnCctM8pjym7QoP0FO7B0HJ8
         /HKN5yQVjM3tzmAXL8E9oVvdPwAoV/G8MKBPNzazeL4HwBfCkoXN04HwsNIe9fvAHgCY
         jTQNjSLI18IQAu5CzyHbhcaI/8iPqaPyPpNhXvCQ+s+hecfakJVYBsDXCg+GW2jSyHMN
         LaXafyRnVQpaWIvTgYHCQCFJ/IVORSFvvJeFz26WiHzztuplgFfuU7154sLrDmSkO5Nd
         urLWYOGrPDsmNDq3UTMZFL5EC1MSa0s/lFyY/sVXkO0GSupntrehgYZmz7tRJh0ke3LP
         LKgg==
X-Gm-Message-State: AOJu0YxSLdjcSNsO2GuBem/HSTK27TySwEDLP/cRJ53X9OE3Zj81zaB6
	aoUmFjv1o3yCRvm/bFLKwdRUDPlP9SgZkw8E/j8NlI6rZmJlFxacqXs0koZUrId40Xlegrz4hp5
	eeceV6y6sitPKAjEKjMWhN2mjIs8=
X-Google-Smtp-Source: AGHT+IHdcEZuTHB9hqZD8jwzFUBsMuLMmywvdb9Kg6yZOnPCYNMmbGhkOyDfRwCmht/i+nlfwQtKOxpWrSWfSdq/daI=
X-Received: by 2002:a05:6214:b0b:b0:690:d754:284 with SMTP id
 u11-20020a0562140b0b00b00690d7540284mr18057008qvj.27.1710962572268; Wed, 20
 Mar 2024 12:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_3_ys4tAJ3B5uy1aUpzknEgQRwdADNxFXDmLxgCL2bZrg@mail.gmail.com>
 <CAN7Jk_0hKTacR4cQiYFW-dcj6ipA=8QcCGrVd7rrJ4vVUxUBKg@mail.gmail.com>
 <CAPig+cS_L=CS7TQhrt5m8M+O-OsdH0oiZkttWp9SxdbZw0Cu6Q@mail.gmail.com> <CAN7Jk_0Jhr3SvG6Sk=5BXt-W3UpSvOoenUBUZ_XieAdApoo3kQ@mail.gmail.com>
In-Reply-To: <CAN7Jk_0Jhr3SvG6Sk=5BXt-W3UpSvOoenUBUZ_XieAdApoo3kQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 20 Mar 2024 15:22:41 -0400
Message-ID: <CAPig+cTXe7cJyqp2RBjvL3FKmu7uPfAPrK+jjqGTKyGn2p2Trw@mail.gmail.com>
Subject: Re: [GSOC] Microproject: Use `test_path_is_*` functions in test scripts
To: Sanchit Jindal <sanchit1053@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:51=E2=80=AFPM Sanchit Jindal <sanchit1053@gmail.c=
om> wrote:
> I am having some trouble with the institutes firewall and `git
> send-email` due to which I am not able to send a patch email, I have
> created a PR on gitgitgadget, can I please be allowed to submit it,

Done.

Note that GitGitGadget identified a problem with your GitHub
configuration which you'll need to correct, after which you can
"/submit" the PR again.
