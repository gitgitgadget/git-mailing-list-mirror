Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809F18630
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQSlm+xH"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5CE10E
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 14:19:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso2632528a12.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698873554; x=1699478354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGBXyWR1KZa5tTkJIfHkyPptb/CL45DM5m4xBrDnXu4=;
        b=TQSlm+xHi48DQySW3sd9Az9GHG6mHHymq+IY/Kv7b4QC07V1AUslWhqLz+x/Np2nGu
         Vf+vsXIVJcQxkeAW2bJfuzlbboBhIpz00rvJGbfevFPpnuV6fXW7cka6UgB66PijZ6Bj
         LZLGU+Ytd/pFbpOCXJfKtpvdyMbSLS1bHRCVrim7gJGcEPfS2IMdtvNdJ+fWDThOPVfM
         qPiHinMzBqprFmowlU56fB+221Z3fGnhvSjvBnGR9GGTit4Z8g0vOiBs46kEM2Qq5yDG
         kzD897FxOXT6O6WIH91MZBQuH6s6B46Abg65I7dl4+sTqKqdG3v7K/n3Z+JqNIIsHzx8
         1t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698873554; x=1699478354;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGBXyWR1KZa5tTkJIfHkyPptb/CL45DM5m4xBrDnXu4=;
        b=O/lSXEDrtOY2D6NtYt3FNTELCpepq3JTKrXuzv8Ma8IyfvgDtrkRD02P46f3yjrsvZ
         36e/9fyR4LoehvW7D8xlpRy3TI/frHVe2Ygq8lOjLhpwUWbrb79UW//IkAgnxQCS+0pV
         8W694zHGz1ljuCHZ2Mt4H8MHlt4qUrmUcCb5IxlPEI4zRpF9cHE69kQEcReCtWoyhKuU
         ss6ouMb5wthTrUdiXw6ZnCJnTVwkjuB3MvVU1+WAf3iQ7brwW2JYsYwJTKiEH6soLiiz
         ja1d1ZCVeg/7Vbd+SqYoB/EiUTEE1vN4FXaoO2b/BmA1dLfXp+PjsRGalUhPPRvDq8o2
         jRcw==
X-Gm-Message-State: AOJu0Yz9VCdYVjeak5VjQ036xcJzpGWJenFJJxuYViYg26yb6ykPIRaM
	/EtPLgq2ybPeNJfnVL08hPWsToNhRk/EeIyHFul/H6QBWYs=
X-Google-Smtp-Source: AGHT+IHNvpipzc1GMRJ3sPwqfHSHCBNQ3Fi/KP0yB/MLCnFG4sfGQhCNr8kgt6h2Hc/zvwMTLcY3Tvz/PzaCKm8rr2g=
X-Received: by 2002:a05:6402:1bd9:b0:51e:5bd5:fe7e with SMTP id
 ch25-20020a0564021bd900b0051e5bd5fe7emr3024606edb.17.1698873554393; Wed, 01
 Nov 2023 14:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 1 Nov 2023 22:19:02 +0100
Message-ID: <CAP8UFD3npkXXzjMLQRpxM7eKQQozMmfbLJKGeXuG_ZAbbVY0-A@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 104
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	lwn@lwn.net, Bruno Brito <bruno@git-tower.com>, Adam Johnson <me@adamj.eu>, 
	Sven Strickroth <email@cs-ware.de>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The 104th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/10/31/edition-104/

Thanks a lot to Bruno Brito, Adam Johnson and Sven Strickroth who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/670
