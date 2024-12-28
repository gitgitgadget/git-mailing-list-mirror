Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B626AF6
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735373271; cv=none; b=tSlcsJr4HLr7YVzse6WksXKbDgZ8MYCJVaHJnK7/8e6X0C1kV82kDwxaFEA7vWyI0+xhrj2q6CUxI50zZheXbBLmBHfvc1Dst81VNBvZ5s704BEck0XbIwqgQMhbPvqX2eawcv1csxuXZd8ZnZRHr6ht3ihTQ/+0XZowSUAmSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735373271; c=relaxed/simple;
	bh=3yFCYSlyHW4l6pRwc9+ROQC/aaLlbFYPoFugj83V49Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbNptFJsIRgmrje/4NZp/vvwiaIJsvOkJEMuyMNoxQxJJfXV7XYWecvatrLG41S7EBs1MyXTEXKU8cltsCPuYM/ZXQR4QsqpaXcdlIKsxCU9u4V6YgJ5f1O4MGC90vSaOlnU4Ap0RsERkCxBmRrRBHB/R5ibSmeO4EI4Y11sdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KT549kKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KT549kKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4974EC4CED2;
	Sat, 28 Dec 2024 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735373270;
	bh=3yFCYSlyHW4l6pRwc9+ROQC/aaLlbFYPoFugj83V49Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KT549kKQcSAe+ewpuheU80xeIBLS0a+1If0WOyDVPX5nM5g09j68rvBPylwdX1++/
	 h71ghE5keBWWYJDsWq+h3Xf8m/SmGpiuH2rWyHFCnzubaWBKkhb+Gm8KcGasXG4Ic/
	 ldWxj3HnNTqSS3b0MDAEGEEF5GX070kVaiPQT2vs=
Date: Sat, 28 Dec 2024 03:07:45 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [fingerprint] of github.com
Message-ID: <20241228-stylish-beetle-of-joy-9be836@lemur>
References: <ROrCxOsQ6KcZqO7YsIr2BGbPsmyUYAHXgF-l3Pwg0-7Z12oBWFrwy4yzgax9Zq6whGT4Fh4gKQxMNlHEoEOBljSvucyX9sQyc3rtT3NT0us=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ROrCxOsQ6KcZqO7YsIr2BGbPsmyUYAHXgF-l3Pwg0-7Z12oBWFrwy4yzgax9Zq6whGT4Fh4gKQxMNlHEoEOBljSvucyX9sQyc3rtT3NT0us=@proton.me>

On Sat, Dec 28, 2024 at 03:05:11AM +0000, A bughunter wrote:
> How would you confirm the correct SSH server fingerprint of github.com upon initial connection? Does GitHub post valid FP anywhere?

Please do a modicum of effort before posting to the list. This is literally
the first hit on the search engines:
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints

Additionally, Github specific questions are not really on topic for this list,
unless they have to do with git specifically.

-K (with moderator's hat on)
