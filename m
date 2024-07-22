Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86193770D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689209; cv=none; b=px7bgSM8EogkKRmmSYTGpPXm8H2kB5H39+iEOddyPpJSZ3QYXERoUAv6UeBzvGGBQUoEzGXFOI2NvoB018Df4ET73aXAZkv1jVC3tysFhf2rBnr6ttaGt6jTI0GnFOZ763jQUF8PEShV7ajeX5qonjzbH2SPfL6DMQf8u9n70sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689209; c=relaxed/simple;
	bh=+cZGNFYZA4m2C9/kO5kSKJNv+G7NdoqfmLrxOwKcreE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hvMX9CQPowPcC7QpVRelPXMVEFt23K1DGWKUmIepKS1cfbqgKpVCpXkOAhQSvVQB8gzr/LI6kjIfg8JbLWjzntZezYMxuQ8Dsds4mM5RseSx4F1zJNs43JMNUn34zM5nVtFjDQnghqxRFIomc7nNMk4P60IhOBORo0QwJg/yXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=XtW0Lyhj; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="XtW0Lyhj"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 03A0B240027
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1721689199; bh=+cZGNFYZA4m2C9/kO5kSKJNv+G7NdoqfmLrxOwKcreE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=XtW0Lyhj8KNCVFz8lYMUy9DCFcxNGHAlZmco5GH6aveBHWkRkf0Y1l7BTXpEpT70x
	 5bL2Yp/FPwnQCu1IMS3XrZM+rzrYlg0UOqRzbzrVncC8LWq3s/Mh0ar+nZxrH9NDzG
	 kxAGiDDJA6IO2WNGzfRFxna5Bwka0ZhLoLu5kMyUMGNRZ8lfnTATNsaG8WtOshtME7
	 BqrX9VThC82J3COW7VlDD7QoFlLaxVxijerZMQ1+29yu3Ps++nnxGOnpxeXyyPlWzY
	 Ql8YkyOrrY48QOG8k8Z8Spw51BugsjHX7PMBCLeZ0vz8UBNbgahF/rR0X74PmCongE
	 gxcrHwkcqSj0g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WSbMf2nJ9z9rxD;
	Tue, 23 Jul 2024 00:59:58 +0200 (CEST)
From: Tomas Nordin <tomasn@posteo.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: Unbalanced closing paren in help of git commit
In-Reply-To: <xmqqed7lb6dt.fsf@gitster.g>
References: <87o7792xgu.fsf@posteo.net> <xmqqcynnejwl.fsf@gitster.g>
 <871q3nx7f3.fsf@posteo.net> <xmqqed7lb6dt.fsf@gitster.g>
Date: Mon, 22 Jul 2024 22:59:57 +0000
Message-ID: <87jzhdvxqq.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> We do not "attach" patches to an e-mail, like this.  Please visit 
> https://lore.kernel.org/git/ and check patch messages from others.

I tried to send the format-patch file using git send-email now. That
will be in a thread other than this.

> We do not work file-by-file.  If any reader wants to know which
> paths were affected, they can see the diffstat before the patch.
>
> I think what you wrote is just fine otherwise; just drop the "*
> Documentation/git-commit" line, dedent the body of the paragraph,
> and typofix the "misstake".

I made those amendments, lets see if its OK.
