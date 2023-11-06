Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D22E638
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XRrUXkT0"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB6134
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 14:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1699308078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8W++ht9ff/vazKtrgl5RUifDetsOqd6nvcv8HHmotps=;
	b=XRrUXkT0gVgbewSq7bjjotX+VBQL7ISpt18F/YUQMA2iYlEke5Z/WDgX2r3hw0UcD6Vp+v
	PBswTzClOIRsSvBE0CJh//ioV11qqhA+bNpiuu0UVv88DlsnpqYVI54dS/y0nj+dAmabEV
	w+PDU2IQxzHqISg5aD3f3/Uf5yBgNPl5z1PDQnf9eYanvZogdUabkhNQEqSQvTZQQ95Pzo
	1VWflKP4AbkxunUdXSGmfNJAQl7qvXoPXE+1XgVUodxX/PEmmH0VT+2ej2dNP3bVKq4VEQ
	3gzR0Wf3E/h0aQDOHY43Qs2iuv7BE1GKiJRR++6k+SE12aGFL//vNRzGxoILkw==
Date: Mon, 06 Nov 2023 23:01:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sandra Snan <sandra.snan@idiomdrottning.org>
Cc: git@vger.kernel.org
Subject: Re: first-class conflicts?
In-Reply-To: <87cywmintp.fsf@ellen.idiomdrottning.org>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
Message-ID: <ef30a484525157579c64249a396f10ae@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-06 22:17, Sandra Snan wrote:
> Is this feature from jj also a good idea for git?
> https://martinvonz.github.io/jj/v0.11.0/conflicts/

Hmm, that's quite interesting, but frankly it makes little sense to me.  
See, the source code in a repository should always be in a compileable 
or runnable state, in each and every commit, so going against that rule 
wouldn't make much sense.  Just think about various CI/CD tools that 
also expect the same.
