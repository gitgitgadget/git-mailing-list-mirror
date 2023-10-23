Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E733E7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tMOymO3B"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5DBA1
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698083997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz4ClCVKZEGIvRl2R8aV0PYRoS0YXqiw+WAnh6jbPTc=;
	b=tMOymO3Bmf0+B2mY4LlUq94OZMRMFA+mdeQY7zUsdBZ65KUvxhJpD/pMwhE/QwPaLWtTmQ
	eFXZsoWehqQgeDXSuxAApSAUHx6gHSL8D577qubJenzp9eGXIYQq16+3KsCgKanTbc1VFp
	5X0pkCkA1Oe9YnawnWFw8Ew+hnsKtbZzlGgSo6c/35PeDPgtToF3bR0eWQsLmdsm8GnpRE
	4QKkr1s2K8UE/0fW3NzqeHB9wobw/vdjdQ7JMWckak+0vPgGqX2zKqMPq3/LgLk4cAMilq
	jSxoK3UXi45yTA8gzVakE/TU/Njl294FXeAy1lx2F6i2buRuOOtYhabi+IX0DQ==
Date: Mon, 23 Oct 2023 19:59:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
Message-ID: <fd619b5f21e24529e5bc608cb0b9876f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 19:30, Jacob Stopak wrote:
> On Mon, Oct 23, 2023 at 04:34:15PM +0200, Dragan Simic wrote:
>> On 2023-10-23 12:52, Oswald Buddenhagen wrote:
>>> i for one think that it would be a perfectly valid experiment to go
>>> all-in and beyond with jacob's proposal - _and make it the default_
>>> (when the output is a tty). more advanced users who feel annoyed 
>>> would
>>> be expected to opt out of it via configuration, as they are for the
>>> advice messages. because it's really the same idea, only thought
>>> bigger.
>> 
>> I'd never support that, FWIW.
> 
> FWIW, I'd _never suggest_ that. I very much value Git's current usage
> and wouldn't dream to make this the default. This proposal is for an
> optional flag to help users who would benefit from it, nothing more,
> nothing less. Speculating on user motives to classify them into 2 broad
> categories in order to prove the feature isn't helpful misses the point
> that there is a (relatively large IMO) subset of users who would 
> benefit
> from it.
> 
> As an optional flag, experienced users wouldn't bat an eyelash, and the
> type of users who installed my tool could use the flag on and off until
> they feel confident enough to drop it. But it is always there in case
> they need a refresher.

Perhaps my broad classification of git users wasn't that great, and I'm 
actually happy for being wrong there.

Just to clarify, in general I'd support the inclusion of the table 
output formatting, but I'd need to test it in detail before saying a 
definite yes.  It would also need to be more feature-complete, and the 
original author of the patches should commit to maintaining it as the 
new git feature.  Having different options available can't hurt, IMHO.

However, having that as the default is something I'll never support.  
All this is just my opinion.
