Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61823D7E0
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756754814; cv=none; b=LqYe89xUwNhZG+B54IsgPTgFWPy9J5w7zwMbnFn4jXjoqGw+919T1DtSP8ec2agHMjWkH5Y6gZN1/9xmsmz2ahGFbp7TMWqijHxB2iZElu7ALYNG70x6s0RX6fskqW0X2jjGzJYQQcGejqgztN0lN9dy3A5g7gvMOVIg17hdkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756754814; c=relaxed/simple;
	bh=VYrhDzyrdQMB635Xu1E5ISU9v+YcVAPNkl8pV0cPbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knYOO4jcZ1YINBWa3y3SNwRu5PodS1hBBVZUdxk2lX+BygtDw0ZDMfD77D+4E8H7nMJgxBqTt9oso/uTsIHGss42h7wPwJKm0vLQAoxv5R56ZPo5RhkGJLEG859ETQahoRKb1ZfItqyJx2HHrzJ3W11oDWuwUWpjQudfK/iNMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=AtoXEMsk; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="AtoXEMsk"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 532A74D1B8
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 21:17:37 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:1195:e3b9:ee1b:f12d])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 05DFD5FF95;
	Mon,  1 Sep 2025 21:17:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1756754250;
	bh=VYrhDzyrdQMB635Xu1E5ISU9v+YcVAPNkl8pV0cPbAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtoXEMskZ7xvN0GQqHsMtX2s1hwgmR7xKoXcpY42/6a4mv3v3ETsHBml418jv2Og4
	 7gCQnJIp3QlmA4byc5lh/VM/3s2OE4X30noC5yYCckW1ovexODgvStN56FEeSlsBOf
	 zIUwkCFcXp9xLhcX6uRZT/Hfw6ucEFn0bYrKlMaR6UPjdTegx6Z/E6usMY/CAJk40B
	 w4ikg0wVlhpWdmkBvfOftvS4k8BtpC1zQZuPQhR40cm8gnLtMtXr4lpDzYLFejeBIF
	 56NGTDFoPZ7rA4Tb4aDsuKzJKZMT6CaE5MFDqTWwoYIcWfV3+hQTD+1QPWuGyfhOUM
	 xbwNRTjV3KIFA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, "Kyle E. Mitchell" <kyle@kemitchell.com>
Cc: "Kyle E. Mitchell" <kyle@kemitchell.com>,
 Ian Wienand <iwienand@redhat.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix formatting of function-wrap shell alias
Date: Mon, 01 Sep 2025 21:17:25 +0200
Message-ID: <2796730.mvXUDI8C0e@cayenne>
In-Reply-To: <20250901180419.2212086-1-kyle@kemitchell.com>
References: <20250901180419.2212086-1-kyle@kemitchell.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 1 September 2025 20:04:18 CEST Kyle E. Mitchell wrote:
> Add a missed backtick to the end of a code segment so that it will be
> rendered like preceding examples.
> 
> I deeply appreciate the thoroughness of this documentation.  I noticed
> the formatting discrepancy reading https://git-scm.com/docs/git-config.
> 
> Signed-off-by: Kyle E. Mitchell <kyle@kemitchell.com>
> ---
>  Documentation/config/alias.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/alias.adoc b/Documentation/config/
alias.adoc
> index 2c5db0ad84..95825354bf 100644
> --- a/Documentation/config/alias.adoc
> +++ b/Documentation/config/alias.adoc
> @@ -38,6 +38,6 @@ it will be treated as a shell command.  For example, 
defining
>  ** A convenient way to deal with this is to write your script
>     operations in an inline function that is then called with any
>     arguments from the command-line.  For example `alias.cmd = "!c() {
> -   echo $1 | grep $2 ; }; c" will correctly execute the prior example.
> +   echo $1 | grep $2 ; }; c"` will correctly execute the prior example.
>  ** Setting `GIT_TRACE=1` can help you debug the command being run for
>     your alias.

Obviously correct.

Thanks!



