Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txb7B3t0"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1FBD44
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 21:46:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0a7b72203so4645455ad.2
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 21:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701927995; x=1702532795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tecPFIuyo75WzVjmFwPZZaDfcurW61mcr1tAZUXim4s=;
        b=Txb7B3t0QT0DxXK9cMJ4/d/PgaqcB05JHR/eSX5A1oe1AL9UmDVZOYjgC4gXisKbnE
         e+fyGVkVUP/Es6nPO2xmDW9QS7+8b4UOouFAaJ3YJ/xYMtkDLeVtx6XLjeJFvYZsKbAq
         sG9pjI0ykeXp4rm5662w+ifn0ObhBxrytoN+PiPaupS0MqWJNb0MuQsvXJDmeZ55VIqO
         31QBtjABmvr6hqi8q1XmZgabtzI82tP2go8dBLDAtzVYhExw9ka2ldg/bYFsdhqrCP3V
         7/fW5vCGdB1CSQe5Gt85BWGw6VTGT67s+emxmzxQAuw34NiILajjskUveoqhVf7vHgOD
         G27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927995; x=1702532795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tecPFIuyo75WzVjmFwPZZaDfcurW61mcr1tAZUXim4s=;
        b=CVl8DiKbGLNQd/siBQqRkXpDQbs2RmdWQxE0NOaF33d1tmdAM3Qeo7MVFHWIwtlQw5
         baDnmlRtuED6WTNwWuhDnhpjwZO2/mgBRHe3YEl+NemGajS653iNeV3cW2XihXzXsX2S
         LCdGRw2L2vXA5lxZkgByn4SrpRkl5h0/PfvOA0mJyYkXj+hKi4EYcfqndT1SbEQfQfse
         hwBdqtFUpN3xYIg3S5JM6JXg7ZfZrinoXvPR/hX6Jrf/kjfftQ5jiZqRGE7iyCjE1/6T
         tc+XKf2S3KhqqFY+b12WO4QAmsYfcYZiiBixxEwcJ2Nba7kGT7bqXBp2mAomJsbQHWhN
         Vg7g==
X-Gm-Message-State: AOJu0Ywu1yOs14Fl4yQF8R17CTYO45GUiXQTe/d+qUl/C4tkD1f0coQ4
	8dOkXukatPWZM/qwI2FhgIEIBcDqqHE=
X-Google-Smtp-Source: AGHT+IFK0LFPMHSkpYa1pb4RQUjkmYrIQMT4waQxIdF9/8bOewlYxxBO5kJTxdj5u5RNK7sNT9eI6Q==
X-Received: by 2002:a17:902:8f98:b0:1d0:7c58:33df with SMTP id z24-20020a1709028f9800b001d07c5833dfmr1641083plo.80.1701927995261;
        Wed, 06 Dec 2023 21:46:35 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902d89700b001cf5654fc29sm428209plz.72.2023.12.06.21.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Dec 2023 21:46:34 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH 0/1] MyFirstContribution: configure shallow threads for git format-patch
Date: Wed,  6 Dec 2023 21:46:25 -0800
Message-ID: <20231207054626.30051-1-stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents the preference for using shallow threads and how
to configure a project to use them.

Stan Hu (1):
  MyFirstContribution: configure shallow threads for git format-patch

 Documentation/MyFirstContribution.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.42.0

