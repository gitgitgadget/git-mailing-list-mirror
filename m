Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="YqXs8jBV"
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B27E124
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:21:05 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso6260010e87.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1702560063; x=1703164863; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUVqW0/ul7fYfO1XWxky5/dxrNr9ul51mRR2XCFXvEg=;
        b=YqXs8jBVbyYYtDe7fKZG2rlh2AOp4//3ulpKAVNavY/mt2Jwf+nAB5XjLeSXd9MvmI
         eVriRLG4QlJBd3cneWE1fnSIxvGTL7igBDxBgDTWRFByuAj6qsHsnHRXOp8TAmYzrvhZ
         AoPSDrddInHuzGA75bvNQlHMteJpmJr6IJgcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560063; x=1703164863;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUVqW0/ul7fYfO1XWxky5/dxrNr9ul51mRR2XCFXvEg=;
        b=rT3HfZb/pROgfIarqzwBAuKudtDmRAr+VvG1k7ueNbdKE0EEe6LAgmk/GgG3o2q/lV
         iI4Eda6a3LBIrTIXRnqaSTdWhWuovxmd/VSVy5bzzQJVY5FTu8uqINponySvbYyppOr1
         AvqTOd22sMbHJW4kcRXHk6dfTnClQmYFIDXmhnE+0CfY6ijt7tjXODhgzAc6RzLDdtn/
         hXqJFmdvDuKQLVbpSzh44G4QpEtAozXvRYoKsx4mpekAv24wdhTDDtMJKNjlrd8Bbkr1
         rZxK0mWS7ag2Y97AaXxmGV1eQH8cdF3OZK5ZQsD1t4SLtsXB1yD26U+vbFns7hTvxYTM
         D1Tg==
X-Gm-Message-State: AOJu0YyCLwfOCsx+0zyS59figRKvMVoDTo9UvFoUJzrrCnMlMiyAhvoa
	FxQwIDLM9q9z7lrn0YCp9dT95QX8LcNPoVePZsCu76vr8FRDP9vwODD+/kn7
X-Google-Smtp-Source: AGHT+IF3EZXpqZ9pd+VUft85qDjJpKlGi334S/OFbQ/zEG6C6yv4CJPJ6lxTmKWBtD5Q/iQ2I4IQo9JO649zQCFJEQg=
X-Received: by 2002:ac2:4152:0:b0:50b:e710:1579 with SMTP id
 c18-20020ac24152000000b0050be7101579mr3855805lfi.137.1702560063004; Thu, 14
 Dec 2023 05:21:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marzi Esipreh <marzi.esipreh@uber.com>
Date: Thu, 14 Dec 2023 14:20:51 +0100
Message-ID: <CAN0Ui1RM-R+yX=LK+ir_WEzAYRJnT-WTn427JbNJjTNTiQfa4w@mail.gmail.com>
Subject: completing an existing patch
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,
I hope you are well.
I'm working in a company where most of our developers are using linux
as a development environment, so the performance of git on linux
platforms is important for us.
We came across this PR: https://github.com/git/git/pull/1352 that is
improving git status performance on linux platforms, we tried it out,
and we are happy with the result.
I was in contact with the author of this patch, and I addressed the PR
comments as well.
Please let me know how I can proceed? Shall I create a new fresh PR,
and refer to existing one in the descriptions?
Best regards,
Marzi
