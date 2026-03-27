Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BAF1A317D
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571104; cv=none; b=ESBzMqSpnzAsIfxfloS0ASV0cFcrTP23qolKxzpmrG+acAzeazFMzkrz1woFR4fsM3ACAnRO+ePVpyvK3eaEvma29sL4IUTY1nXJ6pM5nd0/I65CsrEo5iPN5B9okojYP5trYHNRwM0Cf9pqnPch641y16tUUFHc9LacAJvuJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571104; c=relaxed/simple;
	bh=r2VT06wjLUsl9mwQk6R80GF9i0GXoG5GVMRgIuYNma0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhZKj2VeHCWmdndiHr8OPbg7c1QdOy+cOjAmeVmN7FHNqPZyeg/THRj/gPD2NfNtKQIx3mGlBj2p9+MF2axYm1B6gPTVcaqdOHb5pabksDb9B+OJSpImaMCbgutUbx+aVTgVbsy1tkRxlGwFEOmUvcm8Ofd8P+qgtz0esiM4tmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=b9EdOtSJ; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="b9EdOtSJ"
Date: Fri, 27 Mar 2026 01:25:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774571101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2VT06wjLUsl9mwQk6R80GF9i0GXoG5GVMRgIuYNma0=;
	b=b9EdOtSJ1DN8hJQnXZW5dAFKBaeMeBsXgfO/EQFdBbIePtuk6teHRLyh8i3PlI9F1uBKn1
	Q6D432LVijqMM9BOizqGECwr9UmhIiuxCy8bJfHH01IXYFSE8SoupmB4HiaMb9C7T2rXDi
	IXK5EHy8A+0jF6FQwQi4dgRfG4aWKdU1S/VV0EUcuf2lSw220t93igeWADfScWix4s/G3/
	k4FzauamH+UmtbgcEsnOosxAXvULX6rH8SnKT2GBpx3oGMD4DhLtAr2t76jlTLYr/JIDu2
	hpZYkvLwcVztV/Lvl3ZbnIB024iF21Nad91NlW8B24IAeopq1JLuhabrdhwwdw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2] docs: fix --commit-list-format related entries
Message-ID: <acXOAMKsDpyN9Zkx@exploit>
References: <20260326185541.17523-1-mroik@delayed.space>
 <20260326200643.20251-1-mroik@delayed.space>
 <xmqqse9mnwv8.fsf@gitster.g>
 <acWbpJTRusOv6bPk@exploit>
 <xmqqo6kanvpn.fsf@gitster.g>
 <acXM3e23Us-mJxeE@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acXM3e23Us-mJxeE@exploit>
X-Spamd-Bar: ------

I will wait for tomorrow to send a reroll just in case someone wants to
comment on v2.
