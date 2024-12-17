Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32B1F37BE
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455923; cv=none; b=hvQE9R4s06Db3FSC6lpI+3H43hjjT1eXDrPOzkHHxR9Exp1Gb/1yAfA1lLA/RUZMIs/jHjwGGSnE0K6yjJzk4auxs2BEcomNwgMGlaVZ7+4mx0kCo9Oe8o5H0RRC49khC6KTwLU5fDgbO3sgI2kEMXtCbGoUllZyWlxrESjsJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455923; c=relaxed/simple;
	bh=EqdC57xXLKAnyH9NrbUm1M6+6fpooOX1Rr2LNjw4RrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0heYTqDRMg5azlpOtoV2IZxCe2ZpxspZUb06XUNPmwsCFECgHqxu9dfUQLzKxojNyzJyYmsH+TV9jRIFsbfVSqHm4/r4k9rZuJWzxoaWpnwWSE5aYWTlXix4fssiecRueO2GexyjLCRtgll7pEGDWk+9uuAIOMQx4lCMVASerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KeaTEw3d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KeaTEw3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F619C4CED3;
	Tue, 17 Dec 2024 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455923;
	bh=EqdC57xXLKAnyH9NrbUm1M6+6fpooOX1Rr2LNjw4RrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeaTEw3ddm9sLv47Xy4OphqzdY+2jt8/Moc3EH0DtU8hFSTsghZookDmmHKvb+JvV
	 DygoqG7w+LRqZuJF6hEGmNYLSHNFxtu/X/6x9M7NYseuQ1nEsaUAK9Ibm/o3D6o5ly
	 rnHyTVhqJfrzQa/ooLO6t8Aa2K0E9cE9RFlXB7JE=
Date: Tue, 17 Dec 2024 12:18:38 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] can nobody get me an email
Message-ID: <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me>

On Tue, Dec 17, 2024 at 10:12:46AM +0000, A bughunter wrote:
> I can't really start much of anything without an email. In the conscerns of
> OpSec all online security concatenates to email. Google is not an option
> because of Google Chrome for android Criminal espionage bug
> https://github.com/users/freedom-foundation/projects/2 and Proton is in
> cahoots with Google (or fakeGoogle) and outlook keeps locking me out. I will
> use aerc and send-email/format-patch for email interactions. And for
> development, I use Neovim. Can nobody get me an email?

Such requests are kind of off-topic for this list. Short of self-hosting, any
commercial email provider is going to have some kind of dubious history that
can be used against them if you're looking for reasons why they can't be
trusted.

Self-hosting is challenging, but is not impossible, and will give you the
purity of intentions that you're looking for. This book may be of interest:
https://lwn.net/Articles/998153/

-K
