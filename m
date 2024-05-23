Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7A5B5B8
	for <git@vger.kernel.org>; Thu, 23 May 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455313; cv=none; b=tKTOqefHLrhVUwnMoYJ3nvmiAu1nJgpBYhkZAUJQsZwp8q/amH5V3GzJ6OGI4hRoplyZ1Gs+Z4swegiWlkbju9pUdOexmUdCLwI3QWIt+fPMd12M5rHLDltWmZwMKiZ2aT7S5zLPaADhLlv7mkfmesuRjyg9OQ0XOzjZXZ3SjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455313; c=relaxed/simple;
	bh=PhWvXiiVya6AwUxfWmpwarKV9oB7P3DLIx2Ho0wyu9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqbEdeKnsqLFfNlTZUDLCkor/eFStH5SI+Z79kvab18NBRKp0jt03sWAGuZBx8hN0Fu+X7+FMD8owoVb6FCWxtSdCPjb1dOeFwhHglSnKL25ODhsO6YWWqaoCMCiZBruEyMFQCaTcaXGrocv3PNic8h2qGnKWj2kISH+C50AUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31102 invoked by uid 109); 23 May 2024 09:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 09:08:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28461 invoked by uid 111); 23 May 2024 09:08:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 05:08:34 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 05:08:29 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] blame: do not mention obvious default configuration
 values
Message-ID: <20240523090829.GD1306938@coredump.intra.peff.net>
References: <xmqqpltd4rfu.fsf@gitster.g>
 <51e30846c62a1605dee8fd5b9d096222@manjaro.org>
 <CAPig+cQ7bq8LKxnmjY3FQ9MRpM0GMep1Nxyp7jasB8yJvTV-RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ7bq8LKxnmjY3FQ9MRpM0GMep1Nxyp7jasB8yJvTV-RQ@mail.gmail.com>

On Wed, May 22, 2024 at 03:19:58PM -0400, Eric Sunshine wrote:

> For what it's worth, when reviewing patches on this list, I have
> multiple times asked submitters to mention the default value when
> adding new documentation since it saves users the trouble of having to
> discover the default either by experimentation or by reading the
> source code. So, I see removal of mention of default values as a step
> backward.

FWIW, I came here to make the same comment. ;) I'd rather the
documentation err on the side of being overly descriptive.

-Peff
