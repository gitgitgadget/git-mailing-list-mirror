Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549E3E474
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xLjjiahG"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7997C9D
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:09:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77574c2cffdso119343785a.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697144967; x=1697749767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+I6NYbABdM+77+APG7gv6fXgIFEGwOyElEoe0rWZ9NI=;
        b=xLjjiahGx6s7xLuecuvQbAH9CiMIysIGRHBOgzApnZY5h1KEb9MdbupBow6J9WdUaH
         bxMju/86lazvMBdnshoB4QKj3YrC/Qa2KA7uR0hyGIoxDJaJLW5pZFLVqYCjofTTPMmQ
         repdibcubWRNogwKFxCQP41B3ca3NILOmsMcMzj8lh2lJQ9nwUWt5HfFe9J2PJ4kysaU
         D8JaoLTO6uEZfKLKSfyVYSLVQ/A7lxpFksCaaetPFnmy9/imckXzH7iFLfVgLxLq46ta
         vf2Fs84LLVZOkDAgFDqwSo4rfjXgFiG+e5NIgBVe5ZFSk/gvzh42bp8E8apNqCwfosE7
         6K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144967; x=1697749767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I6NYbABdM+77+APG7gv6fXgIFEGwOyElEoe0rWZ9NI=;
        b=WUsXgUdkfblbee6AmLPlFSrpBSN2afpvtL6xnBWLPQzTXyGyEdjmHdiyE6TjlhFl7X
         aFXMr3R+sKuStsMyzx76XneJKAeY4jioGV6r23ID4JgtlTdub5tH5/T+FNkM+VculwAs
         +bLpNTSkPH9nU4oHATiiH/FOnHH5vfTEhIgYOCJPo+jGufygFjCP/a9KtNqWkxL5/t40
         lIjIYzW+i0KriO9xgPhSUh8imNtOSL+xc6E+pQY78YsUIBVY8qJNi3Upa/UI5JxGPlj2
         RKLV5ZJQtXhimxkxaBja4TRKrw5ublWr9rb9GcEjSwuLruAA3cdIX0K1inUR/UrIRIfd
         rgZg==
X-Gm-Message-State: AOJu0YyC/B085+zoJV0yZRl+11b3DKhkgoCYCfKVLhKv+clckfGW59WK
	M/UQA+MdUwlszUZ+acbbz1sW/5nwhczMZ1/4agOTXg==
X-Google-Smtp-Source: AGHT+IEixcmUV06STer5kJyT/Kc+CyEHSivDersfa/Yi4WPnmC4pcVoLvXPzVRPV0tlE++anoGmWcg==
X-Received: by 2002:a05:620a:19a4:b0:767:8546:b374 with SMTP id bm36-20020a05620a19a400b007678546b374mr28583131qkb.14.1697144967474;
        Thu, 12 Oct 2023 14:09:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a110400b007757eddae8bsm95578qkk.62.2023.10.12.14.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:09:27 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:09:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] Documentation/gitformat-pack.txt: fix typo
Message-ID: <8c5fa1ff4f1fc069094b5acbc70cd0808742fd24.1697144959.git.me@ttaylorr.com>
References: <cover.1697144959.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697144959.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 870e00f298..d7153962d4 100644
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
2.42.0.349.gf0c1128f8b.dirty

