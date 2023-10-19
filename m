Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3EE3E00E
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQGhV1wA"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49DC106
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 14:49:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c5071165d5so2516471fa.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697752195; x=1698356995; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLkGD8HNgRHeO4owDYqkkfn6o6zV8cndKGau8wFEm5k=;
        b=OQGhV1wAJNuYBF+sC3EaFZ8tV6NAJjcu8JHNweoc2dEddLfpFILLbY7m5mbZn6JKfs
         2a9OVKJvGxrr1n9SbJ2IkR7Adj+ZT0gOzGVKvAhFxgFlINlf1V8YIvML9oMr25fpkTql
         6JI/LcMwSz4Odc4opgCSoxhYKec078iSUxsvJ9Y/0EhHf0w++/5i6uVAqWTgbpzUuuSG
         BEZpGx14FH2Aq8ucLFYyJy3YKGWcBzOHYDdWnhHVgNjT3y7QkbQD1QD/2OdlbD5cLBV8
         dsRntl6yqaiIAEkFRoPQJkJUlkzT95jlZgjgWbtGUHW6qymRdsz5UyKecTtRkhEIawTe
         OlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752195; x=1698356995;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLkGD8HNgRHeO4owDYqkkfn6o6zV8cndKGau8wFEm5k=;
        b=vJTGDqX2Wdgt9s8aZ0wEOe4PTWwoEL7o+CZB3gw19oeJHvPbjcXGCBh77Q/ilycqdf
         YD+iEuHLbzjYLLf8p6wURWF/IVESceP54ijYhAaFiAl7EvTdFBeOf2/GYLKloSayvu1f
         JOr9jnP67JxRl0VpqD8OZLYr7Drwii/1i7Sc8JhhUzzTBzDBFmPWw6njyeZA6QKPmVqi
         rxwZzmfsHnlw66W/dv/VNS5pTifQdTpAJtBBMyoqtD8B43Vhswh5qTVtP2hvqbg6iS5i
         ewXajcj/4McFKstDJ+V2ZdOTluL6LjUYjaYU4uABeTmKIx2eF+xkUVrKEimrguHpQVPc
         FS3g==
X-Gm-Message-State: AOJu0YyF2XzGqxL6J/HYNoETQtAi2YaoJMEhAEftRQYQLbVmffFJxwmB
	jIIogbI1oHxCxG/n1Cx7SbblIHoUAwar
X-Google-Smtp-Source: AGHT+IGM0ds1rBb82LEPp7ppcy6NF7SOvSGpTBMnreFGuCdOLXcPCfNfIVbBBtysFPINmaTR/LEHPA==
X-Received: by 2002:a2e:a543:0:b0:2bf:7905:12c3 with SMTP id e3-20020a2ea543000000b002bf790512c3mr131233ljn.40.1697752195489;
        Thu, 19 Oct 2023 14:49:55 -0700 (PDT)
Received: from smtpclient.apple ([2001:8a0:578a:4a00:e5a7:d4b7:45c6:c99d])
        by smtp.gmail.com with ESMTPSA id az15-20020a05600c600f00b00406447b798bsm5425715wmb.37.2023.10.19.14.49.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2023 14:49:54 -0700 (PDT)
From: Daniel Santos <daniel.dlds@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Pulling from a linux box to a Solaris 9 OS
Message-Id: <20A47898-41F6-4E94-822C-10509EC1E3B9@gmail.com>
Date: Thu, 19 Oct 2023 22:49:53 +0100
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hello,

I have a bare repo on a linux box. I can push and pull from a modern =
macOS X.
But I also have a Solaris 9 box with a checkout of that same repo. when =
I try to pull I get the messages:

bash-2.05$ git pull
command-line: line 0: Bad configuration option: SendEnv
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

The cause maybe the =E2=80=98old-ness=E2=80=99 of solaris software.
Is there any way to get around this ?

Thanks,
Regards
Daniel Santos



