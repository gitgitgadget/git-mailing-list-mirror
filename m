Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E45233
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VW3pwE8T"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31BE4
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698905648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZJfzDNx2MKASU/ntCxTci7vb+rlz0KieWpg7mNP7xQ=;
	b=VW3pwE8TMP/zwKoohoMY+6EiW8zYA5BPxD6N2GtnZkYrimh4ErCxHE0DNliPZh8foFye99
	iRdy3BjLe3sT8OqbBdYtsxjcMV4JYEiiLiopAPhjd0rS4rXOdLQgc7ybzBCrSHUcGFoHOk
	1pRB32BdI5Sb61KZjD4OOQX0qiExHXr3g6OStgjCB0I8ABD65aDxKwjgfKh6N/30JMldBH
	QdK9ZfP1IWMWfOpfCVNCPQOKUxXq0rXscaYDsIng+cfglky+0rwzZZTjLy46aS/0xSnqc6
	JFcMkSPaRWUnkIlWGUyYfBhPJMI3WXKohRGL/SXsBEw8h+D/nXy9gTon6M1Niw==
Date: Thu, 02 Nov 2023 07:14:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Thomas Guyot <tguyot@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Christoph
 Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <aefa38cd-d0fa-4dc6-8d10-4358e36b39af@gmail.com>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
 <aefa38cd-d0fa-4dc6-8d10-4358e36b39af@gmail.com>
Message-ID: <20889d91b28af0946c7f2f226561bf2c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-02 07:01, Thomas Guyot wrote:
> On 2023-11-02 01:48, Thomas Guyot wrote:
>> Hey there...
> 
> I obviously thought about checking this client's setting the moment I
> hit the send button - if the response is garbled I'll resend it
> properly.

It's in HTML format, which isn't the preferred way, but it's still 
readable.
