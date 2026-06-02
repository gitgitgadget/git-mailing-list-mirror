Received: from mail.luna.gl (mail.luna.gl [141.147.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871D187346
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.147.12.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418149; cv=none; b=U1z7a5LsiNIuV3BA/+umI3Zg2hzLDJeGzbuaJvOEjGY/MrzmBP0RqhAW7XmONcUuR/AtQKz/kMy5bYpk4gbjKxCGz2JSnSy1U3Rz4rKl+Q3ugeQWDrJawh1psCrkksu/vqIuymNtLmqJ8JN6FUw0mXIyjGBjuLJAFhiR7x3H4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418149; c=relaxed/simple;
	bh=G1/2urZVnsrintjiZAFEhbkkF2N9yw2ONG2ruYK+zZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0JoUrQetuC9UP5d/WtGd8mFKUovZG5bfWtOIi3HSsuQeEYV+/ipZlXLU5E12oMLqFkwncyB2jzDR4xe2OBO8UMQ7b7JxO4AGNaVfUC7zuFByNwGeqlSkGMwswqwg67daLElylXNLVdU8GUKFPx2PTUuTqNUy4JqNc+aoVCtWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl; spf=pass smtp.mailfrom=luna.gl; dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b=gM1pvc+G; dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b=SscH3nMM; arc=none smtp.client-ip=141.147.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luna.gl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b="gM1pvc+G";
	dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b="SscH3nMM"
DKIM-Signature: v=1; a=rsa-sha256; s=202405r; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780418141; bh=ej/dILIi/79JZfq1yXQLbKS
	UxvfRGJCckGjxAaSo69I=; b=gM1pvc+G+5DWqgGZ+L0SD2gmzy2TC+Gjhyk+m8w93SAzGTM8jp
	YG9FshsvYrLMdKXkH+kcqvPnh7oBYJM3RzkZMfOzzzkn3q1z8hwmUjy9A3/gDIWzRhyQieizD+a
	kdmRl9RPRGuJaMZ2qWc0pL8PNUEAmsttt8JgW+in4rluruyIM39j1/fxdf2GVWKI+hCE//Im8qi
	ojtKw8OeH21McT1ZRcU9aTHDJjTbsENBj76De+tWFjKY+7Qek1WbrTGcZa+MGmEx38KbAntYiY8
	wkarMpxBj20+vkvIbGim4e6MnqQ+CjSXuE96wj9G/JBf1yhL969uT2wk+0O0osnxEnA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202405e; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780418141; bh=ej/dILIi/79JZfq1yXQLbKS
	UxvfRGJCckGjxAaSo69I=; b=SscH3nMM9frnlqezUM0oX09aJrLjDjX6cwWJ9owj9UfZnHjddh
	iILhPz8nMZoCVhNJU2lxVCj8Z2PlP/Cc2PAA==;
Message-ID: <8b2c15f8-0233-4e52-9412-9412b42756a8@luna.gl>
Date: Tue, 2 Jun 2026 18:35:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: document and test `@` prefix for raw timestamps
To: Junio C Hamano <gitster@pobox.com>, ps@pks.im
Cc: git@vger.kernel.org
References: <20260602081924.673763-2-dev@luna.gl> <xmqqmrxdxq1r.fsf@gitster.g>
Content-Language: en-US
From: Luna Schwalbe <dev@luna.gl>
In-Reply-To: <xmqqmrxdxq1r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks to both of you for pointing out my mistakes! I'll make sure to do 
it right next time.
