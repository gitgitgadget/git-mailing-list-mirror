Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325B12B61
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="g5PkErCb"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2610C8
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698096405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llrQgCZ16hRCu1Epaj1kFLy/qZks/pbBQcgOTAVh3l8=;
	b=g5PkErCbAZBmvbdmbidaD1PlC4RpdUYLgbFG1/9M/8zEyC2agwLfsI5mk82QRN+AJ+FLC0
	D4o3mb+RtPT13gm4ZOXjXYahxAYDDvNEH971uXE4zd0Csi6Cpr1t3ZgzJZCCJNc6/wt81B
	BHnrt1tofdAVLchj0Wzrj+wDVECsWmd6fz9xmaqhFQj8ZQhoQ3PqbRlnSJIedZAsjCBnhR
	PRMM9pT0XpPOoplL+VuyBbyCFy3jBLHzh8AGBRG5guz1dOEq70jY56ogf02iL8ngZqmhhF
	s5HCMqhyYUAROj3P6B3V6KpohcIE97J4aC892wXCKY8YX7qoNFBtMrz//B24ng==
Date: Mon, 23 Oct 2023 23:26:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Junio C Hamano
 <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTbkUUbmp56fgc+a.jacob@initialcommit.io>
References: <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly> <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly> <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <xmqqfs21noxx.fsf@gitster.g>
 <18c7b1bea07d5f3878f4466b8e133da1@manjaro.org> <ZTbb7bHkFOOyBT6+@ugly>
 <c8e437eacdb883f612ae44e43c95602f@manjaro.org>
 <ZTbkUUbmp56fgc+a.jacob@initialcommit.io>
Message-ID: <8c661ea94ba42f60eb87d1d6d4530947@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 23:23, Jacob Stopak wrote:
> On Mon, Oct 23, 2023 at 10:59:08PM +0200, Dragan Simic wrote:
>> > On Mon, Oct 23, 2023 at 09:04:49PM +0200, Dragan Simic wrote:
>> > > That's exactly why I already wrote that the original author of
>> > > the table patches, if those would become accepted, should commit
>> > > in advance to maintaining that as the new git feature.
>> > >
>> > that's seems just a wee bit unfair (the bar isn't put that high for
>> > other features), and it's not realistically enforcable anyway.
>> 
>> Well, it's a bit disruptive new feature, which is also quite extensive 
>> and
>> can rather easily become obsolete if not maintained in the long run.
>> Perhaps we should hear Jacob's thoughts about that as well.
> 
> I would love to work on implementing this and maintaining it! I spend
> too much time doing Git things for no reason anyway so why not? :D

Awesome!  Quite frankly, I expected to hear that. :)

> But... I could die at the hands of an angry user and then you would 
> have
> to take over, Dragan...

Or I could instead try to help you fending off angry git users? :)
