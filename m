Received: from ceres.rohieb.name (ceres.rohieb.name [46.38.232.89])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008913F011
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124229; cv=none; b=IhpB/Ituj9VAzNmpT/JdRVLduZofuMvtEY8OEGyli7Yffq9ZzT/GH8PpaDwKfOViyB1RHCh8NXmQ+ed9B/96xfh1LOEuz/B0PrxhLCV8VOgSq/PhjsmOPWrtlowAmkoejLqsh+Qu/T/6gsYHLJShtfCnghU26zdlsLHLWTR5y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124229; c=relaxed/simple;
	bh=lw6PLpLNlV6MODhLHjCDjI6wk/D+7D0Kk2Lptk0SJCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI+qAdOrPa3baMD6vatwC9O9DhxaoJOSD5wi8yrmC1JtlRVMQrEWKpU2oRld0cmPD/qNMqH2P+zyHzrz3dfzt0YDmyQZPLpsCjPXrIAuJsgmrYLJ5TniltaHQDfXIFXKcRLmYkwRpOX9cM0dm3wRS1xpICZHM3Ybx15MCC5TK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rohieb.name; spf=pass smtp.mailfrom=rohieb.name; arc=none smtp.client-ip=46.38.232.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rohieb.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rohieb.name
Received: from localhost (guest.nat.stw.pengutronix.de [185.203.202.7])
	by ceres.rohieb.name (Postfix) with ESMTPSA id BE3A21000F9;
	Fri, 26 Apr 2024 11:31:10 +0200 (CEST)
Date: Fri, 26 Apr 2024 11:31:10 +0200
From: Roland Hieber <rohieb+git@rohieb.name>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify practices for submitting updated patch
 versions
Message-ID: <20240426093110.3lxbmhwfl3efwo2s@glados>
References: <20240425213404.133660-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425213404.133660-1-jltobler@gmail.com>

On Thu, Apr 25, 2024 at 04:34:04PM -0500, Justin Tobler wrote:
> The `SubmittingPatches` documentation briefly mentions that related
> patches should be grouped together in their own e-mail thread. Expand on
> this to explicitly state that updated versions of a patch series should
> also follow this. Also provide add a link to existing documentation from
> `MyFirstContribution` that provides detailed instructions on how to do
> this via `git-send-email(1)`.

Thankst! I obviously didn't read the old text in the intended way when I
submitted my patch iterations yesterday, so your patch makes it much more clear!

 - Roland

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/SubmittingPatches | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c647c7e1b4..bc212836f9 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -415,10 +415,12 @@ e-mail tools, so that they may comment on specific portions of
>  your code.  For this reason, each patch should be submitted
>  "inline" in a separate message.
>  
> -Multiple related patches should be grouped into their own e-mail
> -thread to help readers find all parts of the series.  To that end,
> -send them as replies to either an additional "cover letter" message
> -(see below), the first patch, or the respective preceding patch.
> +All subsequent versions of a patch series and other related patches should be
> +grouped into their own e-mail thread to help readers find all parts of the
> +series.  To that end, send them as replies to either an additional "cover
> +letter" message (see below), the first patch, or the respective preceding patch.
> +Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
> +how to submit updated versions of a patch series.
>  
>  If your log message (including your name on the
>  `Signed-off-by` trailer) is not writable in ASCII, make sure that
> 
> base-commit: e326e520101dcf43a0499c3adc2df7eca30add2d
> -- 
> 2.44.0
> 

-- 
Roland Hieber
E-Mail: rohieb@rohieb.name
Web: https://rohieb.name
PGP Fingerprint: 3B7A C587 9464 CAB6 5B90  7151 B241 3C66 DD2C 3FEA
