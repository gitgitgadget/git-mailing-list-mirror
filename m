Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036584A0C
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879691; cv=none; b=SB8HPVPp0IVjmnqksGeZ0nxvlhE052rblCIVmxEdvNr4VW94CcSZWUMqJcNDwC8BAEo+u18ckFd+3ncVIr6wbswSJE8Ev7Rj2i+WkuSifLvs4SHf2YOGiDKnOM6JGsXnZTHgZwvYaUEfce+JMizvRROY49zy5bpukx2RI9Vh/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879691; c=relaxed/simple;
	bh=5+chSxohfZgvxUTSS0tWHHQsWOLKrlh+aiuJ5EGqVUU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=LlF/rQiNjYDERodE6aqpFPIQshOylm4hfrChKEbWR5ewcoxl53HP6mRfLXCdZVIhGZdtuCtcMNokdgMHXAoU2k5P/hbJAUpikDyb7wspsF0UDlC9Qe+HESpEqYYjIRAgenyZzk0dLyIS9TycSChsMCljHh8OU55b1hQyK6NySo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=moZ2aXJS; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="moZ2aXJS"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 1DB97609DF;
	Sun, 12 Jul 2026 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1783879683; bh=5+chSxohfZgvxUTSS0tWHHQsWOLKrlh+aiuJ5EGqVUU=;
	h=Date:Subject:To:From:References:In-Reply-To:From;
	b=moZ2aXJS+5MyR51IvQ43DgRlvzkkcPze9Y6JF2zBXtwZHuoiFQE0agr1qGB5hRiuU
	 FMFWYSAh8SowJTyde2MiXvLGf1SiXRqvtVt+5bfS1ajV5Y1tKc5YBbJcEUdgx353bw
	 s4rphTzsQ6KEef31icVVL6GWQ4T8S6FSn79UFXpQ=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 14:08:02 -0400
Message-Id: <DJWSKKVJM03B.1DTV8F9FXG9IF@lfurio.us>
Subject: Re: [PATCH 4/6] MyFirstContribution: clarify that 'seen' does not
 mean acceptance
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260711192650.2417665-1-gitster@pobox.com>
 <20260711192650.2417665-5-gitster@pobox.com>
In-Reply-To: <20260711192650.2417665-5-gitster@pobox.com>

On Sat Jul 11, 2026 at 3:26 PM EDT, Junio C Hamano wrote:
> +
> +Plenty of early testers use `next` and
>  may report issues. Eventually, changes in `next` will make it to `master=
`,
>  which is typically considered stable. Finally, when a new release is cut=
,
>  `maint` is used to base bugfixes onto. As mentioned at the beginning of =
this

It feels odd not to reflow this paragraph, where the first line now just
stops halfway across the width of the paragraph.  Though, the diff-churn
may not be worth it in your eyes.
