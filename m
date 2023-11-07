Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9F28E2
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QNEIKkH0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB7BD
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 00:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1699345282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GSfnNvPfPn5JeVkJP6NXlnZg4rhJwrvhrk0Hjdrsug=;
	b=QNEIKkH0DD9Iw+bGQ7b5Ie94+83Ocrm7jeNCHvZuLibJl1QQdIK8iJzE8Lm/NKSsenGgV9
	WS0m0n8cwtEuZ+iZ+mp+67xTczg0O0iZe69erYMXOQQSUEPCIyk/FR+7lb+3jPG0lOKzgN
	z6MhNMgjvVUbRuwrFxr9DYejtHKZ3ttRVktm09ImyO5qR84SQeEMarMI9j4dfM1RD5Kdkd
	Q8+PvTySxVasxi8bbIWwaZk3ys098uTh1AxJkMX+XsxikL3jIJmRQXSpHamGXqkbsRa7sr
	FqqZdaazYhc08cFsZwlnpVnh29BXBIPFmmfcqJPAlC984XH71LCg8NUZZ/AIkw==
Date: Tue, 07 Nov 2023 09:21:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Elijah Newren <newren@gmail.com>
Cc: Sandra Snan <sandra.snan@idiomdrottning.org>, git@vger.kernel.org
Subject: Re: first-class conflicts?
In-Reply-To: <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
Message-ID: <6f15723ef86a40e939b98b731cd8026e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-07 09:16, Elijah Newren wrote:
> But we'd also have to be careful and think through usecases, including
> in the surrounding community.  People would probably want to ensure
> that e.g. "Protected" or "Integration" branches don't get accept
> fetches or pushes of conflicted commits, git status would probably
> need some special warnings or notices, git checkout would probably
> benefit from additional warnings/notices checks for those cases, git
> log should probably display conflicted commits differently, we'd need
> to add special handling for higher order conflicts (e.g. a merge with
> conflicts is itself involved in a merge) probably similar to what jj
> has done, and audit a lot of other code paths to see what would be
> needed.

That would be a truly _massive_ project.
