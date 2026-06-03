Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867F1EA84
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489427; cv=none; b=bewjFEO1rlBaJONjaMHo4NAxYtDhK+fQL2dxlXtbMkkmIpYmTxmoL7MgSXdE0aIigihkHmatj6E3c0CBjtxJ5O51FlaZOLmjr00Slz55VTDxubPb59+EXnKdxlXmddMsG/6cDn4s6MAjKdTPPSnZ5BglY00EbxhPfCE++GgbsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489427; c=relaxed/simple;
	bh=6I/vHVe2ugf8qmItrJtnP1DODSSApgkPOTbouCDXUE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW3W3MFzVWCUwEVwNVnEP5ktXnT1YTBcbKL6MeyJg6FXzdLlZtYRYwt+F6LeYH9nhlBSKYY4/zTCFM1dXGcOGUf5L4hBrepEw7jeUYw4UIHKovlHxoWKXwobyujZvrY2PWpoGi3in4xNDMVNpDDKlWYRXIYY+JoMeUUVNlv3yxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=i+rcSJLu; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="i+rcSJLu"
Date: Wed, 3 Jun 2026 20:23:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780489423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obGQ90YGO01jJxeqtDIDcv5hkpDxJLTjEE0wJpB8fnk=;
	b=i+rcSJLukJWnxJDck5dKZsTCdDPJFs0aaM8oxjqVL25au9eErMQCmjcTIfA/y4dOJq2vyG
	Y9SmAbKMVPk+d4LTMUdtoEKRuz9+AyoChNaszYKebCfqBRGYKlLhjfqmZOE0ucobA74daa
	JKOyv69ZK8ZcC6icTMcvoG+tpV01qLyv1a4jNPm+BjKX0iS53lqzT5tknU2Bnf0JeqhlEF
	7XDCy2i9oS9EBE9f/fmAcuTys+bNZk3azEqHvuT69Lb36AITpaN5y3bO8HWdmkDw0HlHZB
	JaCO+nFmTK4oKnsfAum0QKNHjpRcXyuQMediYBY+r16knrnlaHmU90/nTDcxbA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Tuomas Ahola <taahol@utu.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <aiAcv_p4bR1pNImf@wyuan.org>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
 <ah-Nhr2PboWUq6eU@wyuan.org>
 <ah_PyDwO1Sffr5yq@pks.im>
 <aiAK9eLvew+mgWt+@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiAK9eLvew+mgWt+@szeder.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 03, 2026 at 01:07:33PM +0200, SZEDER Gábor wrote:
> No, in Git shallow threading means that all patches are sent as a
> respose to the current cover letter, period.  It has nothing to do
> with whether the current cover letter is sent as a reply to the cover
> letter of the first or the previous version.

Thanks, agree

> Deep threading means that every mail is a reply to the previous one.
> Again, it has nothing to do with the relation of the current cover
> letter and the previous cover letters.
>
> Therefore, we do not recommend deep threading.

So the same reason with Patrick?

Thanks
