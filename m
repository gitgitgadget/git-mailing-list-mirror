Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A92EAE9
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlqXriRC"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67f564b4245so4921946d6.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703282840; x=1703887640; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kt0zn9F10QV5kkiOLDsk7kSgajbM12vMPvEK/OdyOJc=;
        b=FlqXriRCgGjXTyFYZc4U5puqwSFt/JLQBJH7f5wgCmDprwb4bGevBBClhbK9cN+sCE
         22o7TOajEA1Z7Bg6JExYoiWwu48jPLeoqftAeYorV9TzRy8tNldR2Sn45e1MKokyTcu2
         o92XHw3LeqixcsROo1ZCc2qB07viLRajn9NKf3CBzRjPl/Zf0CHoXrn1VGuJN6gjIBoH
         V35x8Rq8LcvL8yBz2Nv+SIyCS+qUmnNsDBVCJDs0yATMjZ7Df0dZxIRzFuOH5MPRKfRr
         vO0329sFUAic5acGa+41pRnQewtnGntSn/lfUPwnRChdo8+kybkcPbSU1fMcb4jZQ77T
         PrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703282840; x=1703887640;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt0zn9F10QV5kkiOLDsk7kSgajbM12vMPvEK/OdyOJc=;
        b=pIma3Aj9V5hByhjHOC3QFB+jDBV4L60iffhVrjxvAmQ8TpesyOSx6R1Eq3NkzUe5Rf
         xzvKieUTHl5jtE9dBKvKSVqSodZec1LC/zvL2yM4GRMFfZTIL8syhLhFlAbk52UedfDm
         5+g7hduGUZ0THw+DbzFEH9u8h3zsVvrOUkQ+Nw3c0XaaAPY/xM+VQkWl2lGzohu99/3F
         y8Ft3XsFzjzJSTBHTmcrW81ZIhJ+OZPPb9EuRvks2y+7LItlftfihYfhmrhDDm0pN7U6
         UkBkyRqvjciDqRAsHnHiv34GO4jrrDogO03MyVGuRYgQrdIdnNuszvxbMNzX3DVW2NcZ
         B/Dw==
X-Gm-Message-State: AOJu0Yy+bab0MTsLWxcyUh1kIZ9Dj0v7JNd/jwk6ZlQq2wlB+sfaBZov
	bDCB7F06RKfAaPG1s1yd6gT72nHmIP0=
X-Google-Smtp-Source: AGHT+IGptLPcth+RdDhBpvjOdYvmO5UaaR3GTVGNKXcfORI3pgt9EquQO9UMg0HY/gdI0bA5d2XxKg==
X-Received: by 2002:a0c:f80b:0:b0:67f:a0a3:874c with SMTP id r11-20020a0cf80b000000b0067fa0a3874cmr1923641qvn.5.1703282840220;
        Fri, 22 Dec 2023 14:07:20 -0800 (PST)
Received: from epic96565.epic.com (pat-verona-j.epic.com. [199.204.56.215])
        by smtp.gmail.com with ESMTPSA id dw6-20020a0562140a0600b0067f34c818b1sm1658497qvb.42.2023.12.22.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 14:07:19 -0800 (PST)
References: <m0sf3vi86g.fsf@epic96565.epic.com>
 <bf1ce173-50d7-405f-88c1-7edb7ec5a55a@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Sean Allred <allred.sean@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Sean Allred <allred.sean@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: rebase invoking pre-commit
Date: Fri, 22 Dec 2023 16:05:20 -0600
In-reply-to: <bf1ce173-50d7-405f-88c1-7edb7ec5a55a@gmail.com>
Message-ID: <m01qbdx561.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Phillip Wood <phillip.wood123@gmail.com> writes:
> [...], we'd need to add something like "git rebase --continue
> --no-verify" as a way to bypass it when resolving conflicts in commits
> that were created with "git commit --no-verify".

Looks like such a flag already exists to skip the 'pre-rebase' hook.
Presumably it can pull double-duty to skip pre-commit as well.

(It's a little messy to me to not be able to pick/choose which hooks to
skip, but looks like this is already status quo with other hooks.)

--
Sean Allred
