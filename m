Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12D8F7A
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397230; cv=none; b=QeRkZBidYJmVXSZxjCmb/4n4GXXYwY9nvhddotq8rWI3JYxJf8Cr42/rctg0sNHAHW0KyHMnPwxqdgvHH0vM9Xq221k6+inu//dhF/N4PtA1YzQYXJPByPdp4+S4rnqZ1d0ycvlF16OtdJAIiZWZu+szjRAnUAFvWOfbcJO72yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397230; c=relaxed/simple;
	bh=kULdSSTZYAoLkSxeaTzbS/CSmIrkOkNsH+ufF3Ne7Wk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Q8s3nyhNdxYZZyXKBOizgpl/+PgDUlLSEDwWdxn1jlQEDQ91Ju9pecRQODMsfU3JtAQAmhyuyAMPQPA94CJWEDcj3qQ27EHThl8kYNsOCemTAx5ZA0aDUUWFpowXfLkX3g2Qi7e2f1OhCQ+rBEZKLhUFbwDJnqp8BvZ9eaFigEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SvXYJXQv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SvXYJXQv"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710397225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MuGe5y/1JneIAXF7sAGCh1BPTtAsP8X4xffxuaCkRM=;
	b=SvXYJXQvDbfEJOUVTIOnQV7BJwyzCZIyzYOqSE/ntayKdG+RzyZC2dOxWI9AYgno6VvVNn
	LLOhXd3dKlAcTQK5FsFs5kNZdKMAj/pl5jBURbwz8dPdfLqlp1jYR+vSXcpfHY/flLjX0m
	lk9LApO3qrQkRljhmgddCklPK2qrQb6iTGgdRFr3EIOaNsCH6eQhn8mEM4W2DwszouojKh
	rv2btrtX23xBUIAD1E2hRbVN4ucneTggqvKaiHl0NlfYchKhKsA6F1hGfB14lY0qxDJwJB
	ehF0FeRb3FIGHy8OqWuKcVUHiKhzQInFM+0vFpXuXIBqKF5PyAowwloLBFekOg==
Date: Thu, 14 Mar 2024 07:20:25 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH 2/3] config.txt: perform some minor reformatting
In-Reply-To: <xmqqedcd1sm5.fsf@gitster.g>
References: <cover.1710258538.git.dsimic@manjaro.org>
 <d50c0f22c41ec36b574e1ff67e68485d9a6f2a84.1710258538.git.dsimic@manjaro.org>
 <xmqqedcd1sm5.fsf@gitster.g>
Message-ID: <07d0ac0d11b47983d3aa1760fc01ad92@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-14 02:58, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Reformat a few lines a bit, to utilize the available horizontal space 
>> better.
>> There are no changes to the actual contents of the documentation.
> 
> I was a bit surprised to see such a "preliminary clean-up" step to
> come before the main change, not after, but separating this from the
> change to the next paragraph, which is the main change in this series,
> is nevertheless a very good idea.

The reason why this patch went as the second in the series was simply
because it's a somewhat unrelated cleanup that performs no actual 
changes
to the contents of the documentation.

Thus, the first patch in the series brings the changes, the second patch
stays in the same domain but only as a cleanup, and the third patch 
moves
to another domain.  I find it quite logical.
