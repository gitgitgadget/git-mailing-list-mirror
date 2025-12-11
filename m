Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7723185E
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462860; cv=none; b=J67YToL2X6M4+fqcL+UxvkgcQih0H/LZTVgb6DjrhlmfhrjzddWagT6y8PtrXfizgDKz5MFMm8281qK1z0sI118A4Loph4/0LCPFh7YB2cCBA+lb72friEKwo5eT4P9ulplUpxzgncDiyu1cmf+zOOIUwLJrjdTJTER9Ltxrrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462860; c=relaxed/simple;
	bh=4yJeXsU6ZKG4kopyFoE/4D905OrFWcmC7tHnjod1c6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jra0gyJMXhbTKT5KEKTB+Ft3ovuSl5jgBYJexvt7HzcaxusUZlJGpm8XgfUOLS1uFP0QSDO0h3Dk3T64S57O9cxmfE4UJ2+K514raXPBhD+c4Se3ydotvjYpS0wIOEyrYMH+cfGK66XGFocbrr22vPdon/DO1NxIz5eqAcbHj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T1tkUGzv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T1tkUGzv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T8PxSykMCny3IBVbVp3QVaT0fZ7BldQ7cXON+PkY0cE=; b=T1tkUGzv7qYxXT2qxd0/Ovma4f
	rLQVUyflOwa46JtwHdFJbh2co0kWjn203ZnJbXF+ohzchkul558yQj/Tf8Vx3lLvyPqvqOZllVIHD
	gtYplkn8TdCo3FWBHywQohmJurwNM+WSDzGiBeGCmRZ9DJg9lWiSzpPikRXKMRIURKxkjRsdtluMp
	36g3reRl/huyQQSXLLkla7okjro7MrjiCSgEYmZRW3sP/mXocGfyZk7EKH1lymWxtFIMwIyBWSn/J
	JNKCBy9Q8QA+DqygyAGDtGd0UWPZ6e+8lDodgu7nz0dPTgvk34D1PFJqhxezFzrwBqI6JYBDLce56
	MbOeXapQ==;
Received: from [91.117.33.88] (helo=[192.168.1.138])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vThXD-00BWUU-RT; Thu, 11 Dec 2025 15:20:47 +0100
Message-ID: <e19246a7-40db-41d0-9cdf-817833123f45@igalia.com>
Date: Thu, 11 Dec 2025 15:20:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] scalar: document config settings
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Henrique Ferreiro <hferreiro@igalia.com>
In-Reply-To: <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 5:50 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> Add user-facing documentation that justifies the values being set by
> 'scalar clone', 'scalar register', and 'scalar reconfigure'.

Hi Derrick. I was planning to contribute a patch removing some config
options so I'll take this opportunity to just discuss those here.

My motivation is that some of the options seem to be related to things
other than performance and the list is huge, so I believe that some
options don't belong to scalar.

> +REQUIRED AND RECOMMENDED CONFIG
> +-------------------------------

There's no mention on which configs are required and which are
recommended, and it looks like none are actually required so maybe just
remove REQUIRED.

> +am.keepCR=true::
 > +core.logAllRefUpdates=true::
 > +credential.https://dev.azure.com.useHttpPath=true::
 > +http.sslBackend=schannel::

These options are not related to performance. Why not keeping them out
of scalar?

> +core.autoCRLF=false::
> +core.safeCRLF=false::
 > +index.threads=true::

These options just duplicate the default settings.

> +feature.manyFiles=false::
> +	This disables the "many files" optimizations grouped under this feature
> +	config. The expectation is that all valuable optimizations are also set
> +	explicitly by Scalar config, and any differences are intentional.

I disagree with this reasoning. This thread was actually brought to my
attention when working on setting manyFiles to true in scalar:
https://github.com/git/git/pull/2125.

Do you foresee any features that would apply to scalar but not to
manyFiles? I'd even say that some scalar options could be moved to
manyFiles instead, so that people that don't use scalar can benefit too.

Cheers,
Henrique.
