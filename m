Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC64347C7
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817824; cv=none; b=OskyBB4UONHDX43DX6K+Grx82/3MXPn1dszur3fP4nX+7q+QMLEQ1YsckElv31wJlbti1JWn9ZBY/k588ppGI9JB/r4iS5vKyH1gtOCQNKzSAV++i0LGg/Z1/xI1WEr6jF+5c93U/fUkVgygCRA88nzpCk2+nJ545pFKFHJJM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817824; c=relaxed/simple;
	bh=9BYbdhBCn0SzQbq6WCDBPX/IkY2K1teaJzWeS2Oqdws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MckrCHR/q6AiTfd5yYdCc2d3h5EvDkZsP9HlDkEW9y9GAzy+eQx9ij6YS64g2HoUoH67gqGUYs9qUJTjyUpl2xLkDIkFMc/k0T2EyVJD/RONhwQryvPdmz+DHPVeT1Uf+FKmhJgfbrNWKAULQ/8gqzqx2hvkH3eOH5OTv3veiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=SDmrd61O; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="SDmrd61O"
Date: Wed, 22 Apr 2026 02:30:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776817821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BYbdhBCn0SzQbq6WCDBPX/IkY2K1teaJzWeS2Oqdws=;
	b=SDmrd61O3LOg8GLCqaXKrytalinMXl00U11wpbyT8gvsEvEG+2zLhXVS14yOKbzTM2C+Zr
	v3D3h5m4wSuWzbvU53GVtJhkfeliqQdnu5ZM994r3d1zxWalBxIEPjO7WMKZZ5jH0JXAyi
	XxDuZt61sBZVJZ87Q5ZlSxUVCDzBwvUi3omUTK+z1+t7zu9i4VXKI7ko319wPL+PrFjVFG
	VE8DsfeOkMOgCUEr1VJFSCddM3+HuQNjuA7vwrJK8xepK6vwFSp0zUiZn64SgX8G+Ch/Ge
	S4oy1W16XEel4FY+fNoN3XUqySKZH/E4nHhtrxSKVm72qk9br9CpqFcfIesPzg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/2] revision.c: implement --reverse=before for walks
Message-ID: <aegWh9h3V74o7A96@exploit>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <20260422002840.303477-4-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422002840.303477-4-mroik@delayed.space>
X-Spamd-Bar: /

Sorry, I forgot to thread it
