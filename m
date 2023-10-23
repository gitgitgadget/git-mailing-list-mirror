Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1A1848
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cJtDz5bd"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732DD7D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698094748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KBmesDi/wIbHTSLdK6u3F89mG8fJ3xU6nipv1rRIHc=;
	b=cJtDz5bd9nmHLviFTSHFo4HEOi51tbEWf03NUG2SD42hkgRlhCIzyW41w7Q7yrC6DQ0gbj
	hs60xKZ2lHRKuqZ+lyw9qBOVr8oeucwXJmVyfCh8tZU0+8IxHO5QBBvlz7JwMAE1GZvtRe
	yvy7ObD9MeMYr7tEaR3r1GCIIaEkN7g+vZ99d8tHFYjMiWwEFQXJx8GFsT5E1cqsiUgM3i
	jmUyjZsR3u6CMCW+1ToDuGrZ5JIvZs1NSrL/U2D43y4ipZFLT0Qd9ln8AoxHjVunzpAuHN
	AoZtLrDQ3rPTdne64skcWEyapeZhzBVRXqCy8p2LiByfC8sCvsyL6zeRImlICA==
Date: Mon, 23 Oct 2023 22:59:08 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jacob Stopak
 <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTbb7bHkFOOyBT6+@ugly>
References: <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <xmqqfs21noxx.fsf@gitster.g>
 <18c7b1bea07d5f3878f4466b8e133da1@manjaro.org> <ZTbb7bHkFOOyBT6+@ugly>
Message-ID: <c8e437eacdb883f612ae44e43c95602f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

> On Mon, Oct 23, 2023 at 09:04:49PM +0200, Dragan Simic wrote:
>> That's exactly why I already wrote that the original author of
>> the table patches, if those would become accepted, should commit
>> in advance to maintaining that as the new git feature.
>> 
> that's seems just a wee bit unfair (the bar isn't put that high for
> other features), and it's not realistically enforcable anyway.

Well, it's a bit disruptive new feature, which is also quite extensive 
and can rather easily become obsolete if not maintained in the long run. 
  Perhaps we should hear Jacob's thoughts about that as well.
