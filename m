Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC158154C08
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469853; cv=none; b=LQs7vG6pMnHJY7KZHgklxcdmQ3GWMypr2NYI+FUX9vaJPmHqdTtZNJh4l23CVluYC1zTQw4+0yMFdvh65j+n4d4yV5MeyjOfxFiHTnlVeDgBkpFWFn6zwzkBGv40NUZgcKPuhOHepltfZVrDYlWVPWWhlO3Rg/5QwI+sMU8OxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469853; c=relaxed/simple;
	bh=zgQhwOSrzE8NbLjXZbLVc24Bi9lkjiXsZhkPi5V3/6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHRssqFbs3Hlu4H2UY+/GoVSk2ZIzDRoppiRDzh/XmJvyttqx6mxutiKvyajZvxNU53HL0UD8/FwlHLRT6iRnHYfWKkJSGJJRrhE5S7wfvG4Oee38rSNk/Sn4ctPqwLY0CT6K3egs3RvzJvQffpWJgzkem0a6LniNpw09eHFCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cKwKHs/2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cKwKHs/2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 50F9D2EF3D;
	Tue, 20 Feb 2024 17:57:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zgQhwOSrzE8NbLjXZbLVc24Bi9lkjiXsZhkPi5
	V3/6g=; b=cKwKHs/2NGgeEz94EWN18ashksOj+BM1WMuCwDr0HmZ0dH4foSXOSl
	Hz2J8y1wnwHsgkOvbRrTj9zN+YruPu2x3hVMIbXPzEUCcor7ASt0LhKAQh33XNsz
	hTmHKBFh80O3re134jhMojuT0/rGimlCoAtC1SG4/mcfnwY37HNmg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4926E2EF3C;
	Tue, 20 Feb 2024 17:57:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 333AF2EF3A;
	Tue, 20 Feb 2024 17:57:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v4] documentation: send-email: use camel case consistently
In-Reply-To: <88f1fe08c3047e14090957093ee8d98b0f60cb6c.1708467601.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Tue, 20 Feb 2024 23:22:51 +0100")
References: <88f1fe08c3047e14090957093ee8d98b0f60cb6c.1708467601.git.dsimic@manjaro.org>
Date: Tue, 20 Feb 2024 14:57:25 -0800
Message-ID: <xmqqle7elp62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B09D57A-D043-11EE-BE00-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> -sendemail.smtpsslcertpath::
> +sendemail.smtpSSLCertPath::
> -sendemail.signedoffbycc::
> +sendemail.signedOffByCc::
> -sendemail.suppresscc::
> +sendemail.suppressCc::
> -sendemail.tocmd::
> +sendemail.toCmd::
> -sendemail.signedoffcc (deprecated)::
> -	Deprecated alias for `sendemail.signedoffbycc`.
> +sendemail.signedOffCc (deprecated)::
> +	Deprecated alias for `sendemail.signedOffByCc`.

All look good. 

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index d1ef6a204e68..8264f8738093 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -138,7 +138,7 @@ Note that no attempts whatsoever are made to validate the encoding.
>  
>  --compose-encoding=<encoding>::
>  	Specify encoding of compose message. Default is the value of the
> -	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
> +	'sendemail.composeEncoding'; if that is unspecified, UTF-8 is assumed.

Good.

> @@ -174,7 +174,7 @@ Sending
>  	Specify a command to run to send the email. The command should
>  	be sendmail-like; specifically, it must support the `-i` option.
>  	The command will be executed in the shell if necessary.  Default
> -	is the value of `sendemail.sendmailcmd`.  If unspecified, and if
> +	is the value of `sendemail.sendmailCmd`.  If unspecified, and if

Good.

> @@ -269,7 +269,7 @@ must be used for each option.
>  	certificates concatenated together: see verify(1) -CAfile and
>  	-CApath for more information on these). Set it to an empty string
>  	to disable certificate verification. Defaults to the value of the
> -	`sendemail.smtpsslcertpath` configuration variable, if set, or the
> +	`sendemail.smtpSSLCertPath` configuration variable, if set, or the

Good.

> @@ -313,7 +313,7 @@ Automating
>  	Specify a command to execute once per patch file which
>  	should generate patch file specific "To:" entries.
>  	Output of this command must be single email address per line.
> -	Default is the value of 'sendemail.tocmd' configuration value.
> +	Default is the value of 'sendemail.toCmd' configuration value.

Good.

> -	cc list. Default is the value of `sendemail.signedoffbycc` configuration
> +	cc list. Default is the value of `sendemail.signedOffByCc` configuration

Good.

> -	for each email set. Default is the value of 'sendemail.cccover'
> +	for each email set. Default is the value of 'sendemail.ccCover'

Good.

> -	for each email set. Default is the value of 'sendemail.tocover'
> +	for each email set. Default is the value of 'sendemail.toCover'

Good.

> -Default is the value of `sendemail.suppresscc` configuration value; if
> +Default is the value of `sendemail.suppressCc` configuration value; if

Good.

> -	See 'sendemail.aliasesfile' for more information about aliases.
> +	See 'sendemail.aliasesFile' for more information about aliases.

Good.

This version looks very good to me.  Thanks.  Will queue.
