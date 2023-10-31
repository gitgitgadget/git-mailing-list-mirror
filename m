Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC0ECD
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 03:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3Cu55ss"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFD6C6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:29:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507bd644a96so7507649e87.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698722986; x=1699327786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwRq1TGkMwQzg7W+mkRg9O9z063Ofv7M3GymsrBQFHw=;
        b=g3Cu55ssctgyFDq5TeBCs1z+bNgKwrQAsNKNey+ktp9FCvLgRUE6pfjyCJsUB0vUC+
         F8we0hckh7xYFKfU+3d+8VgQUV9XCmF48HQwA6emhtTdtHlWTmLXaByu8o7ETyB/N42W
         +kBXOAKF2ZkXb7c75077FD2nmCM/SXLmT5XUmPJbcWWKlPA/ywS3QP/jwCxoSY1QDjkY
         oFZgKRKeANM9vvEQlajN6JayeR4gO8cG8o2ptUM0Tj2ZROE+wRvpCeYwi9+GCJw7+PYV
         NRO+YLhw7A9u9c8DN0v5O2+dv/8yg+wzNm6T1+oLTTaw2eCDZTdzD8r0MPVHVoxJakq7
         mpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698722986; x=1699327786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwRq1TGkMwQzg7W+mkRg9O9z063Ofv7M3GymsrBQFHw=;
        b=EZXpBzNVwFcd8BVnZAVA/CZMOkiXHDuP7w0fyd9aVYEaWbspaMXHGttTQCnpxMoAuF
         /4LRFcXCjTX2lsC3sAaRBq9zzn61AMBXcbfnT0/Wj3vDyK5r+537K+xZO6bhBwkX6Jwq
         +NbjPwK6XBMYktN2kuqLpsEA936G6Dry1F2inZvm2toQ1BpTe8JqjK/itVgRBhAvn5LY
         ecczVY9jgJGVdsuSLNt5u2dZP5Bng0X2PFapG+ywI4gS99WLWyQ23jtwDMg0UMDm0OFp
         tSuBk6AmHxXkTeG8PFyTFH6kH65GbUD6nYyNrwFH7qjH2MrJ4tK4HJBywT6bhoalvrCo
         OKpA==
X-Gm-Message-State: AOJu0YzKm7nPTAYR9oB7OI9p+Xu/Ayn5cpXLnaxQ2xoYopuPTVphzbWB
	7B906LrfFrCrVl8n6iLgDinkYIiNJAo9bbSh/6k=
X-Google-Smtp-Source: AGHT+IFA3ScA/kIr79KnMwa+P1gjAfZi3643XvcuF3mvpQZ0dU67Lm52UIUuBr4/0NxSJed7hD76b+bm0n6E1RZCARY=
X-Received: by 2002:ac2:5183:0:b0:509:1301:8470 with SMTP id
 u3-20020ac25183000000b0050913018470mr4471180lfi.45.1698722985783; Mon, 30 Oct
 2023 20:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FACCA976-EAAF-4B68-8748-D13A11EC6652@gmail.com>
In-Reply-To: <FACCA976-EAAF-4B68-8748-D13A11EC6652@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 31 Oct 2023 04:29:33 +0100
Message-ID: <CAP8UFD0ZAOm7gvr598Cy1SS=F1dxSQ=61KMm1ypV4FA5zQVN9A@mail.gmail.com>
Subject: Re: How to get started with contribution
To: Shashank Gupta <shxshankgupta@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 31, 2023 at 1:08=E2=80=AFAM Shashank Gupta <shxshankgupta@gmail=
.com> wrote:
>
> Respected sir/madam,
> I am Shashank Gupta, a IT undergrad from Manipal university Jaipur. I am =
currently in the 3rd sem of my Btech programme.
> I am new to open source contributions but I have good knowledge of c, jav=
a and javascript. I would like to contribute to your organisation but could=
 you please tell me how to get started?

Thanks for your interest in contributing to Git!

We have pointers to a lot of documentation about this on
https://git.github.io/Hacking-Git/. Especially there is a section
called "Getting started hacking and contributing" with links to
tutorials that we think can help a lot.

Best,
Christian.
