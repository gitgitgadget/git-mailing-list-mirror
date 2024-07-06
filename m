Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8822B9D2
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307617; cv=none; b=OmlsQbsegEHKvbWdLMbKWhcV1usTjJbRemO8gxs9j+88GkryPxag4OG7GSgTlucc0UstudHv613Jbarwx19VsNjysa2UzfYEEKdJcaJO7PtpAa4iKNrlhoRtkh2LADvDXF+BDYy34j/lHz3sS6U0recxf+9p4In/NsS88JqTc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307617; c=relaxed/simple;
	bh=j3Q9uaHHgqvk6Upv8Li9gIFS+QcEgS24Z7M4HB8wzbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqdMII+A7cYzd8UsqLRXILzG35xNJ6mJ6qoGO/NF8Ok89DhNNg6B9n9DROj14egFHRN75vkIjF28riG5O3wMMz6Qaje3Rlx3tIBdcq57QEYJqtzeJ7z5lF9rW5q+n083io7JCB/G671tnCrWvICP8kE2aYl/7m/0J7knoHp+KBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31883 invoked by uid 109); 6 Jul 2024 23:13:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 23:13:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7068 invoked by uid 111); 6 Jul 2024 23:13:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 19:13:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 19:13:34 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Message-ID: <20240706231334.GC746087@coredump.intra.peff.net>
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 <xmqqv81ovp9l.fsf@gitster.g>
 <bda01080-1231-476a-9770-88b62a75ffe2@gmail.com>
 <72b69a20-3f51-4f51-8ebc-ead20e3eebcb@gmail.com>
 <20240706061850.GB700645@coredump.intra.peff.net>
 <75a635b9-7622-42f7-b202-6991775e75f0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75a635b9-7622-42f7-b202-6991775e75f0@gmail.com>

On Sat, Jul 06, 2024 at 01:20:36PM +0200, Rubén Justo wrote:

> > I don't think we want to integrate them, but I'd suggest that
> > SANITIZE_LEAK_LOG should be the default/only option.
> [...]
> 
> I completely agree.
> 
> Let's wait for the dust to settle after the fix in this series, and then
> I'll address the change as you described.

That sounds great. Thanks!

-Peff
