Received: from mailout-001.p.bluenet.ch (mailout-001.p.bluenet.ch [138.188.175.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F4377016
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.188.175.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891181; cv=none; b=ikmfi2DSS8TImzUarYRq5bSAagXIYJy01VRypDWzRPDv9wJwFjXKjAni8oOgfWD08mAY9oqydnf2fOjZcgZNl2/E4wJXwhx3iyiznz+ezHmPs68HI259AHxL7oAP3q7+LYCEWwB8w42usbRI5hijcwVey6LgmrhJZ6o0HYygypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891181; c=relaxed/simple;
	bh=DzuLQSAowmKM+i3UZy0maaIaELTXh78EWJ4BJqx+SsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSQb0Pb3lMf+x9i9kfNi10ypjTyoL/BFaKdombjUdrW7GN6bpxjKn4ea4ttwFu1T9AWukQyVpsnEQeR0W/ld+yH0EspJWLUpKvoxvlvgsM6WPi+vCbDAyct5deSZfehR22HSyMLlMIF46a1oa4raltuHv3L7ZCvd9ZNruqF00Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch; spf=pass smtp.mailfrom=bluewin.ch; dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b=I8gmUIv9; arc=none smtp.client-ip=138.188.175.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b="I8gmUIv9"
Received: from [192.168.21.108] ([79.154.91.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by mailout-001.p.bluenet.ch Swisscom AG with ESMTPSA
	id 7GGwwKHolDkrf7GGwwLCBQ; Mon, 30 Mar 2026 17:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluewin.ch;
	s=fxzs-2048-20230414; t=1774891171;
	bh=f9gswnZAO4f+2qIn8wnoS86vXWhaWTDNngcBV2EiKcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From;
	b=I8gmUIv9eIQ1nQWFSmuUQHEcJEqAy9+6EbIjq4oGpCKIb23HPnC2jNgb+V7CPje+j
	 ClWrU1oROaeoUNDS9hoBv2I8iFysAaKQ0DyQU6lpPNPIG/KUGl70NM9jc+PzKeSk1v
	 LpcM4TrBJMirR+RX7AFlm1L2emxiTk8OujnX2BrglBr8tfpsntYfIh0OukJfpObSdr
	 RnqmJDNtWddoRiwBpImMfMK8PDcO24YCBc8dTbIa8a99MTXMSdFTEoki4HjORd6m+A
	 ZGWXMLZpmMmVwmLyfcWGJJRRJMInddJ83pN3Ql30NBp9BpJaE1PyWK+zMd507BivrU
	 WY2D5Vr7SetHA==
X-Bluewin-Spam-Analysis: v=2.4 cv=SMtykuvH c=1 sm=1 tr=0 ts=69cab0a3
 a=WY6/0jjk7zsOyTa5/3SlqA==:117 a=WY6/0jjk7zsOyTa5/3SlqA==:17
 a=IkcTkHD0fZMA:10 a=wxVyoDmmFkNog-E37iUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Bluewin-Spam-Score: 0.00
Message-ID: <d99d841f-4284-4734-a34f-4cd1d5c36938@bluewin.ch>
Date: Mon, 30 Mar 2026 19:19:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: fix "git stash [push]" documentation
To: Junio C Hamano <gitster@pobox.com>,
 Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
 <pull.2255.v2.git.git.1774877075694.gitgitgadget@gmail.com>
 <xmqq341hfiql.fsf@gitster.g>
Content-Language: en-US
From: Quentin Bernet <quentin.bernet@bluewin.ch>
In-Reply-To: <xmqq341hfiql.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL7DG+a/NP6y05WARDd/rwmzLSfwptBYP7eOJ9ml1z/yUWcYN6Bssy4mxJN8TEgB5tBOEbI/kGT7qvMScYTsqYU8UKRRIaFiUxrztPS7rsPDSGv+spMv
 c8LTMauQnx0C3+GaxxNIAW5ZLvS1fxhpvOg1z8OYtWVtvsJHzl129yNFoIN3qqA9wcOeDnZpOxxUu21MJE1qqSL05bYFaGe/89EYJYKQEI9bvlY1BvCS7qkE
 Pg3W2S/ZGCdm7QVzWWzGNRlFbHtgTSD/GH7UTNpnIrY=

 > Looking ver good.  Does this excatly match what we have in the
 > documentation?  I think we have a test for it, but I do not offhand
 > recall it covers "git stash".

There is a test for it, at least on the github repo (I wouldn't have 
known to change the c file otherwise)

 > Thanks.  Will queue.

Nice perfect !

