Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAB495D1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8Hxr2Mk"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d05ebe642so7692205e9.0
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703110171; x=1703714971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyojf0RNedOZImbLPjfFonvSgf3yQ8zbtyDsiR0kiII=;
        b=C8Hxr2MkJZQl6vnK4gBEy9xO17We75EtJUdOBf4xMw1dMsHacQnbfxdtkqKkHKpVZ2
         NA7yDkFNc3h5eOUAHb2SAxXQrHiLuYXYljq5PiWX6IA1NaSmGHbBlNbj+tQuCmYbLCuR
         nnq/X8EHytmz6iXGFFlB4kuAKyJXiyncrtfzDJkuEv4oq6Q0oi9TJYNC6bF3pnDJE8HJ
         uq8vzIDReaZbJzKx80o2sksY9qD53mVsxrA68qnIlxGRuDQyhIg7qsd5UQbh3JLFGWWU
         8B4ROuyWQYnJPC7IcU/Ur6Wf7jk3fG2WZGxU2M2H2J7Lhqwzs8nw0iTJMqFwMoCid8mh
         Fg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110171; x=1703714971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyojf0RNedOZImbLPjfFonvSgf3yQ8zbtyDsiR0kiII=;
        b=KdmPsEpDHERL0DQais5rNfJleXiqDYnSuucOXO6Iy4JkpDmhd1g5VUzWqoc3EF9miC
         9ejyd3Kb8ovnSMO0wuSZHB+RsZpXvbsD6v3LP6m2lmdS15AaXa5njKcswWCfmxJ82l1C
         +uimM+YmQBKCBnrdR/13ScppnefujBkwcPb4rL3vhRULpokdefZ1r5nw5ISyx3lRkLQ/
         vdL3DVbnsTYPkFhfuZArjAylEciobuIfp+/xOrtaeSTijDCgHILs3GPwJ3A5KME+f0rn
         D1oaJgypd7mbpMFFsTnLrL9eTUKxO13EkHhe+fJtugw4IAEJtfXoHxbyGayJ/9/N2MLF
         5NLA==
X-Gm-Message-State: AOJu0YzO1wV966douHghmFvZbjAwbdA1AFLyorLaZsIq7Cu3Jj/vSrza
	uLI3ovUgr+D0vPd5QHQU2xI=
X-Google-Smtp-Source: AGHT+IHEaXileXOPckACR5WLPTObq+bh7b/dbCAuurO0mPnWXaAwQaoD633gWtFR0tqQdrDoHnyrJA==
X-Received: by 2002:a05:600c:4b0f:b0:40d:34ec:880c with SMTP id i15-20020a05600c4b0f00b0040d34ec880cmr153548wmp.103.1703110170963;
        Wed, 20 Dec 2023 14:09:30 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id be8-20020a05600c1e8800b0040b397787d3sm9138755wmb.24.2023.12.20.14.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 14:09:30 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	l.s.r@web.de,
	mi.al.lohmann@gmail.com,
	mial.lohmann@gmail.com,
	newren@gmail.com
Subject: Re: [PATCH v3 1/2] Documentation/git-merge.txt: fix reference to synopsis
Date: Wed, 20 Dec 2023 23:09:23 +0100
Message-Id: <20231220220923.19243-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqmsu4r1t2.fsf@gitster.g>
References: <xmqqmsu4r1t2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Ah, sorry about the misunderstanding.  Will apply.  Thanks.

No need to be sorry - my wording was ambiguous.
Thank you for your patience with me! I hope it will get smoother for all
of you the more experience I get...
