Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198470;
	b=CBaRTb2yWWCUSun0TxtfNcEfzrqAtIiEa5Y1xZlrxGZFVMMQpw6SFFiIFyKWKC/Svapw
	 0NUf/mTji3+U1VRgrcyi+nMZ3tf6y7a5KAbaY7yOXBPpU/VMFz6HWkXyoxJgLsijSxlk/
	 CHx10MRN7nLwbs+ntxYWpMR9R0xuV3e4wMcv94tv5vNlvg3/INLtAx7nu4Doz3OGuOtSR
	 JjjiPrGW4Po1W0S/PoXkV6UW5SsKD2xEKCQiM0RkQeP9saYMbFVe/npxNeI/avQ1BEk3C
	 /0SedE6f2FuswNIZf6dTFeglIK7X4Lm7/JvNnPlxZfyd7Hs4K+XZbfA+mJj0vgehqWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198470;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=5c03eNqK5ygfTu1bEtI/+fjPef2c0cVUonmr9VeDJVc=;
	b=LIXjkMlxbGrVa3ZdzZznEpEofBZRtspUeb3EovhBOZC+6Vva7LHbQFbNvE/lq2b++plc
	 LSxVkUNJAYuaTFclN9MZn1C1QWA/4/ipDkkE6J/8rxE54h9j3PV64DYWd8CPnJM/rHyiT
	 +EOZDZbmQcgBiLiMR7BWU0ZQ+t8Ep7SkmgAzd4zz3Vbyv9Y02Fq0zMH/91vgDi/fLOoUE
	 ZiTFNZoTqLItcsIqH4jQ8OOGSV0Tt91Yxy10L9RROXHVD5UPNJOW+JIp6WMOQwBVQ+Mbw
	 tPV4RC/lWwgn7GgEY0L0tKrB2F6sPxOQpEwVwpsddIWyFdplP+jlgxWz3j9t/TynzoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	arc=none smtp.remote-ip=91.218.175.1
Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7157606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7157606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OkMD9vmufR15p7Kbw3fJx7NziJgqjqGVEW+1xPuXY9o=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793198460; v=1; x=1793803260;
 b=yZQxlZfPxUByfxXYwLbobYj81luqLvyqeqxGwbFNvkK0Q9mPNT2ghaGy2i6tWk1JqBnmOuSC
 nYcrS0W9Y3CLSkbKB/ASHhZQE6GNuvvjvZ35H0vIa1WAc2Tk2ulrFcIdqPq1NzGdKfXVJHmNW2s
 kp41pmsnHVybjO7RLlVHCAwk=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 450bb91ce3f75c4f;
	Wed, 28 Oct 2026 14:40:58 +0000
X-Mizu-Trace-ID: 450bb91ce3f75c4f
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kaartic
 Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 0/8] ci: consolidate test variables
In-Reply-To: <20261027212431.GB774120@coredump.intra.peff.net>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261027212431.GB774120@coredump.intra.peff.net>
Date: Wed, 28 Oct 2026 15:40:54 +0100
Message-ID: <87mrrxzy4p.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Oct 27, 2026 at 09:18:20AM +0100, Patrick Steinhardt wrote:
>
>> this patch series consolidates our test variables as a follow up on the
>> discussions in [1].
>
> Thanks for following up. 1-7 seem obviously good to me.

Yes, 1-7 look good and are pretty much noncontroversial.

> I'm lukewarm on the final patch (and left a comment there), but if you
> really love it, I can live with it. :)

I understand the stance of both of you. To be honest, I don't really
have an opinion. The cleanest fix probably would be to split the build
flags from test flags, because it's a mix now and Peff prefers to have
them all fixed, while Patrick likes to change them run-by-run. Although,
that would probably lead this patch series beyond their intentions.

-- 
Laters,
Toon
