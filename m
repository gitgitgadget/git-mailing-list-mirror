Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789D14F92
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j20c1iwo"
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED94EBDE
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 16:15:48 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6cd1918afb2so2373862a34.0
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 16:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698621347; x=1699226147; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1qpjbKIpPTkq0srG5c2G3P+Ku2iSte2JIs81nSN2xvw=;
        b=j20c1iwo3vI58dZW7oKRigDVwjBYrM7M1exO79TIJX10XFMZpx1sCCE1ZlptghPeXi
         AxNKcj7x5s1l15ImNByAhz9yfn3cTs3wa8sfW7FjLWwX106Npz1v04o+7ifCecwU0sbd
         BGWLSXq8npph4kiKC9jvPsK4l8QhnFf1ePEROx94CAM/6eoMIGFyENqU/YjILX4I6uQr
         9HmdDiNLBF/JUt9UVfSJiaXhOqMdHRbwp0TE50JgmU6vRUn3oKxaCFB6ncG1V4s0gFNo
         52iIpxO14GBywhqv+nuyIxByvJ526XKUCeoeETFRVnJHVRPjsw2bAiOuIbOuc6fMCNzr
         TrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698621347; x=1699226147;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qpjbKIpPTkq0srG5c2G3P+Ku2iSte2JIs81nSN2xvw=;
        b=tb3PfUOZjirRzMAlGZLqUUXQN+NY5Are2dswWfUMesqhSrg/SqKxxJUHA0wU/+KUEX
         cT0Wm3rFiJsxQwFCUJV5aMwXiypmvn0AV72rzPjUCQSY1/h1HV4xpTQGVa2wpHvjz509
         RtgF82mdTGK/ISL4n1Ras89BbXSCBVSqadSja4CgIofACtjCYdXp8rK2HWJJw8+Wy+Y6
         J5hwfDhdWElo98/OlXyYCT9Kn/WlT6mgmWYb7Ya+hzrLRxpXHgyMcgKUedidrPqCAq6Q
         uax9L8ZXCpxD8EuKbSLp4D8znzkJCcoPC9o+G3P/IAApsBNESsNqXlG2LNAvtKHVTlvg
         icDw==
X-Gm-Message-State: AOJu0YzHG+a9FT/vTsH73Jc7AwwZAbSe3HGrII912noKnsz3RrXBg+8A
	xoNpPBI+bEHDQ5braqCM6PtZgKK131yW2T4ChzSr8rR+DucwoPXN
X-Google-Smtp-Source: AGHT+IH4D43VbYgioFYv/8KbjezYDPp5L9tbt+wO0ELwvjRiASZzwYnNFughfK7wBXYJbhLQQ4gS6RklHIhiwe5GpeE=
X-Received: by 2002:a05:6830:4492:b0:6b9:146a:f1c9 with SMTP id
 r18-20020a056830449200b006b9146af1c9mr11217672otv.0.1698621347423; Sun, 29
 Oct 2023 16:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Mills <alexander.d.mills@gmail.com>
Date: Sun, 29 Oct 2023 18:15:35 -0500
Message-ID: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
Subject: please add link / url to remote - when - git push
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a feature branch is pushed, we get a link in the console to go to
remote, however when I push directly to main/master, no such link, eg:

```
alex.mills@alex node-be % git push
Enumerating objects: 20, done.
Counting objects: 100% (20/20), done.
Delta compression using up to 12 threads
Compressing objects: 100% (10/10), done.
Writing objects: 100% (11/11), 1.56 KiB | 799.00 KiB/s, done.
Total 11 (delta 7), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
remote: Bypassed rule violations for refs/heads/main:
remote:
remote: - Changes must be made through a pull request.
remote:
To github.com:elx-onlinx/beautychat-chatcards.git
   ffe1e05..bb7b0ef  main -> main
```

Having the link in the console saves me tremendous time and is
extremely effective/efficient. Can we get links in the console plz?

-alex

-- 
Alexander D. Mills
Mobile phone (737) 281-4824
https://linkedin.com/in/alexanderdmills
