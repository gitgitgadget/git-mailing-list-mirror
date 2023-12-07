Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWqAQoia"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DFE121
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 21:46:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d098b87eeeso4794735ad.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 21:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701927996; x=1702532796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/Le9/tQ9p5V95C3wbBYq6xeWlJdQOwtDuaFuAcyM/s=;
        b=JWqAQoiaky++FQox1NyaDN3JreFR+WymY4wxVsgjq084yRkfxTvdLHB4gw2ak5oXkM
         Hig5SUZkP5xplRfMth5aPW8kifnKeoDfYIzVAcqenfMJ73fyyjoeX0C4t6LwdpoCd4P7
         ubNUypuUBozHk1T4j6cuEIzPf8S/E73Ab9Tkn6PhBjtSYg6GnRh8RVN4NPdKjmtONrh0
         LWUPX93floA4pDYOJ3sB9eg3t+pSWlSD61MijVnxBqRppRe2i1Gbsg9p7MWHZjBZTQbj
         RMPxLN3hESGw8gb9bFW9GbDtfE9J7HYTh2+eHqQnh37dxso9pdPvcPx9zmfU9I5P3Sy6
         mgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927996; x=1702532796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/Le9/tQ9p5V95C3wbBYq6xeWlJdQOwtDuaFuAcyM/s=;
        b=lvUcZaI/BzY6qDl7uKWPiK1yrPYQv5KoUoyZsiPWWa+cR+3dGNMWe6mhpzr5KYqbYo
         tTLpKnutQD/AxCG7AqojKblGdJUAIC1Ez3BOQkK9a1mnIwsAoByU/swyHzgJped4QvzU
         rTKA8Bme1/C54HM5bhgkmc7rIUkF0dGZFS+pRKgDL99AqNv5HbLZqglB+OP78VwOPERL
         Pb3Yu2zK5BtqQ5lWbkBashC4KNhisdoMQ54n7GqEWw53//p/P2V+BPnWDFN2HlVT+9zv
         gK2T6g9npCtyGsM0bXZwozsevL2qofagTa+EJMDpr4LrdboFCWXNDShSkI1UiudfOCqx
         GNmA==
X-Gm-Message-State: AOJu0Yz2gbirfPAhe4vjZIsA0Y/Cehu1PqwW2qqoLW65woOL6UuyxGvZ
	LECUVvWhJ4ZFs49VqXrUcBW+Y14lp0g=
X-Google-Smtp-Source: AGHT+IGXAjUG6Rc65ubs1LOmKsgbNxwzfuoQ70zVOuERkRm6RJ+RmAgO72oqMdXRj7za5p2iW6mT9g==
X-Received: by 2002:a17:902:8215:b0:1d0:6ffd:9e09 with SMTP id x21-20020a170902821500b001d06ffd9e09mr1972052pln.91.1701927996086;
        Wed, 06 Dec 2023 21:46:36 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902d89700b001cf5654fc29sm428209plz.72.2023.12.06.21.46.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Dec 2023 21:46:35 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH 1/1] MyFirstContribution: configure shallow threads for git format-patch
Date: Wed,  6 Dec 2023 21:46:26 -0800
Message-ID: <e197cbd28135df5523ff5ba1688566edb831f037.1701927372.git.stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701927372.git.stanhu@gmail.com>
References: <cover.1701927372.git.stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most users on the Git mailing list prefers to use of shallow threads,
but this preference was not documented. This commit adds a blurb about
how to configure this globally via `git config`.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 Documentation/MyFirstContribution.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 7cfed60c2e..3ac7455b1d 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1004,6 +1004,17 @@ determine the right way to configure it to use your SMTP server; again, as this
 configuration can change significantly based on your system and email setup, it
 is out of scope for the context of this tutorial.
 
+[[configure-shallow-threads]]
+=== Configuring shallow threads for `git format-patch`
+
+It is common practice on the Git mailing list to use "shallow" threads,
+where every mail is a reply to the first mail of the series. You can
+configure the default threading style of `git format-patch` via:
+
+-----
+$ git config format.thread shallow
+----
+
 [[format-patch]]
 === Preparing Initial Patchset
 
-- 
2.42.0

