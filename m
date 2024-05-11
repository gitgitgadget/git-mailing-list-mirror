Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67D3716D
	for <git@vger.kernel.org>; Sat, 11 May 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715460828; cv=none; b=Zy1Y9cleU/ODTqc1+pMhF1unRwekU1WUOGUpWvHXwkKzHSf6oHeEU5EqxXDFCIpDaakH1ID3tyLz6NXr28qKIyz1A3UfUPlxzhFwZiTa8wLE0AocBa7HC6rG2EuK0Uu3Zx5ytiSKh4o5A9N9LQKKSC3e0+qsysiSvJ0hg2o7a9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715460828; c=relaxed/simple;
	bh=YVM6rWZiWJzJ/COOFhOTDfec+Wt9on+Qc7sOqQ0/9V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inGNOI/CyYNl/hBlaqkFG+SX9b+/wOYxJRZOA46oBmECZGKCQ3cwtcugS3WhkHswSeeWHb4gvR1bSMeFN7ENOKqbLZe4mayuyx2dUJOw/MTOUZV0ahON8riiKBTFgWYP7SfiPLrRNMtNiiBj55YT0ZUEocr+1jO9ERS8Y/tFQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4VcHzD2RkqzRnmG;
	Sat, 11 May 2024 22:53:43 +0200 (CEST)
Message-ID: <01502c68-718a-4fc8-9106-f930b4a24346@kdbg.org>
Date: Sat, 11 May 2024 22:53:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git-GUI change of maintainership
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
 Git Mailing List <git@vger.kernel.org>
References: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org>
 <mafs0r0eob610.fsf@yadavpratyush.com>
 <25c0ec11-4b20-4c78-ba77-8d10ca2ef21b@kdbg.org> <xmqqbk5c1eqf.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqbk5c1eqf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.05.24 um 18:43 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> I am about to apply the patch below to note the new maintainer.
> 
> Thanks.  I have these planned.
> 
> 
> diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
> index 384893be1c..0690ae2140 100644
> --- i/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> 
> diff --git a/MaintNotes b/MaintNotes
> index b1f0e63..00ffa91 100644
> --- a/MaintNotes
> +++ b/MaintNotes

Thank you. Please consider the following as well.

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index e8f3ccb433..f5b02ef114 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -114,7 +114,7 @@ of end users.
 
 The official repository of the 'git gui' project can be found at:
 
-  https://github.com/prati0100/git-gui.git/
+  https://github.com/j6t/git-gui
 
 GIT
 ---

