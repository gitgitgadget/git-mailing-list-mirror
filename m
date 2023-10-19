Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB8361
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nCQapQYU"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A2FA
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697675053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92+B1Jnc5X7ur+r5j6nLWWsOeWnVcOjYtZULK/g4xhA=;
	b=nCQapQYUe2CxOehPW9hA/MNx68Q6XoaDK/azl2VAINO2ndcse40e4kk3V2PnoPw6atfLSI
	iMvczjIJjD7kjEOmX4er1CN/dtg3pmX3iz1RxOnX7umWS0DsRzGNlHr8zdYUBL0bpqab+T
	rcbdQLdPGtTm5xxiEKcDwm4l61B+tow9VZbUlZ7q1GHLdd/IQxhj3fCAv2QP7fAzJFACk8
	T1/EvHIVzCNLncnH89KuXUL5hg1gpyBd352AJ65AddhC4D0sz4GI5dwPw7yFwSez6szoxQ
	lhnlozg6nKoehD4YOZY10ydWMsjCTLZ/zXfYudAQujt+yTNKz4P1vEbCQD/Img==
Date: Thu, 19 Oct 2023 02:24:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: update list archive reference to use lore.kernel.org
In-Reply-To: <xmqq7cnz741s.fsf@gitster.g>
References: <xmqq7cnz741s.fsf@gitster.g>
Message-ID: <199df43378febcc746c78029c5f90d04@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-07 00:57, Junio C Hamano wrote:
> No disrespect to other mailing list archives, but the local part of
> their URLs will become pretty much meaningless once the archives go
> out of service, and we learned the lesson hard way when $gmane
> stopped serving.
> 
> Let's point into https://lore.kernel.org/ for an article that can be
> found there, because the local part of the URL has the Message-Id:
> that can be used to find the same message in other archives, even if
> lore goes down.

You asked for this patch to be reviewed, so I did it.  It looks 
perfectly fine to me.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  Documentation/CodingGuidelines | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/CodingGuidelines 
> b/Documentation/CodingGuidelines
> index 65af8d82ce..71afc5b259 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -24,7 +24,7 @@ code.  For Git in general, a few rough rules are:
> 
>     "Once it _is_ in the tree, it's not really worth the patch noise to
>     go and fix it up."
> -   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
> +   Cf. 
> https://lore.kernel.org/all/20100126160632.3bdbe172.akpm@linux-foundation.org/
> 
>   - Log messages to explain your changes are as important as the
>     changes themselves.  Clearly written code and in-code comments
