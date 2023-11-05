Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B017992
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzhOID/S"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B57B3
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 15:17:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc3bb4c307so31516395ad.0
        for <git@vger.kernel.org>; Sun, 05 Nov 2023 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699226239; x=1699831039; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRElglGlagwajWj0aYwSg74/mfBGUyTMFGqT258SUHk=;
        b=NzhOID/SsK/HzIxRHPACt8QuaKcfBWM+VWsNBJCBJr+/6+D2fMmFNMp0AdLhtySRP4
         Xc0Y6wNK7S+RXwSWzG2u4dAdfZef0AYXEIBYCe9VhR/BdTWN1JMrznwB7Ocs0zGsW4WG
         ZHIlshqps2oAVaAy9s6UGc3RGjuU93x34mZM7QtNERy73etNA6BRnS5lwTjxkiWbPFVX
         LE4NEOiSQZ6UDZtqvamqHI+jRiBazzidt2GnxQFOm3ggBMJFnoullDiqw4FH7Fiv5eeu
         M1gQTP/HR0jEklHlOR2MUz68KO1cTFHhEV4BAAvdM6D0yqfBGWM/WCAICrvJvz0LABBg
         OAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699226239; x=1699831039;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nRElglGlagwajWj0aYwSg74/mfBGUyTMFGqT258SUHk=;
        b=EAcOIgNBjfliKpZOCly/kCxtZJePbZCarawy0/rhNwIXLDHw5kP3yI849SI/L6e/lz
         2NvZVGWi0nRz1RTxu2enNPqB3CjMjiuU4ZQUcYvhh6pk4hKmKzTJzQ+PgB8GxJNt5IiX
         lIBFAKaqUV4k/dHOezq/qdBtLiBXlrKcHxNMH2ZURrK2tLWSSmeM7ZRouXxSqObhQSnf
         xIg1GI2MgGogBelB7KItRgL+iq0nH7FSI9qJb/MByje371JN1PVsLj6bxkMJY4WnLSHl
         s5kG/hYJycJ54wKMUsekmnrYYO9ghpPtE01+Q8zr2+RY88nQBtbWzzvp6Z2moAeDnC1y
         45XQ==
X-Gm-Message-State: AOJu0Yw4rMTgX/QE/+rBcTIwkQP4hCC+HbBSvIfVO7SuL6wSmwQRH9xt
	t+kRp+CiSk/oBLEGftqbbMHp+q/GzTTugA==
X-Google-Smtp-Source: AGHT+IGW3LelkNQMRc8ZT113cUZUvnTcnfc7tPGs/UBAEUIEXFLk9TLkSAsLhbWbthaBquvVbZeXJA==
X-Received: by 2002:a17:90a:2f62:b0:27f:bd9e:5a19 with SMTP id s89-20020a17090a2f6200b0027fbd9e5a19mr22130581pjd.25.1699226238979;
        Sun, 05 Nov 2023 15:17:18 -0800 (PST)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001c5d09e9437sm4605149plb.25.2023.11.05.15.17.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 15:17:18 -0800 (PST)
Message-ID: <9f17f398-83fa-4789-ace7-9230834519d3@gmail.com>
Date: Mon, 6 Nov 2023 10:17:15 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Sheik <sahibzone@gmail.com>
Subject: git init --initial-branch (should docs mention v2 protocol)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maintainers,


Currently it is not obvious from the docs that (git init 
--initial-branch) needs v2 protocol setup on ssh server for (git clone) 
to work properly with unborn refs, as seen in this email thread

 1. https://lore.kernel.org/git/63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com/T/#u


Should a link to the v2 protocol documentation be added in "git init 
--initial-branch" to make this configuration more obvious for admins/users?

 1. https://git-scm.com/docs/git-init#Documentation/git-init.txt---initial-branchltbranch-namegt
 2. https://git-scm.com/docs/gitprotocol-v2


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.6-1 
(2023-10-07) x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show


Thanks

Sheik


