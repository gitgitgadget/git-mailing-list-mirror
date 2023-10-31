Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EB22326
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="u/WMn+mA"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6876C2
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:24:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-418201cb9e9so43240851cf.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698780249; x=1699385049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYqrhhnCNMqvd4t5kEM7gTmsRYUTv9t7HjT+F5v7xkE=;
        b=u/WMn+mAd57yvYOynhagtMsjWne2J9K36B3tD24XMH16J5lkBm4oOYKA405vRfHS1W
         ApCs3WBv2pV3fl6TpZueP2v3yhJIh/iPnEYxQX7DgDZnEdNzSMjS1tpgG6B6vtp85umN
         MFbYNRc1HX1Dctd3D6id6dMlxIdZopBdm+DSh6pviRw8xyfG0I2rkcqykZ9u+HcpTkKe
         8xb1Izma34t4ekoaxnnfyWind+/M5LeC3GdGYatNV+ESAYSt12ugF1HhJ/s/Fao+Mcz1
         byi4ZGanhwKKitSeR8M/DdXNpo9FQD2LCMBhIZsxHXJqN9DMr2FGCjeFvkg3figDg9Ce
         JI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698780249; x=1699385049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYqrhhnCNMqvd4t5kEM7gTmsRYUTv9t7HjT+F5v7xkE=;
        b=q/3l3BXH8oKZQ1V1hVRUeWYKGVWh8Ke2TPCzkcXUSfBh+j0XGsbzyQSnfkCPenx1GA
         QCIqR7ZTjIKemuRWjpI1gK8cYrnnLUc7S2WeyiS8NUs7PHkinfAcBTLq4OsNxejWvtzD
         8kdj5/V52CtVI/G6T2DaYsn4DLZrmGYSFIcpAUjW/SK0I4h7bf2H9/fp40+A3lmI8fZw
         mtYjSBXxXMT4LgROc4zwKL9sw+4ILrZHzGgNjWeC6iK7be5IFdHTDwixdlb7+HdJDM2B
         Dxlzf0Czkh4RP1PfgtR8nOhP+byZHeJ6ox3dZldeBb6xMc7jCXYL9zHMQkJo7E6Xtlw0
         P4Gg==
X-Gm-Message-State: AOJu0YyFnFggOQV+aT4kxsb2fnH+/z5N5I8Da7pWlEE9UcBnOguAsR8M
	ZpFrkOu6jYVfiK5nab2JupFp+xamr/c8tywQGM4y9w==
X-Google-Smtp-Source: AGHT+IFUSRqulltaEUvDKCaKNVxSzfrFaWXHPrB6qh+e0OQvqcewF1T3Ta93nEc3lVwGeFG8GFXB7A==
X-Received: by 2002:ac8:4e47:0:b0:417:d340:c426 with SMTP id e7-20020ac84e47000000b00417d340c426mr17541834qtw.9.1698780249504;
        Tue, 31 Oct 2023 12:24:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c10-20020ac84e0a000000b00410ac0068d0sm737069qtw.91.2023.10.31.12.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:24:09 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:24:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] Documentation/gitformat-pack.txt: fix typo
Message-ID: <92e9bee4ad39906c773e4a6eba84ec1ebf8c1d3b.1698780244.git.me@ttaylorr.com>
References: <cover.1697144959.git.me@ttaylorr.com>
 <cover.1698780244.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698780244.git.me@ttaylorr.com>

e0d1bcf825 (multi-pack-index: add format details, 2018-07-12) describes
the MIDX's "PNAM" chunk as having entries which are "null-terminated
strings".

This is a typo, as strings are terminated with a NUL character, which is
a distinct concept from "NULL" or "null", which we typically reserve for
the void pointer to address 0.

Correct the documentation accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-pack.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 4a4d87e7db..c4eb09d52a 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -390,7 +390,7 @@ CHUNK LOOKUP:
 CHUNK DATA:
 
 	Packfile Names (ID: {'P', 'N', 'A', 'M'})
-	    Stores the packfile names as concatenated, null-terminated strings.
+	    Stores the packfile names as concatenated, NUL-terminated strings.
 	    Packfiles must be listed in lexicographic order for fast lookups by
 	    name. This is the only chunk not guaranteed to be a multiple of four
 	    bytes in length, so should be the last chunk for alignment reasons.
-- 
2.42.0.527.ge89c67d052

