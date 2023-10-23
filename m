Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027B18E1B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Km3LJMgj"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A520E10F5
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698095958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NxvxLeaO95OH5aSSO4qZD641fbm9DbVoDavPoglO/c=;
	b=Km3LJMgjs0nvEi3YdI6knLpmjJ3II6YB6bDzQD2YrC73gJPrAGXuj9OUmakvrmS9J8BbBi
	KNCaif0d0f9+2cAy+jpYQP/YPcP7ERlbB/T/qphwF/SRQQ0iJfylTH19t7gQ7NbFVNGQJf
	ZHo5GR7wjaj7xhdsFZuQhbqdBu22qmoPCHOBYWJkI4QM6ceuYFx0Zrt3OIYc6XiKRp2c3r
	7NpXfcQaZZZ2YlnCtkDesuDgO+zNQlNG/NRD5wrxqQnBvnVmp0LhVuCcsAbEP/tjOnLYnP
	i8ktxs2DW6l3F9uH96vQtI4AuNrsXgL7sWZ/z70z5WInzecW225xJR/ONDKY4g==
Date: Mon, 23 Oct 2023 23:19:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTbiU+SwvGi9972S@ugly>
References: <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly> <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly> <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io> <ZTbVY7Nf+DTYqHky@ugly>
 <d55eaf41f55bdff0b5ae734e5d7e6724@manjaro.org> <ZTbiU+SwvGi9972S@ugly>
Message-ID: <2d392c7a7a00bd2c66efb17a2dbc86d7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 23:14, Oswald Buddenhagen wrote:
> On Mon, Oct 23, 2023 at 10:51:31PM +0200, Dragan Simic wrote:
>> The hint should be about how to turn the tables and verbosity on, not 
>> how to get rid of it.
> 
> but that's just backwards. a noob shouldn't be bothered with putting
> the tool into noob-friendly mode, neither actually nor "just"
> psychologically. switching to "expert" mode should be the conscious
> effort. and making it opt-in wouldn't even save the experts any
> annoyance, as they need to opt out from the hint anyway.

Let's focus on non-noobs as well, which could go nuts by having some 
strange tables displayed after updating git.  For the beginners, having 
something configured is already inevitable, e.g. their credentials, so 
they could also turn on the tables if they wanted so.
