Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31140171A6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsjNMUgk"
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DAE1FC8
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 05:40:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28094a3b760so6219252a91.3
        for <git@vger.kernel.org>; Wed, 08 Nov 2023 05:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699450812; x=1700055612; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=VsjNMUgkKXU0gkcXSdRWiATwAQ07CmomJavAm+ZlmO5OqYBXamz8je4fFdBQT6mdFF
         Me+m234fdq5Jc3GjRro66iJgIR7cDj+C1fxIzbVvwvg++pQXgY5SzSgQHOocvhcJe/U0
         NjYNpZKCofRbYOM0OlliA+Z9E/Ili4v1+GDR/k8ZFTglWeMXI/7MjRiTw59ceXULMmzJ
         a/5HjYloS17BZrPlrNzJeF9X5buR013BBGOqoNhVid2nTqcKX34eMPr9v76fkwrQQ2vU
         utU6/5YHcfQLMCa+f12wMRl/r/ykZA5wDg5I6ONdmEiOIcgzLiWJsvm1U6sBvD56TUOs
         M8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699450812; x=1700055612;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=I2S3WgpSZDOAL2uOn9437Byyk/ukPP/188sADXzBtyl0Jd/W0UjHtiIAvEf7gw2haO
         qH+Tk461hiFAVzrlMyU0Khg7JD4M9ryWJZUqQ4K2Y0d78ymtwCkpKJInz8HoZV2405Av
         hhEC8xz+6fdh6pBExFO7YLdyuAdrUwVcnQTFB2OXl7eS/8MvWnSlrLye5+VEWLSxje5g
         Ym1pXWa8y1afXzlQUsQ00ZIQOtUZUELIFcI9fYr9CnfHQ+9iqc1r+lnL8e2KR9XC3K/H
         6D6crSle7vm3x1CrOixd5yai01jVDUEpFc5x1S/c1yvQlDiOvgSVhPdYZYvNrrRk1vBe
         7FmQ==
X-Gm-Message-State: AOJu0Yysv9rycoe/rUjaPf5qjp4PAjgKIJWHMpeFdtKUmvDWzpdEKd35
	XQk1taSJ8b4keMwrUly5u4VgCpeBKNuFRyH/8sIcBC5G4/h1Bazm
X-Google-Smtp-Source: AGHT+IH6ZFBrADVVrtMkJB8bUyRgvQJt7ODo7mXlRamFZ3jkPWuJ/SjEkBv5uNpSgP2R6woaezb/89wb5O51l79Tgfg=
X-Received: by 2002:a17:90b:1809:b0:27d:dc9:c67d with SMTP id
 lw9-20020a17090b180900b0027d0dc9c67dmr1508882pjb.36.1699450812412; Wed, 08
 Nov 2023 05:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:7300:434e:b0:e8:a350:b8e2 with HTTP; Wed, 8 Nov 2023
 05:40:11 -0800 (PST)
From: =?UTF-8?B?2KfYqNmI2LnZhdin2LEg2KfZhNi52YPZitiv2Yo=?= <abwmaralkydy64@gmail.com>
Date: Wed, 8 Nov 2023 16:40:11 +0300
Message-ID: <CAHqpUN7-+SK9LPATujKC7XJ2v1Xu3EfT8Tf_PuALSAo-whnSuQ@mail.gmail.com>
Subject: 
To: 4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com, 
	alhmsyabwmar72@gmail.com, git@vger.kernel.org, paolo.ciarrocchi@gmail.com, 
	vmiklos@frugalware.org
Content-Type: text/plain; charset="UTF-8"


