Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E131A587
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpowwjHZ"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC199D78
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso30175875e9.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871058; x=1700475858; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=60CDpxddrWJ1O9fcRpYgYhSZj6C9YJxxvhUrob+vPL8=;
        b=JpowwjHZt/nYqilYR+suFrzcAObW9hSO/lDhVNImiFh0e5AEOya56knG3y/p3Furli
         Ww+2onRywA3VoIXvJczV+yE44H8wvnYtCNk81l/93u/kmYIbks194PGVgN46/HhHopcQ
         byUu/GBAD/1B/ZEWlOPVW/FWELnn4i0IMiUBEXhtCJYY7uM1AYS1sVMlI9hC0RtWQUpK
         D1bobUjwdFLyIgA8KgYD0vvzPWyrizhANEEAXBnq0gf6yWbGaLkCGmbOpAwsN3GpaIsL
         oDBjqHwxOwUCZhM9DkZEsWglxa3+w2JZ3IiWvd1jnDTJfUR/RRofiERYaJRjiGsv7kmY
         tJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871058; x=1700475858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60CDpxddrWJ1O9fcRpYgYhSZj6C9YJxxvhUrob+vPL8=;
        b=Jw5ZmlmmjNt6R5P0qYGs2r1faLNf3ukGuiFH6+HaIBlrXt92j7UNk7s54q2VO0oHJG
         buHxAfPuatAJb7ZX+UVmvJiuSiez+i//N4dJ9MxP8egsTcU0mGDWeFW3VlVGu9JHMnRu
         /VQ4tMVjcHd7zByi12BJ21O+SS3yLnEsp/Mo7PUn8aSJd3o4nfEC4CkfbNYKUIwhrY1C
         iYzG18PwQUKcw9ygF5iBzJKufjkBQNLJ9rCrtxKg9asi+DRTmTRaBPoGaHMjRXS0EF4x
         Fy2WAAza9Jb4m7ET3k4CA2P1smh7cmp7Rl+AWrNO9XV01WXB5bvYPWMZ/bm6DJ+r57J7
         oIRw==
X-Gm-Message-State: AOJu0YwWbyAKMKt4NaP4FyLHEGAdleAay1JIBe3c6RewP+nJIgFtOQR/
	HY+XD6fPd6Zp3Z9CU8DaIRGIqbDnE5Q=
X-Google-Smtp-Source: AGHT+IE/tA27Xc1Ex/aMoVUWjf8nIaTvWuj3fkhlo5YGXViblVWVuRAZPv5woBgLhQPWgKgAGyvaHg==
X-Received: by 2002:a05:600c:34d6:b0:409:703c:b9b1 with SMTP id d22-20020a05600c34d600b00409703cb9b1mr5533743wmq.40.1699871057647;
        Mon, 13 Nov 2023 02:24:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hg12-20020a05600c538c00b0040a4835d2b2sm9107883wmb.37.2023.11.13.02.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:17 -0800 (PST)
Message-ID: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:02 +0000
Subject: [PATCH 00/13] Enabling z/OS workflow for git
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Haritha  <harithamma.d@ibm.com>

z/OS is an IBM mainframe operating system, also known as OS/390. Our team
has been actively involved in porting Git to z/OS and we have made
significant modifications to facilitate this process. The patch below is the
initial configuration for z/OS. I also have few follow up changes and I will
send that after these changes are approved. Please let me know if there are
any concerns.

Haritha D (13):
  Enabling z/OS workflow for git
  Enable builds for z/OS.
  spaces and errors fix Handled git pipeline errors
  fixes for build errors Handled git pipeline errorse
  fixes for build errors
  spaces and errors fix Handled git pipeline errors
  spaces and errors fix Handled git pipeline errors
  platform_name fix Handled git pipeline errors
  strncpy fix Handled git pipeline errors
  strncpy fix Handled git pipeline errors
  strncpy fix Handled git pipeline errors
  Handled git pipeline errors - Memory leak
  Handled git pipeline errors - z/OS enable

 Makefile              | 21 +++++++++---
 builtin.h             |  3 ++
 builtin/archive.c     |  6 ++++
 builtin/hash-object.c | 28 +++++++++++++++
 combine-diff.c        |  4 +++
 config.c              |  7 ++++
 config.mak.uname      | 20 +++++++++++
 configure.ac          |  3 ++
 convert.c             | 58 +++++++++++++++++++++++++++----
 copy.c                |  3 ++
 diff.c                | 11 ++++++
 entry.c               | 26 ++++++++++++++
 environment.c         |  3 ++
 fetch-negotiator.h    |  2 +-
 fetch-pack.c          |  4 +--
 git-compat-util.h     |  8 +++++
 negotiator/default.c  |  4 +--
 negotiator/noop.c     |  4 +--
 negotiator/skipping.c |  4 +--
 object-file.c         | 80 ++++++++++++++++++++++++++++++++++++++++++-
 read-cache.c          |  3 ++
 utf8.c                | 11 ++++++
 22 files changed, 292 insertions(+), 21 deletions(-)


base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1537%2FHarithaIBM%2Fenablezos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1537/HarithaIBM/enablezos-v1
Pull-Request: https://github.com/git/git/pull/1537
-- 
gitgitgadget
