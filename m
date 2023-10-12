Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C633588C
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rMrrjPcd"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE3D9D
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:09:23 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-777252c396bso91257485a.2
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697144962; x=1697749762; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1fyNqOYoua7WoQ2jUrdbDNSWr32u+nWtVLFP05SnPk=;
        b=rMrrjPcd2Bsfu0NxNfkkztBto0aH42hqaOHV9/RtGcktbfvLMivPUUq4TByWYEwuEX
         WEBKzgbo/LvCjR9zj5iuqrscSlkVbYW8sphEUivZVQhJ4kScFq15S++Kq4GRU3WsFfNx
         A5RvZscfYLuCzMhrQFelRnY/uVK6dcNMkxjaO6GLE6cFTJKkJcX4M0lE7QYo3NPe7KGi
         /vOG80q7pSwd/C1ugkByTJWJy/IuY6+/dC5jAdtMs0thxhRpCSgYYML9cDj3UQ9sMa1s
         Cr6wJ+UjmFirwakU/AiOgCOAux72Sfa4uTZr3OkO/bPOGjGtZnfURX6mpw/VvCNByVFP
         dZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144962; x=1697749762;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1fyNqOYoua7WoQ2jUrdbDNSWr32u+nWtVLFP05SnPk=;
        b=PqUsqBIKlmKOWxoW4K5KIX9eIoOqg/7gTJc9Ru2O9qSkH71+Ms8xztwAH2N7UvS0kY
         GOlqoix+Ssi2p1x9REp2PzRo3GguRkfe+WiIovq4DvCXIPiApO0Fd8BGmmU84AzEF1FO
         rFRSRV34p2TiaF7a6D1tJgcvywZW+4MYqsEKrntCtFF80GrTCKRx1ICgBHqhsJIa8qfY
         ss0YpAcd34pt2OhB/t7dQL9yq8F4JVDfPIFd7ImO863navwEK+JUsCVYatovStHftbq+
         lkPDGuqnlYdXRzFuFCv5pIW9aZGO+TX7Hc1um2n/BxhgqD/Brm5qEfNQcnTHqtJ8bGbP
         i7Cw==
X-Gm-Message-State: AOJu0Yy/+bl/PPClGpEm2+qHZpSKf6whUGdxOm7XwVAANo7NNzm7JK7T
	48p1t9j4byN7jQucV6FGPCEeEp/gehB3ivX6rBqAdw==
X-Google-Smtp-Source: AGHT+IE3It/XuQMZcjV89KIbfhP8yFI9X7zBFE9kmrDTLegqoEBRCfYv17NdFLxR/EeDUzBlf5Nopg==
X-Received: by 2002:a05:620a:45a5:b0:774:186f:4d82 with SMTP id bp37-20020a05620a45a500b00774186f4d82mr30210340qkb.50.1697144962659;
        Thu, 12 Oct 2023 14:09:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a158400b007759a81d88esm96056qkk.50.2023.10.12.14.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:09:22 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:09:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/2] Documentation/gitformat-pack.txt: correct a few
 issues/typos
Message-ID: <cover.1697144959.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These short couple of patches are some fallout from a larger series[^1]
that I'm working on. I noticed a couple of minor issues in the MIDX
format's documentation, and figured that sending these patches sooner
rather than later would be worthwhile.

The first patch swaps "null" for "NUL" when describing the NUL
character. The second patch corrects a piece of the documentation which
claims the PNAM chunk is not aligned (it is externally padded and thus
guaranteed to be well-aligned).

Thanks in advance for your review.

[^1]: The broader goal of that series is to allow verbatim pack reuse
  from multiple packs (instead of just the bitmapped one, or the
  preferred pack of a MIDX). This is only possible in certain
  circumstances, which require some tweaks to the MIDX format for
  bookkeeping reasons, which is how I noticed these issues in the first
  place.

Taylor Blau (2):
  Documentation/gitformat-pack.txt: fix typo
  Documentation/gitformat-pack.txt: fix incorrect MIDX documentation

 Documentation/gitformat-pack.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.42.0.349.gf0c1128f8b.dirty
