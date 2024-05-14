Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6E180A6C
	for <git@vger.kernel.org>; Tue, 14 May 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717142; cv=none; b=NQxcqVYPYyb2GJoVgqJimC8I6bEGlO/kp9KLUqTlSjApdoRmC4S4eR6SvCuQlI+3sLe5ZnQFaKCBsr4evDh56rr8PN7UDYWdBZkP+mGZyVz1leAT2Q/wRU01pFgF3O/LmH+9QdT22ClaZ7GzsDP8PtroOm5AD/V02pWYK3gGyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717142; c=relaxed/simple;
	bh=R3GH/KzPGmrJvGdu34k8VGXWLxHChcanp8b++4W1KpU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdZuWf8VdyXZBT6B1JOq8knqvEwXPkCVa6Ypeod5qZbX4H7Nutmg/DJBH/A9kfjZyiFc8JyrHfbLnT0YrBlt1WtUeNjIj6J35QNmNGclAs+L15guDJruveXEl+gvkvbE6ThItdm61UTGBu6XLAYvLHw6Dlbw7UGuOq9WXtiYq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SXPZa6Fw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SXPZa6Fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567FFC2BD10;
	Tue, 14 May 2024 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715717142;
	bh=R3GH/KzPGmrJvGdu34k8VGXWLxHChcanp8b++4W1KpU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=SXPZa6FwyoB+MnLtLvApPPCfLUeBaOijMx8eJwaiu5GHXD21Q4TxUQeEomdQmX1B5
	 Q8/+tQc4ensdiA0htS2490f5e4+JlivLq5roV47dpqrhPyD06AQ/iyR1ecDAtv8Pck
	 +2vBGNnSsjrkTYzBzygiIQQ/ec6FA3sIuRIVPR/U=
Date: Tue, 14 May 2024 16:05:38 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Dimitri Sabadie <hadronized@strongly-typed-thoughts.net>, git@vger.kernel.org
Subject: Re: Author signature
Message-ID: <20240514-demonic-quartz-hog-be2bd2@lemur>
References: <D19KZ1CBA7JF.27PYPL5X68543@strongly-typed-thoughts.net>
 <ZkPA2Pmz2EB6SOzL@tapette.crustytoothpaste.net>
 <20240514-lively-potoo-of-sorcery-0028de@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240514-lively-potoo-of-sorcery-0028de@lemur>

On Tue, May 14, 2024 at 04:03:50PM GMT, Konstantin Ryabitsev wrote:
> [1]: https://lwn.net/Articles/973217/

Fixing the link:
https://lwn.net/Articles/972467/

(Unfortunately, it's still subscriber-only until 2 days from now.)

-K
