Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D636A50
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743985472; cv=none; b=ZJTriHA+Wd8wRgU4WH8ZkR9ykgaw0+YGj2HaJ/C2NkgVY5y32U8SoJ8FX3KK6QyNOwUu+mSjFnmx0mn14Fs/V5mvbNA9nPjkf74jII2OPRJ+winoiR7rkx9JYmFq4EZOJzD1dJ0wXv1+XFWtMu8s68shco7JLgm8HXcwB2o9zS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743985472; c=relaxed/simple;
	bh=7W+dEY4DOPTm+i5Gjvv8XTNSw8ugj/86V8CPBzpkkb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qifsR8A4M5J8O2zxiYsv5XNkH2rG5m9BVW4W61+qxsflqDl/ZR9gXCGgcLMqyBQ6aoQAe6a7AxEtF/rVfhc/KIzCFYmNZ5h/mmi5i47CyGWW3J9/ap8SyZafkz73ekjIYy5MWvr9PQEDwpeGDVwmUxTHFbvkUECEtQZ9j/iFOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8fa2d467fso6024506d6.2
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 17:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743985469; x=1744590269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W+dEY4DOPTm+i5Gjvv8XTNSw8ugj/86V8CPBzpkkb8=;
        b=daokXc75JE0L4AMBHzX+qWOLKGglyTpkoirHLsYzYpRujoWg/4t9sqW4semNJmt4Ru
         9vcHbacj9aOHPUifavfopU219uFrhLiHxh3fomoptSopMV7kkg2Fk0a5AtmeMBlztNpa
         /Lwyw5eWoxIL7gX1YdHKJHVuH6cPIC9l7W7hDcomFbB9wM1s2i4G6w2ymUilb90kZuy9
         MbVweF9/HIhm7LhNU4DbCnrsE//Q/gbcmFJhbMwDirp9ZH7wkkfz/zDWNyzhcXn7LXSg
         PMavus7u9DTTJXaxpKlx2RLC2tKFFEHrKcF67vFnqwhr1eOKPqyjhWt58Hl6uhwN3kpd
         +Q9w==
X-Gm-Message-State: AOJu0YzJMTTyCXSFGJ4evw0Qz7C5Gp2+Wpprn58krQeH+9OEZQdnGQOZ
	8DH/0gZCUQqvFw6rmu4vqnP1IaZjQPZJW339UpbuEjgLmcSPm5bb8KcSLCD6ntI9Wlcioq6PRQB
	znlfqyoPmFpwiZmjG00YavofsR8c=
X-Gm-Gg: ASbGncuLOXXtVj592z1WY9pRToO4+y5Z8VEW+yojzslzh1CDx1XC34zwBmVySzLaOqb
	tB+vSaf54ZXVrFJp8tsztv+tFhe8T+VXSuweOIGZO0jQ2+xbIxaYvMk0pxFUX9dG1eppHoyqrzj
	TC2EZMo3krE0kCE/2Fym26GQLkHeSWycEjS/peGt3d24C+33AXDZbdr/uFa3k=
X-Google-Smtp-Source: AGHT+IHkxudGC9qjAlua9VFouAN+QYV3KU/X9oMezqR/nLzwvBklFolmYhd9C0KyYIraSw2PVnCOnEUScnphU2/1eCs=
X-Received: by 2002:a05:6214:cac:b0:6e8:9f7e:8116 with SMTP id
 6a1803df08f44-6f00df1d8d9mr52218946d6.5.1743985469233; Sun, 06 Apr 2025
 17:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
 <20250406121513.154084-1-usmanakinyemi202@gmail.com> <20250406121513.154084-2-usmanakinyemi202@gmail.com>
In-Reply-To: <20250406121513.154084-2-usmanakinyemi202@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Apr 2025 20:24:18 -0400
X-Gm-Features: ATxdqUEwUCWY1me_gpHvDifqZgmazqHjDwUr2u4g2rjaeCbNi7KhYrMVMEcJ1ak
Message-ID: <CAPig+cShdouOzG_jKz_Z6+bSprZ5ZEsx9wZR-_LuD1P2kaOWwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] builtin/update-server-info: remove unnecessary if statement
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	johncai86@gmail.com, me@ttaylorr.com, ps@pks.im, shejialuo@gmail.com, 
	phillip.wood123@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 8:15=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> Since we already teach the `repo_config()` in "1a764cdbdc
> (Merge branch 'ua/some-builtins-wo-the-repository', 2025-03-26)"
> to allow `repo` to be NULL, no need to check if `repo` is NULL
> before calling `repo_config()`.

Okay, makes sense. However...

By referencing only the merge commit in the above message, you force
reviewers and future readers to chase down and locate the actual
commit[*] which taught repo_config() to accept NULL for `repo`. To be
more friendly to those people, you should help them by instead
referencing the commit[*] itself.

[*]: f29f1990b5 (config: teach repo_config to allow `repo` to be NULL,
2025-03-08)

> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
