Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C136BCC3
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632722; cv=none; b=HSKodaerNwh0uFH+Z6w9vtgE9eL7fJDiM3XB8q5PurfftdeSKe6MiRkFGiJzzrBgMMHtL0CqKJUPjNS9KGYdP/yYgPPYlh6mY7d/A6TTxmmaK2NfuWu1tpVqYyW/3eONYldj339XyT3XZ5604tCJQyDQgJMyoIREI1BW7E14K64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632722; c=relaxed/simple;
	bh=T8+QH984+WL6FknlOlSJ172sZM8d/amwRpFGni5rHOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuzjM1z3EvDJ/7TqOddrffeZMAxwopSlvFxD1uFICh9ATSTBjE0PKXkI7VmNWGsnTqeZrsrwZk24btY6JNQa95oyCAFA6njQKZInDaprSBMtIpYz/UT7UvnuaFByj7dIr/rJ1CO7gq4Bstt+vPPeXUv0Kt7UMUbv3S24/ym1A/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=MI8P7Ygx; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="MI8P7Ygx"
Date: Fri, 5 Jun 2026 12:11:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780632718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYLyeti03n7IpQlqh13m4IyvjyPrZTmU3foMoFtFVqE=;
	b=MI8P7YgxpqHKEyxdKChnH8khMMO169v+lab3pMYzL90KFIaNaasp7JWlQXJiAGgPb36PWJ
	WCgM9+6xj7+OzamRbgMMl7xwVOHWb5f0vV5sUhtaxI5bcziJELb4l7ua5vaLJqrSvemXSu
	LhIDF05mkA9LzoTeqtPAVmLuCbZ9KJLvSnCvla6I04eeod+3DpxxqutzVJtQ+DedfPO5KI
	+z3Ne4wabxxHPQRc9Oh5Y3a0RzRTCOQkTKzXoKzbSAC5LwVjymFCHxTAG0figuDoutw3X+
	n3+288tygjMGWxvKyvvMRof4aA0OhcZ5QmYXed393ckmeZHG+k85B9qpizuMYQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove redundant 'instead' in
 --subject-prefix
Message-ID: <aiJMenfKL_T_5KYG@wyuan.org>
References: <20260604163510.36687-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604163510.36687-2-lucasseikioshiro@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 04, 2026 at 01:34:42PM -0300, Lucas Seiki Oshiro wrote:
>  --subject-prefix=<subject-prefix>::
> -	Instead of the standard '[PATCH]' prefix in the subject
> -	line, instead use '[<subject-prefix>]'. This can be used
> -	to name a patch series, and can be combined with the
> -	`--numbered` option.
> +	Use '[<subject-prefix>]' instead of the standard '[PATCH]'
> +	prefix in the subject line. This can be used to name a patch
> +	series, and can be combined with the `--numbered` option.

Agreed, this reads more smoothly.
