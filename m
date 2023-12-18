Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BC1E486
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRDpxFud"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so24181615e9.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920411; x=1703525211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmDUafQzMjbLkl67pLluLgOV8K9JTBynOlPtuxsqmgk=;
        b=jRDpxFudfMmoakS+TapoTRB3oWTaWtZnXTMbn7FVwewxelSO26wEDqqn/P1gtlJAuc
         zf8QbXFe8dGGF+w4lN6Y04gjwhS0RjSK9UucWmVVBXExGwPrZonmEYFvKJ8I1seiIy44
         uXu0s+MGyeOW3wtlxSNiq1lY2G9dFjPrJPZk2H5101Sxp/VBeHmhJ2UJwWEGLmJpsK0a
         FLaVv5zQuvmLm2DO6ob5rJL8UmmADC1siJU7990U3kgSfVjcX/Rnd3VTtAcFSJ+t1uuA
         xx6+eup0DVBCxoAMbqMGgzGmDY2HJkSlOQkjllcAiRgZEy50273VK3RRrfqGYMEB1GLo
         YSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920411; x=1703525211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmDUafQzMjbLkl67pLluLgOV8K9JTBynOlPtuxsqmgk=;
        b=K4N3IRktqtB3mvCuVE4p0gSUePV1YlxrnyYO1gkeB1Ld7+1DkNQGjDMb8fLcASTCKW
         fe+iCiTXEb03bJ5sZjRHU+Ct5cOBBWFMQsVdubbumJlEBdGPjUZlmOLxNO+XSEyh94D4
         7DxhrNZ5M2FoWU+i3vGpgUkXluGxekmZopTRU6XuuqF8hg2PYf3Q5kJLIC9y76V5srEe
         8wJXgVWN/D1WHDPnsahtztmnZ+pr99GlfECFnbFjyZqKAxbZ1tZVA75pP8cYVPn2G2kE
         30asc12uc8h4ckVWx7jBplL/lK9txDWFs24phUuV09TPUagMXRMLpkkzBnSaxovu99Vk
         Lw/Q==
X-Gm-Message-State: AOJu0YxB5zNARUqI/yEz8z1DQLCVEey0V1yohuJJehB/3gKqi7EU/Q9G
	6u2RMcnHZWIQyp9PeexZVwM=
X-Google-Smtp-Source: AGHT+IGpQ9E1uUvJwQa88XW5nw7LiuCZKA04LWZDZ0Qq/uZ4HKScEoHf417dUJsan7hPWSWtkBxT/g==
X-Received: by 2002:a05:600c:a42:b0:40c:6d52:6d3d with SMTP id c2-20020a05600c0a4200b0040c6d526d3dmr1407818wmq.70.1702920410589;
        Mon, 18 Dec 2023 09:26:50 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-39a6-bdd4-29ba-7091.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:39a6:bdd4:29ba:7091])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a1c85124b08sm14518063ejc.94.2023.12.18.09.26.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Dec 2023 09:26:50 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: phillip.wood123@gmail.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	mial.lohmann@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase-interactive: show revert option and add single letter shortcut
Date: Mon, 18 Dec 2023 18:26:45 +0100
Message-Id: <20231218172645.74133-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231218170912.73535-1-mi.al.lohmann@gmail.com>
References: <20231218170912.73535-1-mi.al.lohmann@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip

> Thanks for the patch, I'm wondering why you want to revert a commit
> when you're rebasing.

I know this is probably not going to be the most used command, but I
think (depending on your workflow) it can be as important as e.g.
`reset` or `update-ref`

> I think it would be helpful to explain that in the commit message. In
> particular why it is necessary to revert a commit rather than simply
> dropping it (presumably you're using rebase to do something more that
> just rework a series of commits)

I gave two examples - maybe they can give a hint on why this actually
can be a useful feature. Over the last few years I might have only
wanted to do this twice or so, but I know that I read through the help
string at least once to see how to do a revert.

Cheers!

P.S. I am sorry I missed the "v2" in the previous patch - I am still
learning how to deal with the mailing list...
