Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B91FA4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MWNoVz7+"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD87C2
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:24:07 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-672f5fb0b39so13790066d6.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698780246; x=1699385046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/PSG35uLyCRkbueQYq6MhxTTe2QrJ2aZ35LAonQMnM=;
        b=MWNoVz7+DSm8HxsiW0BJy3AEHYJ/BYvdGyUb32mIJfkgPWDb6526a2uYcGi2xourDO
         +4qsSKCYaxzRw8Fq9dkSoK5pTW9lHA9ckQf9b+xnxLx2naFdL4zrEmf3MS9gWqW0hLS1
         QEClfbKGEDNMotuX96NroGNYfu6ueDE0l/HWWo/qdANNCLKaOHGxQHNGTTn4My4y+cnH
         C3/n9ADIBZDaiio60L02Ng8ZGLA76ZypiGpWSW3CJirl6Shwpa/N7EpEMd75u6+HTVlb
         Lkgyit7UjH7MSYAmYaytKnqsfyX/3bV26ygUDth1pqqNr0GXzrKQuKRoIMP/Dc+tz3wj
         xkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698780246; x=1699385046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/PSG35uLyCRkbueQYq6MhxTTe2QrJ2aZ35LAonQMnM=;
        b=UBJoHs/X/2CxCnfkTVVJEhse77As8zUCIuTVL0qRb6DoqXTHS9y82o0Rtv1EELjo8z
         Ve6bktlc6Cr+I3Q8odxa/3/o9p1KMJhIpPL6KXy9vExm3GhCG+OBm9p5a2yNeAZxqdEU
         wKt8jv3J0EE1XmtmWY9ALjLZsdX2CcusDpxhtNie6TS2UK53kRojSI8fh3u8j9QQT+6k
         O+brDaG+K3AV1Nqh4c8I0Nt5oLdPvddWSexV/q2wsfaO1D6di6fhGOZf3ZQMSA2mMxYh
         w1Q0MHGHE9C42EKMnDmbi5TAYijtOnSTgetVIKwBoIxDL6zOk/meTyesK5cRWoHKXm4V
         rPhA==
X-Gm-Message-State: AOJu0YyekiGDQMVzcENLiQTI6oHsbmFYE9aHSAltE7Wp+BVuWvphPoWy
	o7J7kq94eEhl8CfdtO2EOeLiWIkLPf5h+u1k9C72AA==
X-Google-Smtp-Source: AGHT+IG44EdUFcrxoqZwYk7fUpCT5etmIeguemqAGqv0bjxOonhemSMWccPY0d7kPXQ9YSDyDd6p9Q==
X-Received: by 2002:a05:6214:5019:b0:66d:10fd:4abb with SMTP id jo25-20020a056214501900b0066d10fd4abbmr16099652qvb.16.1698780246532;
        Tue, 31 Oct 2023 12:24:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q12-20020ae9e40c000000b00774309d3e89sm765266qkc.7.2023.10.31.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:24:06 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:24:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Documentation/gitformat-pack.txt: correct a few
 issues/typos
Message-ID: <cover.1698780244.git.me@ttaylorr.com>
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

A minor reroll to adjust the text of the second patch to read more
clearly, thanks to input from Junio.

This has been rebased onto 692be87cbb (Merge branch
'jm/bisect-run-synopsis-fix', 2023-10-31). Thanks in advance for your
review!

Taylor Blau (2):
  Documentation/gitformat-pack.txt: fix typo
  Documentation/gitformat-pack.txt: fix incorrect MIDX documentation

 Documentation/gitformat-pack.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  8c5fa1ff4f = 1:  92e9bee4ad Documentation/gitformat-pack.txt: fix typo
2:  af2742e05d ! 2:  c149be35a1 Documentation/gitformat-pack.txt: fix incorrect MIDX documentation
    @@ Metadata
      ## Commit message ##
         Documentation/gitformat-pack.txt: fix incorrect MIDX documentation
     
    -    Back in 32f3c541e3 (multi-pack-index: write pack names in chunk, 2018-07-12)
    -    the MIDX's "Packfile Names" (or "PNAM", for short) chunk was described
    -    as containing an array of string entries. e0d1bcf825 notes that this is
    -    the only chunk in the MIDX format's specification that is not guaranteed
    -    to be 4-byte aligned, and so should be placed last.
    +    Back in 32f3c541e3 (multi-pack-index: write pack names in chunk,
    +    2018-07-12) the MIDX's "Packfile Names" (or "PNAM", for short) chunk was
    +    described as containing an array of string entries. e0d1bcf825 notes
    +    that this is the only chunk in the MIDX format's specification that is
    +    not guaranteed to be 4-byte aligned, and so should be placed last.
     
         This isn't quite accurate: the entries within the PNAM chunk are not
    -    guaranteed to be aligned since they are arbitrary strings, but the
    -    chunk itself is aligned since the ending is padded with NUL bytes.
    +    guaranteed to be 4-byte aligned since they are arbitrary strings, but
    +    the chunk itself is 4-byte aligned since the ending is padded with NUL
    +    bytes.
     
    -    That external padding has always been there since 32f3c541e3 via
    +    That padding has always been there since 32f3c541e3 via
         midx.c::write_midx_pack_names(), which ended with:
     
             i = MIDX_CHUNK_ALIGNMENT - (written % MIDX_CHUNK_ALIGNMENT)
    @@ Commit message
         So these have always been externally aligned. Correct the corresponding
         part of our documentation to reflect that.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/gitformat-pack.txt ##
    -@@ Documentation/gitformat-pack.txt: CHUNK DATA:
    +@@ Documentation/gitformat-pack.txt: CHUNK LOOKUP:
    + CHUNK DATA:
    + 
      	Packfile Names (ID: {'P', 'N', 'A', 'M'})
    - 	    Stores the packfile names as concatenated, NUL-terminated strings.
    - 	    Packfiles must be listed in lexicographic order for fast lookups by
    +-	    Stores the packfile names as concatenated, NUL-terminated strings.
    +-	    Packfiles must be listed in lexicographic order for fast lookups by
     -	    name. This is the only chunk not guaranteed to be a multiple of four
     -	    bytes in length, so should be the last chunk for alignment reasons.
    -+	    name. Individual entries in this chunk are not guarenteed to be
    -+	    aligned. The chunk is externally padded with zeros to align
    -+	    remaining chunks.
    ++	    Store the names of packfiles as a sequence of NUL-terminated
    ++	    strings. There is no extra padding between the filenames,
    ++	    and they are listed in lexicographic order. The chunk itself
    ++	    is padded at the end with between 0 and 3 NUL bytes to make the
    ++	    chunk size a multiple of 4 bytes.
      
      	OID Fanout (ID: {'O', 'I', 'D', 'F'})
      	    The ith entry, F[i], stores the number of OIDs with first

base-commit: 692be87cbba55e8488f805d236f2ad50483bd7d5
-- 
2.42.0.527.ge89c67d052
