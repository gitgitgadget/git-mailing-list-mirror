Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68B15491
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrOSfYJ5"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC4136
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:50:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9bca1d96cso921215ad.3
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698267002; x=1698871802; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sInV//U2ryaX6Zn2JMzEfDtQG+bqG0OgbuabPs7woS0=;
        b=LrOSfYJ5oShviGX/Po03kHyC/TC0vZ+sM+iSh7UbAgkAP5ws+SvdwWwSWWApUY+t45
         hkpTeWu0mvLCAouJcJ9KEAA4sqzbDsaQ352kpdo+AtO8H49SKmVZvBFtC/xQJZuzD0rU
         YdRHMTsOGrCiAi3N9cBrQzSUqpSwVz16sx+EIZQdzBgJ2FmPrfCicTQ07zY5s74dfmaq
         h4ME/ym2ThhHp3OXZ/jzJB1ydwjYggFdqZubqHB4ITiUNlSywBafWJU4BXPuaTVIF85d
         2RblN7hMvSC8bAs9EIZWDvb3RdQpbeSjSwXDU6EHwrsznxEnOLAYawzHfqVmepZCnk4z
         Gswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698267002; x=1698871802;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sInV//U2ryaX6Zn2JMzEfDtQG+bqG0OgbuabPs7woS0=;
        b=C9NNqIRPj4Fi5GVdWcgkvT/xvj7S+ZN936J24r76DWekJqPCK0+uqk8OqmFp39x7WE
         OppS/4GdnOg2dhc0qLhC43h0s0wjwq+lBe/LYBOFmcPiIXEHW8frKUkiwuwmEprxG3ap
         9Z+O8JvDL0GwulMXc3BcJ+4iBaBfTR8GtbV+NX7GWkqjj7xMofCRQnbbQVhr4HtbZQDz
         9copBYszAArwMIqinx0oCQagze/nFGsebv8tzwSeCmNxcfry8UGCoAEZaOJZyVsYB1S2
         rdNFhJKL36HS3CQgRn2FlNblC2SbD2Bdo7nf1yJB4AAk92i807EAEdGoKl5+FKJ7XSEX
         kw8g==
X-Gm-Message-State: AOJu0YxSFPiRv6Lx0mnyONwrcKEWSdYl41JSqP6h9zUO4g7gLXiTcsGr
	2ODkfEQKqro7Xyqp4sn3b5zLvE7t+bI=
X-Google-Smtp-Source: AGHT+IFxVk/Za5OD9zMPVzBCBiy/ENiE3YpCxHciu1B9YW0BSe0WXAt0P3aGXT76nXcsBIW+bu+SNg==
X-Received: by 2002:a17:903:110d:b0:1c9:e508:ad43 with SMTP id n13-20020a170903110d00b001c9e508ad43mr15817419plh.8.1698267002556;
        Wed, 25 Oct 2023 13:50:02 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001c727d3ea6bsm9575626plh.74.2023.10.25.13.50.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 13:50:02 -0700 (PDT)
Message-ID: <849b6ee2-99f3-4aaa-835f-44d3e13befc3@gmail.com>
Date: Thu, 26 Oct 2023 07:49:58 +1100
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
Subject: git diagnose with invalid CLI argument does not report error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maintainers,


Running git diagnose with an invalid CLI argument in a valid Git 
directory does not report error. Expected behaviour would be that it 
reports an error.

#Example shell commands which should have reported an error but 
continues to succeed

cd $ToAGitDirectory

git diagnose mod

git diagnose mode

git diagnose mode=all


Thanks

Sheik


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

