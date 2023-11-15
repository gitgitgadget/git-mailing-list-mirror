Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639965A
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="OaT5qXQZ"
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EA10C
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-280b06206f7so896225a91.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700019292; x=1700624092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ninc0diSIYtOw+8aYeqtA//nHmqODeF67cg3XthRWLs=;
        b=OaT5qXQZ3fShvFjmAgmRzh4jLlZKPx8OiukzMZA1LbykZpSSiSVnqfMfYEXjoHt2mN
         j0CK/+QigUsFpufYrc2oKupHmCV42Ld4Ziy52uoYnW6vmoMet1HLXUp8pSuPkqnMgy4l
         Wsg5bEvufC+9hf1HWMckoy0PNsv+HCYAyi3szBCP244hWyEHRsrI88FvxwJ64f2a+u3Y
         iF0dfoPeBrqW35VP/FfUuk4ICPc3PGmVjErHYMgT37G+mt8x77PPYWBedUE1I3NJdYnh
         ELgAy0RuXT9xLAguv436bm/5zXFGprGPySq/kz0OtHoThXg2iveT4G0agGQJ3K180NfZ
         740Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019292; x=1700624092;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ninc0diSIYtOw+8aYeqtA//nHmqODeF67cg3XthRWLs=;
        b=mdr8XGwzZLeXUKvN9cGuJ1EL0cilMg0IUlLLlBeqJUzfwGlq3JnAAqF+9RLfqKQuay
         jezAvvDAvyGSgtoDyn8R5IXjNhCa9rrs3g/eGxI8TbIB3wCpt1/Limd1+eFKaBS3/60d
         CdvzN3i25OtLuEFWU8IDayfPsW6ayZy9p26hv9otj8YbXQnMth/m09NRErXWuSfa70nh
         5RFTzGuf8mARaKEd23tmsEeNbi9s/XZXytZN+X3z2YlmH6hBXSzBqhxS8vnp1CLnPSu6
         zdQYP7A4jaFp+iTbB9X9pmuLKIjTMfZMdWQ8lLkyaTvIiEsTgF2ox8LKwwYoqmNOWHSN
         VXKg==
X-Gm-Message-State: AOJu0Yy3NuOwnYaaLLgKmDxUCELBgpD2lKDi5DwFZYfCrjZ1XT5ZKnIG
	pjlPSUdiKRkW0V/DWLBjfjhKpJDfxfybWqSPqm5n1cj8QaBBBg/89mc=
X-Google-Smtp-Source: AGHT+IFggTw1/xyAC38z48D95BT5WT010shHbpK6H0BnIl3xTh4YRSa1GMy7x85EJfpZbAYGLA7WoBKt4FFBnntMSjU=
X-Received: by 2002:a17:90b:8d6:b0:283:5405:9e90 with SMTP id
 ds22-20020a17090b08d600b0028354059e90mr4035324pjb.3.1700019291774; Tue, 14
 Nov 2023 19:34:51 -0800 (PST)
Received: from 305313025478 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Nov 2023 19:34:51 -0800
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
References: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Nov 2023 19:34:51 -0800
Message-ID: <CAGE_+C4mUw8U6YK0m6hRvcqriv4pWdsELpyRJBCY-LrdHjWwgw@mail.gmail.com>
Subject: [PATCH v2 0/5] Avoid hang if curl needs eof twice + minor related improvements
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Proposed changes split into several commits for clarity

Jiri Hruska (5):
  remote-curl: avoid hang if curl asks for more data after eof
  remote-curl: improve readability of curl callbacks
  remote-curl: simplify rpc_out() - remove superfluous ifs
  remote-curl: simplify rpc_out() - less nesting and rename
  http: reset CURLOPT_POSTFIELDSIZE_LARGE between requests

 http.c        |  1 +
 remote-curl.c | 99 +++++++++++++++++++++++++++++----------------------
 2 files changed, 58 insertions(+), 42 deletions(-)

-- 
2.42.1.5.g2f21867bd5
