Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6397FC
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOd8yl8s"
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A78AF
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 02:31:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32d9d8284abso1582300f8f.3
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697967086; x=1698571886; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZjA5DHucKPZbs5X+LD3xDqGAOonUuWCtReQNwqbemQ=;
        b=iOd8yl8sKFb81TDWpZwLMHxNZw97ylM5vbgqPhpWgkGKYOuplANllQsbJrhCjWsM86
         quvhCZqDHWEqe0SA47wi8uNsKQnK3uHEinZOmYlPql0DllG6jSvsje0uT5sOppjI0I6r
         DdmCEADgsg3to71k+Jgij6op22c0Md4PQyIROHs6cFalNJir59GjNDnO4vt4TI9ZOLjY
         MWjeQo8nhSvS1K+kR0yY9ww1z6mVb+8QMsHHxQO+7JalN6HVZ2N1FCKUJtUtNX+krz1C
         Be9eliOsdoMxGPN0n+CgixVFwiec3g5Sy1PCQqtoOdRwO3WXuMxiqJuIUwTgvZFREuQB
         D4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697967086; x=1698571886;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZjA5DHucKPZbs5X+LD3xDqGAOonUuWCtReQNwqbemQ=;
        b=JuJdxGpISDKHu69mKiDs/2b1JWnUMs245aIaiAGFSC7Wbatpp2lxeHmXimg5YdYKPC
         pDG3N9/TUtHsqBI5QgUSemOdamLcCY8zdIY7DPoT9X/zvwWO5gHyETgp3/9Mml4wetUD
         2IojKKStqlMAzth0Z9qDy0pU69Pntit8wqTy34BfM0/++kwQ2CHArz6MSdYy29Jg72CA
         mxzRvz7pIbogTww84mDWrRY6NgGWE6z5TrkW/BoA19rsrLzfF4vxoqPG/Iyv0eP/e6+L
         /+NJhavP8SzseUHlTwVkLIDzPeimRu6STOvIr11FloxGXHqKCZ/ivavAY+2L4cnMEsbH
         GXyQ==
X-Gm-Message-State: AOJu0Yz3mbwQukZiqzQadQ62ImeZD5T7zyNj6TCQknqXFAgBOqad/68t
	qaxpoJ7cze3kn/RgleHUvTa+2nB1UbPC
X-Google-Smtp-Source: AGHT+IHpZ2pWQoVPRpSliccDA55bU9a02kxB0LoLMbr4j2rh1ydLh5tIw3b0BcmOay8lb7WaxnW8nA==
X-Received: by 2002:adf:cd12:0:b0:32d:9d66:5742 with SMTP id w18-20020adfcd12000000b0032d9d665742mr4674632wrm.10.1697967086187;
        Sun, 22 Oct 2023 02:31:26 -0700 (PDT)
Received: from smtpclient.apple ([2001:8a0:578a:4a00:20f4:df6:9675:dae9])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d5603000000b0032ddf2804ccsm5241795wrv.83.2023.10.22.02.31.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Oct 2023 02:31:25 -0700 (PDT)
From: Daniel Santos <daniel.dlds@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: Pulling from a linux box to a Solaris 9 OS
Date: Sun, 22 Oct 2023 10:31:24 +0100
References: <20A47898-41F6-4E94-822C-10509EC1E3B9@gmail.com>
 <ZTHK7o5LXvMB5EeJ@tapette.crustytoothpaste.net>
 <20231020062738.GA1642714@coredump.intra.peff.net>
To: git@vger.kernel.org
In-Reply-To: <20231020062738.GA1642714@coredump.intra.peff.net>
Message-Id: <CC739286-AEFC-4F97-A86F-7A129159F592@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hello,

I set the environment variable GIT_SSH_VARIANT and it pulled with no issues.
Thanks for the help

Regards
Daniel Santos



> On 20 Oct 2023, at 07:27, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Oct 20, 2023 at 12:33:50AM +0000, brian m. carlson wrote:
> 
>> By default, if the SSH binary is the default ("ssh"), Git assumes that
>> it's OpenSSH and sends certain options to enable protocol v2, including
>> -o SendEnv.
>> 
>> If you don't want that, you can set "ssh.variant" to "simple", in which
>> case Git will send only the username and the host, but not -p port, -4,
>> -6, or -o.  If you do need a different port, then you're out of luck,
>> and will either have to install Putty (in which case, the ssh.variant
>> value would need to be "putty") or upgrade OpenSSH.  Otherwise, the
>> simple value should work fine.
> 
> I think your suggestion is the most straight-forward one, but just in
> case the "out of luck" part is a problem, you should also be able to
> side-step the issue with:
> 
>  git -c protocol.version=0 fetch ...
> 
> That would allow other features (assuming this older ssh version
> supports them!) without triggering the SendEnv option.
> 
> -Peff

