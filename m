Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860402FFDCC
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764406; cv=none; b=Dfzn2A1yKK8muvlsaKozYSydQAqb8Q+l+pgRqHQTNVinD1Sv/OQJIM3u+I8rcuAHHcS4GPf/Es4RAHEQDOv9vpW1xBg7PaBxsAbuMH0KIcEF9S9635xFM/4NET/wSAig+H5ZSMGHHgtoC/wSENuJXjOZfOcXBNSohaUTvrYlFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764406; c=relaxed/simple;
	bh=GwAD+5exPxVjO1R7f1OUW6eaXaxj7hFXNr9Ea0ymrpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjxjLcN5aZU9GH1lAarD3MEPupmGBLQ9PrOT/uBHqSidVrZ5m4h7zVhJKCu5KgjQWh0uVVyp4ofg9yxmng8kdOs0MJ95kyktSIwZnxcCUHFwhHilvTK8Jdm6JRgGv7zrPNnc0b1XT5Ltf07Cpn52vupk8CIh6O8kCgIrrOQf22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=g81oS48b; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="g81oS48b"
Date: Tue, 17 Mar 2026 17:20:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773764402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OVSDJ3g7rC5kZqWQOH/P8/+5Wn98uQHSVDHkHdAbn0=;
	b=g81oS48bVaIH49BIs6IVy9tASiQsQ45wsCdJo738K05hCf4UNWNuwwZbGeqksXjs9mFm8c
	gUqAhsLi2EW7xlbpnbcp9RiejAdMv/qACFCKdj5HQIZG65oVa4wEjkh9O6k3V1YNbayoPF
	LZyKDaRUxCf0S4f93bn5JVqoYpbnp4x5LpC+NxCr9RPs0Sg5P071Bm0bqOluNrI0g0Pty7
	5RwvgAjftNEQs08/bgW4+OH/877y9qTbI3sZ8KxefRHd7ys6b/6yi9DsMRSUmYnVyKHo0j
	kV3b4FZoMoiGR8l/CoYbmRgWHc3DtVK8bCy3eu/vDZLgYEypsTL7NSP77GYLvQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH 7/7] format-patch: --commit-list-format without prefix
Message-ID: <abl-29SN9ChGkkzd@exploit>
References: <cover.1773530191.git.mroik@delayed.space>
 <aa7802b653a44838ef78f5ae4a82b341c9853b33.1773530191.git.mroik@delayed.space>
 <0294b771-2d0b-452c-90c1-82baa8344689@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0294b771-2d0b-452c-90c1-82baa8344689@app.fastmail.com>
X-Spamd-Bar: --

On Tue, Mar 17, 2026 at 04:29:23PM +0100, Kristoffer Haugsbakk wrote:
> On Sun, Mar 15, 2026, at 00:20, Mirko Faina wrote:
> > Having to prefix a custom format-string with "log:" when passed from the
> > cli interface can be annoying for many users. It would be great if it
> 
> s/cli interface/CLI/
> 
> s/for many users// ? It’s a general assertion.
> 
> > could be dropped an it were still accepted.
> 
> s/an/and/
> 
> But maybe instead:
> 
>     I would be great if this prefix wasn't required.

s/I/It/ :P

Will do, thank you
