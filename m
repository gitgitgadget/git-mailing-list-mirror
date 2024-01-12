Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AF53E2D
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJxhgXTn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e55c885d7so31294115e9.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 01:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705050611; x=1705655411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Owu5EUFJPMesX2QQqljzgUjVRrYpvvVHrI5RpLEfv8o=;
        b=PJxhgXTntl+TfV/Np4bDLBFrhj33fQcA4UkTudcK9H6x9Bw4t52dwEFIHoSsX4875q
         3WX+GFVicvRaYaMRBeN1IspPiXDFUkua8K4qE/KfABZri6X/Iz7Y7PT4kZgl66Ey9BVU
         g5rc4jIw8NoR26GBEmIXW8PayiVbF3ZiokTC/EX9rb5eaK8LNp3ULD4kdlogmaCWOXc+
         zL061FF5DcSm47X4iNmzqlaKcJLrY4/9XT6Hiq2VnOyCEkAxLbdNeucxf35JMSKO0mJy
         JURAtbVUnpvQ5R9DYXqvbgu9AaHyemexaZZz61mNvoCEZt29fCv6lbxeYJ/g5WFyM74q
         1aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050611; x=1705655411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owu5EUFJPMesX2QQqljzgUjVRrYpvvVHrI5RpLEfv8o=;
        b=KqDN8RCqaDyuyj/svv6h5L4GPjiGmZtMHnRxdMbmK8h7o5jfsB/7wh7O3z044AtwNz
         AO2HtrIROUJFj20K3wqGrXsZ1MVeQik5kEe6tci8FzNJD2C6fgZy/t25fq0um++GC5nS
         OVy9TjTcXTsWAtob9qGbNM4BkRbM775FkwC6esh3RC2wL+itiW1ubMjpudWe3pj1rHfc
         tKqFsfhyHlJENV5riUXzasd9zfVHK+KGrnV9gyTasH5cegSMXXWXdxmwBD/0y6KooN1v
         r0lEMtyS5ZUo2Lln0+gHiNDbSqwu+zKlwAAcwCotJA6yXCJTxO4mmclU2wvsKBv7Vqb/
         Zsiw==
X-Gm-Message-State: AOJu0Yxp3upY/+OjoOnfsyfT7DeYfD//a0PDFlRpJykTDnbsnbIBA8Bv
	mfoVtvFMmJ5QIigGUS5XUKuIb+oEIsQ=
X-Google-Smtp-Source: AGHT+IFrXeswAaE0AMcGMniJBtG75/weoGLg5LPAqxBjbd9QhZGESHftX0oBNjjnmLoywqK4ss8Uqw==
X-Received: by 2002:a05:600c:3b9d:b0:40d:3b88:4516 with SMTP id n29-20020a05600c3b9d00b0040d3b884516mr575230wms.95.1705050610586;
        Fri, 12 Jan 2024 01:10:10 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c358a00b0040e559e0ba7sm8743581wmq.26.2024.01.12.01.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:10:10 -0800 (PST)
Message-ID: <60a90f4e-b22c-46cb-a79f-a0e01e711732@gmail.com>
Date: Fri, 12 Jan 2024 10:10:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] advice: fix an unexpected leading space
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
 <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
 <d5fbdb05-d16a-4390-946e-22a5a7a1b56a@gmail.com> <xmqqa5pbcpnx.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqa5pbcpnx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11-ene-2024 17:21:22, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > [ ... ]
> > diff --git a/advice.h b/advice.h
> > index 0f584163f5..2affbe1426 100644
> > --- a/advice.h
> > +++ b/advice.h
> > @@ -49,6 +49,7 @@ struct string_list;
> >         ADVICE_UPDATE_SPARSE_PATH,
> >         ADVICE_WAITING_FOR_EDITOR,
> >         ADVICE_SKIPPED_CHERRY_PICKS,
> > +       ADVICE_WORKTREE_ADD_ORPHAN,
> >  };
> >
> > Note the hunk header, instead of a much more expected:
> >
> > @@ -49,6 +49,7 @@ enum advice_type
> 
> Next time, don't include "diff" output in the proposed log message
> without indenting.  It makes it hard to read and parse.

My fault.  Sorry.

Is there any way to make git-format-patch issue a warning or refuse to
continue when the resulting patch is not going to be accepted by git-am?

> 
> The attached is what I queued in my tree.

Thanks.
