Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AC3CB2D0
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486444; cv=none; b=Xl4XbEW2eHz4d7K6GGthau2aNcQUw9VIM886vvy7wkj8hI6Fl9isTVHtMwFcYbZaMBVc+gvKRLQaAKUIa8ZQ8ZdbGNRSum76bxN9ickYAz8sGp3xF8OPqLJk+4ErZ0hTk92HNi5JY8X0zrCOqDXsGjuLp7PIYbaZP4hGsRTspP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486444; c=relaxed/simple;
	bh=+C9yHiIptEjLoVqZWSYmgqlLTRcOJjUpAhp22/x2RQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C4zaDqGY7Ngvd9/C8ypdNJJqxn3JLxjTLvG8k2NbOIqHIb5Pga10chtkSUFncPjUMhM4X6KrbF4MeGvUnd/XOIWCEef64RaaPqQJD1Ep4gU2tLfI8e+c4ll/NHp7A/us/dW3Am/GoWMk6HPri89ZoRZPrrLHP0lh0Pkv8RpTnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kk8/JUUC; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kk8/JUUC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785486433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwerFcKmmWBwC8tk3r+klbHSPzVyFii0V8+hKAt5I4Y=;
	b=kk8/JUUCfpgp9NLhxALGOtzY/ABxvM+LHgcLXL6KT4G3ubi/ee+dMSIhpLbjAxERKCCp/n
	Km1GkC0NgnT2W/KL3wBLFT4/9uuvAE1IKBUJfc0pFcpUkEu+x1BwQtdgEZApz7MZntI9o6
	o02Ndlk0q5fE841NwUK0QPuJzA1lSbQ=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
 <gitster@pobox.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Siddharth Asthana <siddharthasthana31@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/4] doc: replay: fix config link
In-Reply-To: <6bcc7490-6dc8-42a7-b3ea-99bf948d7997@app.fastmail.com>
References: <CV_doc_replay_config.709@msgid.xyz>
 <V4_CV_doc_replay_config.af3@msgid.xyz> <xmqq4ihglab5.fsf@gitster.g>
 <6bcc7490-6dc8-42a7-b3ea-99bf948d7997@app.fastmail.com>
Date: Fri, 31 Jul 2026 10:26:59 +0200
Message-ID: <87h5lfd0oc.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Thu, Jul 30, 2026, at 18:19, Junio C Hamano wrote:
>> That's truly minimal update.  It is a bit surprising that the topic
>> was stuck for a long time, nearing its expiration date.
>>
>> A quick look at the thread
>> https://lore.kernel.org/git/V3_CV_doc_replay_config.780@msgid.xyz/
>> tells me that there weren't any outstanding review comments.
>>
>> That unfortunately does not say if this version is good enough or
>> people got tired of reviewing and did not pick all lints in v3, but
>> we need to work with what we have, so let's see how smoothly this
>> round goes.
>
> Yeah, there just hasn=E2=80=99t been much interest in this topic. But tha=
nks
> again to Toon for taking a fresh look.
>
>>
>> Will replace.  Thanks.
>>[snip]

I'm happy with this version too. And for the record, I've locally
rendered this as it would on git-scm.com, and all look good.

--=20
Cheers,
Toon
