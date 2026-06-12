Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243E189B84
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781240014; cv=none; b=tLD1u6ZQHvg8nVy1tnBFd0nf1IV3vqzn0si1OM7mYoRJUe9FMjQIx+6CCjFVL9nW/7TiQNBG8j/EY9liy+H4HFhIHjDRrOswQ4YL6VOq83YfZ2qUtpL0LWqfhInAUV9jNRGl9pVqgyVhKYMVxBXK8NxswyM3+7pNa1Et/H3j1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781240014; c=relaxed/simple;
	bh=zD/jg0YdiSckGqwWxPOvoRw9Fvu4Zq0+9V3ZKK6fOa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXECFxZSdY8u+ppj0+cdhzTw6K9goxZEZzXOnLTiUEV2Jr6es5bi4vgvLXiwrSjBftYjGbOkLk6HulAOM+o4+Qbg0Y0xXrhO4I0lVTjGk2Gn/nFlcT30BfGEdFNPNVvo3cXzjlJSwbA5Sj4yKkiCTtp20F9d+5lLGMAJfIPSRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=asoXAwgb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="asoXAwgb"
Received: (qmail 113805 invoked by uid 106); 12 Jun 2026 04:53:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zD/jg0YdiSckGqwWxPOvoRw9Fvu4Zq0+9V3ZKK6fOa8=; b=asoXAwgbJM8q+enJXrI4JBeBY0fEg6LxI9ornvYQERvUwN1Bh3uPl+6lD6LQsI+vXM3NG+E9lXsLgToLQTAGGvwvSODxnxzvQSaCJeLFm9+YGHhyTnhQ6E9LK6o9LEHZif07nKG2tVYzmalhkR+MPnSfsKhAQcVvKtmvyuB46UOYNhrLw4gJl1G/vb5C7sKnCUtvN9BRKcUF9mXW/ZincpmZNuqSu0m0Ajps4FyYVTJu8ZXmzBScviffJ6H/PoeN+4qWHBYyB2DYYXRMIcmaLfRtowhqKwnTfmRp8EVse4hNm+jOG19rfZ4f/t033YOxzLvM/paWw2K6HA8JsV0dVQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jun 2026 04:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 333538 invoked by uid 111); 12 Jun 2026 04:53:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jun 2026 00:53:34 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jun 2026 00:53:29 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/3] doc: config: fix AsciiDoc glitches
Message-ID: <20260612045329.GA593075@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260611161946.12166-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611161946.12166-1-taahol@utu.fi>

On Thu, Jun 11, 2026 at 07:19:43PM +0300, Tuomas Ahola wrote:

> Tuomas Ahola (3):
>   doc: config: terminate runaway lists
>   doc: config/sideband: fix description list delimiter
>   doc: git-config: escape erroneous highlight markup

Thanks, this v3 looks good to me.

-Peff
