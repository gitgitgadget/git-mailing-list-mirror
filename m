Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43282178EE
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437505; cv=none; b=u9N2+vy5yhWdiQqX1OtGXQFUkeJPCJTixapzeJOkjUfrRka0QaQy3xWyLmLNIFuK5C/4pVCpaitmP7U9x0r56+pAehOxfX16UMEjIBzz6OahWw8OkPrXrx2ivEwSfmuPM2lLDK/aBwCWnXKLF+smPuk/RuH0u1ulFDA0c93jtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437505; c=relaxed/simple;
	bh=cPJFU+3VgcDJ1MMGBA+u/WN744UKHfu8pwObITSHZ38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7+JyMv+OLPNSIdnqS6Ct/k2iYvIJCtZTXq6hVVkXHFq63mDkV0U3paAiOkHdeNYIarptBr1MxV92gwAq0Bmsh0VeLtFyT5a38NQECpeFBzedaqVqIj81KH17RksEQ1vFbOyrtsAqtIFVEi0vTDiexJmz1de9ozuWA7Inc0DzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XnwVy59hwzRnlK;
	Tue, 12 Nov 2024 19:51:37 +0100 (CET)
Message-ID: <6c1c1ae2-f38a-4458-a9ad-2fad3e56fc32@kdbg.org>
Date: Tue, 12 Nov 2024 19:51:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] doc: git-diff: apply format changes to diff-format
Content-Language: en-US
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <8fec37ee17481039998af65ce1abec753cf30897.1731343985.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <8fec37ee17481039998af65ce1abec753cf30897.1731343985.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 11.11.24 um 17:53 schrieb Jean-Noël Avila via GitGitGadget:
> -The raw output format from "git-diff-index", "git-diff-tree",
> -"git-diff-files" and "git diff --raw" are very similar.
> +The raw output format from `git-diff-index`, `git-diff-tree`,
> +`git-diff-files` and `git diff --raw` are very similar.

Throughout this document we see a lot of commands with dashes `git-foo`.
Does this have any significance, or should they be corrected to the
dashless form `git foo`? It could even be a "while at it"-change as you
are touching every instance anyway.

>  
>  These commands all compare two sets of things; what is
>  compared differs:
>  
> -git-diff-index <tree-ish>::
> -        compares the <tree-ish> and the files on the filesystem.
> +`git-diff-index <tree-ish>`::
> +	compares the _<tree-ish>_ and the files on the filesystem.

Now that the backtick formats the content as in the synopsis, why is it
written _<tree-ish>_ and not `<tree-ish>` in the running text?

-- Hannes

