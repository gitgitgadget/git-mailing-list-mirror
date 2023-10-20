Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAF91DA59
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41016D52
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 13:05:39 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d0f945893so10551586d6.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 13:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832338; x=1698437138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9nQi9uOL5IHD7kSYuCAjAENWAKwEfRbKHOVfy88iAA=;
        b=XtiVTcV0d3vuYXIDgRX1kqja167X7oQLOOsrSIpby8Z0+7pa+0NJLA9W14ClTqLLoL
         aJ9Bc4gavAApGz4QJb2O75NB+CBgtj/jkDPC2gkEYFrN84xwp2fvHxsd533sxtCQZDFt
         0xjoIt1Xflwg0W4983Cbx8xvDs1IY9xMoKaqFvv/MS9sb9ivPlKeV/THakr6LIvlG0YA
         dAeu1d4DdVTSW/oaseofbzmK+JnChwxGgM8TY8tE950qkWWDc9GuPM0lC6yct9nwcG4C
         Cc5JeL5+SYVm9kK6pM40ueX8P0r7YH6FxXRhR0HLiUQv5NLkSRPzzDyG1v6WPC2l152B
         3udQ==
X-Gm-Message-State: AOJu0YzA+q5l1Cthns93x+FxmQ4B3tqDz7vqVAKUBHHdjfQ5asGHFQ1g
	jb7H1PKg24rhbBcs3kvA3tezCynUilo6lA34m3c=
X-Google-Smtp-Source: AGHT+IGsayVLkPgl7khmbq9/0JgHui5J2o3Gxon54i1/pJO3b5mTLvTsc8Yu5WvRM0udUb0gncsaK75lw8V6FIAc3VU=
X-Received: by 2002:a0c:d689:0:b0:66d:327:bf8f with SMTP id
 k9-20020a0cd689000000b0066d0327bf8fmr6580272qvi.30.1697832338297; Fri, 20 Oct
 2023 13:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020184627.14336-1-msuchanek@suse.de>
In-Reply-To: <20231020184627.14336-1-msuchanek@suse.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 20 Oct 2023 16:05:27 -0400
Message-ID: <CAPig+cTGiFSkC4dXwmXhaM9wxnr4SDnpzV4Y7yY8ti708zuiZg@mail.gmail.com>
Subject: Re: [PATCH] git-push: more visibility for -q option
To: Michal Suchanek <msuchanek@suse.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 2:46=E2=80=AFPM Michal Suchanek <msuchanek@suse.de>=
 wrote:
> The -v option listed at the top as option al parameter while -q is not.

s/option al/optional/

> List -q alongside -v.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
