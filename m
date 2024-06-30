Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626310E6
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719723484; cv=none; b=MZQZPi/Zq8sk/T/3PV+WL62AcOykOfPWZdr2I6Yf3Hq0nHmSn5Tm6llrnhoIb4xQUM1xcJ3gB9pSGO12OtkPua/QLaXZ58gwytUy5TjcgyP+nJPcdBSqvU+eEtOX8V1WBpX/gnGZUeHko+EF39i/t/jlg4oBG5RQAz1YNXciOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719723484; c=relaxed/simple;
	bh=EdoysbCZfN6rS3ar0t5bPuy38ZV/Yuhz8HSlhZRq2dw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ikN84fklQ0DrSokN4Xe+FKZPFl4xlgURnkSueqggnt5E8/gPovU0AHA1w7JNkILqoxVWCt1jtluY8WFwbBD6TR5Dswy5/WQMDCMsTwGqe/76t5I+yU1tC+gjPXB/qeef/oxpMk1d0UXi2XFcR+Ag5aTFgIhZr84CzjW/kt/oYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=A5i+2FkC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="A5i+2FkC"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719723478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpFtpnKnpaUndqJ56A9PEEvMwmI7ihZGhgpxeBZrs9c=;
	b=A5i+2FkCiimdK9/ABdRCmsAMqFXoDW/aRVPjaARY+7qf+yjtjWGPW+qWtgq3GV6YggswEp
	LA3OIsjZ2lKWrnzaNg75XhADOMrqVkoSiOD83ibSuirKfK2fj/3N0j+6aCwjzt+Cp9fLSS
	Oay8ZQ3Q8JFPQR4dNsxlwjguNRD+Mz9djbYx79l71k2YqdeHK3nzI7LNvQNMOn8H/j97Vh
	HHk91zxP4KPdkeMr+rzkygAndcu7ZYIlkn5Ls1DivLJghQ5GybmtJeV0zriTynF/iyMsaF
	cXMdf+JfYDmPv6+l1RuLcoP/mFQYUBmpITR0iGnfcGGmqyPbEQcFgZiLlUOchQ==
Date: Sun, 30 Jun 2024 06:57:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jakub
 Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>, Kaartic
 Sivaraam <kaartic.sivaraam@gmail.com>, =?UTF-8?Q?=C5=A0t=C4=9Bp=C3=A1n?=
 =?UTF-8?Q?_N=C4=9Bmec?= <stepnem@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?=C3=86var_?=
 =?UTF-8?Q?Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>, Justin Tobler
 <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: Draft of Git Rev News edition 112
In-Reply-To: <CAP8UFD1eH8GXn=aER56FVvrh90f_c+VdxdtopJmDYwPend52gQ@mail.gmail.com>
References: <CAP8UFD1eH8GXn=aER56FVvrh90f_c+VdxdtopJmDYwPend52gQ@mail.gmail.com>
Message-ID: <b38543d735b2c14d82523300b8c6c84c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christian,

On 2024-06-29 23:42, Christian Couder wrote:
> A draft of a new Git Rev News edition is available here:
> 
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-112.md
> 
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
> 
>   https://github.com/git/git.github.io/issues/714
> 
> You can also reply to this email.

Thanks for the draft!  There's a small typo in it:

s/who add participated/who participated/
or maybe s/who add participated/who also participated/

> In general all kinds of contributions, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub,
> volunteering for being interviewed and so on, are very much
> appreciated.
> 
> I tried to Cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
> 
> Jakub, Markus, Kaartic and I plan to publish this edition on
> Monday July 1st, 2024.
> 
> Thanks,
> Christian.
