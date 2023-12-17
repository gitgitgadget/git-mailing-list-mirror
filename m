Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2144C7B
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtToQC4i"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso1997636b3a.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 07:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702827138; x=1703431938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6DuMh7fl/WlO/37pfbxy/TmDxynAxHbqfdESe2wpiM=;
        b=LtToQC4iS1y6J74UFwagkKYqp07NQfY1Lv0zhy+YMa5+gsekbESA8aHoZJj6EThfWu
         bz8DFTEdftyTSvGlByA/YYEZWmZTYpp/zVLpc1RDL9b7rXc4WR+dC6UA9rE7rNs+g7SF
         NcHwRwRPZRfDdTUCHuhjv0tZ4hBYgMG7yntq1JZoNlIxaS3LzN8HoDtcS0TE9RK5LcJx
         AkGIISdAM2KLZEddif07xmSQnFMtHVn8z8uZ7lSbouBwomjLToBsK2TK77e4uaoCMrgG
         GqhR/M12Bloi3JFREm4F5xvkKn5bdsvqL0Bp+0zYkEQmZSsKNuFTKJl2hMvMM0TBU8Bi
         DvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702827138; x=1703431938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6DuMh7fl/WlO/37pfbxy/TmDxynAxHbqfdESe2wpiM=;
        b=PqF0z52Q60cZ09gfFwPgzn71A4N+R5rrwaYKHrwsCZAaTeBNAnMacsggMCeoGzlr1P
         5x1B1OzrvArlruIcJu5yahSQd7bNxcy+bagiAeOzlwp46uWSBIAhNbroHcgrmsC6N7ra
         gzkkhHFXPmQbmi/n+5ShSjdyQq4JIyHlLbim4oSasUv26J2DitV65Bjka85kN6i9n3Fe
         Sw3gPLimiENq749Rd0nVLSGlXUyjznup9KLlkJIKQVn+u3p8J0DgltC3VkTHQoUvNkjn
         hhkZkVq9MBw1TOn3cQ+IQJKshQ0ER08/meOKBmcF90xYbGoxLqdUVZBFEqpCLV8Mr15G
         EYTg==
X-Gm-Message-State: AOJu0Yx1txiZIONULTLifrSm/H2zsb8j2Pb1id2n9oXdq5ZWl/CXRkSA
	MgpSxzDUzw7n/pxe493NBuen8s4qVM8=
X-Google-Smtp-Source: AGHT+IHB/UkgmeO7Y3X1Li188qoDwDlqHxLQ22QRaOPwGZrUvtAjOoL+KockckbA/y6Qngs7e1JWtA==
X-Received: by 2002:a05:6a20:8e0a:b0:18d:10d7:3313 with SMTP id y10-20020a056a208e0a00b0018d10d73313mr20229000pzj.20.1702827137761;
        Sun, 17 Dec 2023 07:32:17 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f38:28d8:e9c0:dfd4:c72c:c508])
        by smtp.gmail.com with ESMTPSA id ka24-20020a056a00939800b006ce39a397b9sm1319680pfb.48.2023.12.17.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 07:32:17 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: five231003@gmail.com,
	gitster@pobox.com,
	shreyp135 <shreyanshpaliwalcmsmn@gmail.com>
Subject: Re: [PATCH v2] test-lib-functions.sh: fix test_grep fail message wording
Date: Sun, 17 Dec 2023 20:37:04 +0530
Message-ID: <20231217153140.1831-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shreyp135 <shreyanshpaliwalcmsmn@gmail.com>

ping.
