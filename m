Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656834186
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwyIx6KU"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86BF186
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:36:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1caad0bcc95so928725ad.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698266201; x=1698871001; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGqVSHwAkHdFJr329d5+jNmnpD5zV+k8aRCQjnjGHm0=;
        b=iwyIx6KUfYVubvV9btb/0aJcRDLIJxtVu05xm+zW0Jna6BxZZ4nejLvsgMqxOsu3Ck
         00rnxIiCSrPhHVsbEH8f+tCyImeKgySHX+uGgtWRLcC60Khsgz3plDReqxZFHDw5qBoq
         TaFF4e1U7FUFVTlFPG36giud3kIXxWv7PmI+FcH90qEVEHushd4tc5S0Gpj84Eb4JyeS
         qgavcYP9eoHpgX58jR7Ayi5+N3FW+D26xw0oTNVVol3eqXlYe4iyGMXmTbzU0MINXHAn
         P4pBdYILQGML445rHaYtJ8aQw22CF0fwHunbyGuI6wseRsF04QLnuzgZZFDdUEJEtucG
         YoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698266201; x=1698871001;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wGqVSHwAkHdFJr329d5+jNmnpD5zV+k8aRCQjnjGHm0=;
        b=Ovs3nLw9xzHP5GM26KB0sR9sQXL7x7ZFeoyhV0kTQxZdyoy5YineGkurlR7AxPUxuw
         u8x83SQLnJsqhD8aPrjBjX2KL1ZVVdyOAWJewEzmMMPbM7k+WYv0P8bgvZW0RVmD+e5X
         Uq/nhN1wi4RMz62KK70JqSaQog0xZ2SuwA5t4wk/hVx3DV78hjt8Cr7xA9Ob/+PVpHaJ
         ITg864Nl48fBBruuKB39mXO5P92jaNlwQDcx+U41TqPNxAlCpyXeaItLzUTG/5KnXFGm
         zOdIF8ztIBNigZAs2K0ymZK4wlHr3FkDBMdyNwSyfi6yP2+oFvrkCXh6MXikmZGFDkz6
         ZXTg==
X-Gm-Message-State: AOJu0YxFtox6tAL7HDubmz45yxvj2HM4VCQnibIx+rGJwA4ZLa08/CYs
	LP0ROVnDatbSTchNXHXOBNN7vQhCRKo=
X-Google-Smtp-Source: AGHT+IEGiUuGn5BPd4YIdV8lFXt0P5v+DpPrXk+rMKYG3fLky+Wjckn9APRK7gG+RvMUYNI2CTmnrA==
X-Received: by 2002:a17:902:fb87:b0:1ca:a83d:bc57 with SMTP id lg7-20020a170902fb8700b001caa83dbc57mr12935478plb.24.1698266200829;
        Wed, 25 Oct 2023 13:36:40 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id jc1-20020a17090325c100b001c5fe217fb9sm9624525plb.267.2023.10.25.13.36.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 13:36:40 -0700 (PDT)
Message-ID: <63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com>
Date: Thu, 26 Oct 2023 07:36:36 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Sheik <sahibzone@gmail.com>
Subject: Repository cloned using SSH does not respect bare repository initial
 branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maintainers,

Repository cloned using SSH does not use the branch configured in the 
bare repository however repository cloned using filesystem does as 
expected. Shouldn't they both behave the same?


Thanks
Sheik


Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

#Create bare repository
     su - $user
     git init --bare --initial-branch=test test.git

#Clone repository
     git clone ssh://$user@$computer:/home/$user/test.git test1
     cd test1

     git remote show origin
     #Output [ORIGIN1]

     echo abc >> abc.txt && git add * && git commit -a -m test && git push
     #Output...
     #* [new branch]      master -> master

     git remote show origin
     #Output [ORIGIN2]

What did you expect to happen? (Expected behavior)
Repository cloned using ssh should push to test branch just like 
repository cloned using filesystem does below as configured in the bare 
repository.

#Clone repository
     git clone home/$user/test.git test2

     git remote show origin
     #Output [ORIGIN3]

     echo abc >> abc.txt && git add * && git commit -a -m test && git push

     #Output...
     #* [new branch]      test -> test

     git remote show origin
     #Output [ORIGIN4]

What happened instead? (Actual behavior)
Repository cloned using ssh pushed to master branch disregarding 
configuration in bare repository.

What's different between what you expected and what actually happened?
For ssh cloned repository test branch should been the default branch 
however master was the default.

Anything else you want to add:

[ORIGIN1]
* remote origin
   HEAD branch: (unknown)
   Local branch configured for 'git pull':
     master merges with remote master

[ORIGIN2]
* remote origin
   HEAD branch: (unknown)
   Remote branch:
     master tracked
   Local branch configured for 'git pull':
     master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)

[ORIGIN3]
* remote origin
   HEAD branch: (unknown)
   Local branch configured for 'git pull':
     test merges with remote test

[ORIGIN4]
* remote origin
   HEAD branch: test
   Remote branches:
     master new (next fetch will store in remotes/origin)
     test   tracked
   Local branch configured for 'git pull':
     test merges with remote test
   Local ref configured for 'git push':
     test pushes to test (up to date)

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


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

