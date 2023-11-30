Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWhz7IxN"
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D178D7D
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 08:57:09 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-a18b478e4e9so119641066b.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701363427; x=1701968227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJtccBgN8pDbrZDUqCHdjspH8j77n8MAVP/30uEvqQE=;
        b=NWhz7IxNqPAodwxLW9MOH2oIbekVjPVC358F+Riz4t/WV6uNfuuAGh+0D6P4av3z8C
         UTdaWoLgny0QYyYNPh0J2V0dYY4QEkq9upf91TreA5PIIlwDsSFEgQsEJlC1MzBfYQN3
         fr5ZA+le/j1EcDLcio1F3xLMw57cj2f0XeDkaslL7e/gNNSKfgaBTH6nOb2mlEABhfY5
         X15Uif2ywYft2mCFcSo5G96wFq18u9I1+57yQO/R9rggZv4zILh/Pn+lsKHr1UoYE8jM
         sTi3qD6WsgUOAmQV/fyZaIW8ct/Of2letjuvFLTeiXgAWhT+kqmNHVbQUqJf/+Kg0XJn
         EfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363427; x=1701968227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJtccBgN8pDbrZDUqCHdjspH8j77n8MAVP/30uEvqQE=;
        b=YwZBDOUUjgxKE9igIdfSEpS0IGwP2RuyErNF0KNTIhBaWbkoGx5AKs0MPEuMA6u8vZ
         fSp0IY607Z0NzuBpAaYtsqt4DY/vFpYqv1i2GlsGqpX+fTepMapnq8DZiQDBrlP6WUMB
         05dz7YdqO5ipwQjZBQH9lpUDvWcuu7FaJZ1IPk/qMvSz0rTCMh4g0AUCRclQz76G9j4X
         CzQZ2vRG2xoSfKhh55AHMNbF3sgA4Bj7H2t4b5nYlj9i8eP8tl4z2eSK7l8TtXspF+qi
         gKskMW4lhMmUSgugg1HngHoqIbR9/BSmSGYYo1rwwUhHbJeBOKTMJ/yilU9hPF8R/TtL
         SkHw==
X-Gm-Message-State: AOJu0YxyL2tOutm2JE5QFv1tk43EqCaQbY1CThunfZYo9iHFRCJ+cpXo
	8AhVlBv4VV8QJLQHckItSsl06IbAVrI1wA==
X-Google-Smtp-Source: AGHT+IHnLrIJuIJ/NyU5lrJaBUpgJyCyEBXbVp9WOWUx6x8WfRobfHkR0k+g/YP3FqB+egYNaM1RKA==
X-Received: by 2002:aa7:cf89:0:b0:54b:2a9e:3b28 with SMTP id z9-20020aa7cf89000000b0054b2a9e3b28mr6256edx.22.1701363296541;
        Thu, 30 Nov 2023 08:54:56 -0800 (PST)
Received: from localhost.localdomain ([102.244.155.37])
        by smtp.gmail.com with ESMTPSA id a20-20020a50ff14000000b0054b1360dd03sm711671edu.58.2023.11.30.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:54:56 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: Achu Luma <ach.lumap@gmail.com>
Subject: [PATCH v2 0/1] *** Avoid using Pipes ***
Date: Thu, 30 Nov 2023 17:54:28 +0100
Message-ID: <20231130165429.2595-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231003174853.1732-1-ach.lumap@gmail.com>
References: <20231003174853.1732-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

Achu Luma (1):
  t2400: avoid using pipes

 t/t2400-worktree-add.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415
-- 
2.41.0.windows.1

