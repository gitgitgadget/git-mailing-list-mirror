Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xBeXeZaE"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522D1712
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:27:00 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77f37772ab6so123584285a.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702074419; x=1702679219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8icdEPE/ZqSEYsnW47bMosy39xBVKBrQQjOM09tl4Z4=;
        b=xBeXeZaEehapzVy2Xq2OOYKONkU+e4l8mUdNSuwz/mVxOKnJN3ZZwwfFIy0i7py3U2
         g23jR3JunN3fpNqCnW3H6R7baGmE0ZAPw34o8iFo/qB95fxpOsHLk/zdQRH5NwvntdJi
         bsA0+nRAizj5j72WLnPqAJXVmxXIBQANXg7uJuxEEvSEa53za+3j+aqJRib+SxfMDCHD
         9I3zUPLtIM1mmOw+BgUhtFg3+GJg4bDVD/pYdNUGJL3ZvkIHuaHmucNpCI5MVgnLAi/v
         VhcAAby3WFHF8poCix7HmlDj1l7DvNSGjk95cZON7yaa1M3s/xdD+wJwfkd/ViZfr8kB
         hm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074419; x=1702679219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8icdEPE/ZqSEYsnW47bMosy39xBVKBrQQjOM09tl4Z4=;
        b=kxUc7AZLzxCr4XOvmJSO00gr0hXc43d94MQOAoNS3cBIGg61K1G1IcX/o19IYSVHV7
         +1IPoalO+nJ89Y6OnKQOxn8KbN5nhX4CjC9wxsGuEv8YgAj03YsLNStgxetXq38NB/8U
         lDtmHt4euyIk5dEWvvgt9v/5VqzBjw195ccvcfhYmkefX8+AGlTnx2zEYHvNwIwfr2M6
         HMl6bLeBMMZP0qmGUrXDT7FxqQsozBka6g44UnK3kQ/3tcEJ743XVGja2DGt/iNQ1FzY
         l1bB0ztlJ25FX6aopzANp5qWQsV81m6Q0wVzE+UPPwb8zfVXINvrLvdtvWwOmb6gLQL/
         2wWA==
X-Gm-Message-State: AOJu0YzHA5QgBwFjroQ6jJh64l8Xr0C5L6rUAVa/oj5y2xdbdoLObI6z
	VMZvfotC/54iadCwJcsJMBDym65iMvkjs6WXuMQ=
X-Google-Smtp-Source: AGHT+IEJFS0BABkwX3tyJL2Hr9AN2xcA5UBYMWTOdy7deAVjPke914wOjnqL16IUGV57yg8J2JGWlA==
X-Received: by 2002:a05:620a:45aa:b0:77f:155:6d58 with SMTP id bp42-20020a05620a45aa00b0077f01556d58mr796066qkb.124.1702074419401;
        Fri, 08 Dec 2023 14:26:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id rr23-20020a05620a679700b0077edde498d3sm995624qkn.89.2023.12.08.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:26:59 -0800 (PST)
Date: Fri, 8 Dec 2023 17:26:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 00/11] reftable: small set of fixes
Message-ID: <ZXOYMhlAdIP32l1O@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>

On Fri, Dec 08, 2023 at 03:52:53PM +0100, Patrick Steinhardt wrote:
>  reftable/block.c          |  23 ++++-----
>  reftable/block.h          |   6 +++
>  reftable/block_test.c     |   4 +-
>  reftable/blocksource.c    |   2 +-
>  reftable/iter.h           |   8 +--
>  reftable/merged.c         |  31 +++++------
>  reftable/merged.h         |   2 +
>  reftable/reader.c         |   7 ++-
>  reftable/readwrite_test.c |   6 +--
>  reftable/stack.c          |  73 +++++++++++---------------
>  reftable/stack_test.c     | 105 +++++++++++++++++++++++++++++++++++++-
>  reftable/test_framework.h |  58 +++++++++++----------
>  12 files changed, 211 insertions(+), 114 deletions(-)

This all looks good to me. I gave this a pretty careful read and added a
couple of minor suggestions, but nothing that would indicate the need
for a re-roll.

Thanks for working on this!

Thanks,
Taylor
