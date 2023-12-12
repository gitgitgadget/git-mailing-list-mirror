Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX4fJOBy"
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B9EB
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 07:18:22 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso80653971fa.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2023 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702394300; x=1702999100; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uldy2KcMb4NF5TOvj4CUWiY6v85K0PRtnlMfjTo9dgw=;
        b=kX4fJOByr55BXM7K/ZRNhhRkzxxxJBI2BteQs8lPdvCrbj9sFtCRZLe73M6O9/oZqC
         oQsxdG9f8oYVjgsuA+r/BxGHrA+shSBDUFTS0WygegnmH8vDdhjtqS2Lx3RuPI2B/JQ6
         efhwW39A3TsgLYw5VgJi4X3lYpLLZ964eJjfYxcI0vUtAV3p3PbEfdmD9KkZY7vWEuJG
         cTobXX1b7oCn83bjqsgVMY10cvx3iRRqFnHvWUeU8XaJdKKWjUQ9wDl8hLISIp6Y7nBu
         T+fUcW2RvPRRnu1iyzYn/Mt4aOVwaHAEZJi0fnPGy66pNFAiXI5NIUYKiCa10dNC5WQX
         XGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394300; x=1702999100;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uldy2KcMb4NF5TOvj4CUWiY6v85K0PRtnlMfjTo9dgw=;
        b=Bi6MFqY7crEH+mpdJM6ctjQzkyTg50RW6qqlvPYrxo65JXePfODZA/oOIabJj0diXx
         PrPHRrLpz/oG4IzBGS4FNJlmAxBXwfdapHCfb2Q20bhG606HkCMyPtIPmVrqJsKJFyRH
         3WR5h0sKFvBs4+QiF2+6BxUWQQbr+KrG0zLXtmi+YdlE341VtupLw2FmwNSYBNdMaQAx
         qpeblhwFaT/Hn3ckkVVSlmW4OTQFoNifMfAOyoF8zDN3y84eFdm8gygGw2wQwLmamMck
         i2LUuP5jkUYKMX0CZ1Ni1cDWbHW+97AeqOOM5WLqoFtH8rMCH1Gzu8lFxj0zwajnVczd
         M/jg==
X-Gm-Message-State: AOJu0YxgfcuGvduPbhmaznUt5PpRddUm4RFX90T4s4ra9E0zqZ3gjq7V
	baqEf0LCDlz3OG4KjXZ9BnMoqCke7Izh7R9PjMrOgFWWigrkoQ==
X-Google-Smtp-Source: AGHT+IHWjcMlCc+gCvlg3COFCUyqkFvynpnb2he/8rsBF2iQ4edpQ/qUS+f1qXOFMozeRrkmjxENINlDu7cUczLohiw=
X-Received: by 2002:a2e:a267:0:b0:2cc:1ff3:f37f with SMTP id
 k7-20020a2ea267000000b002cc1ff3f37fmr1431910ljm.96.1702394300253; Tue, 12 Dec
 2023 07:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel de Dios Matias <tres.14159@gmail.com>
Date: Tue, 12 Dec 2023 16:18:09 +0100
Message-ID: <CAFXSV2rXGmEJB08V8ZgPqBprQOfCRmxmbyATWLjSdR+90cJ=7g@mail.gmail.com>
Subject: Feature Request: Add confirm message when executed prune
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi.

I accidentallly did a git push --prune --all in a git from the company
where I am working (and hope I will be working...well sorry for the
joke), because it is simple I mistook git pull with git push and I
deleted all branches of my jobmates.

I thing it might be a good idea to add by default a confirmation
message (can disabled by conf).

Or add a parameter such as rm --interactive for to avoid or minimice
(depends of coffe level) these kind mistakes.

Regards.
