Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0302D060B
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429737; cv=none; b=VDYdEaADQmmIcK8B0QkTTVJcDShWKOZQYFse7/xPyumK838V47RHhWFnre9iE1+YdVC76Rn4Zf11Wwmd08bkfGCjBGLVKbXLKVHlNwXxtup2eqDymgTI2T84253Egd5rF6KlIVVegx2p3pIWrC8KYMe3/NKXgQsCkN4KOIImbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429737; c=relaxed/simple;
	bh=Tr/6VRNCYJWJD6fj3sHNqPUeue862+05jqqEz5v+Xak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lI5fcYxgh+AQQdm+DSVsMcfc1mYQCBBXmPOqw6Lr64Nk12/HD06TQk/XM+/H0Rd+sMBvQUHo724bpexpvfW/UqmVuJ9R2S3kVEuVJfVO8f7pNjWDJV6AT/yv/94AZ0urUa0C/EIP8PuEDJ4uOlRxYXggjAd7cmr7D7EPCvTGNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4f06tk34QqzRnlV;
	Mon, 26 Jan 2026 13:15:26 +0100 (CET)
Message-ID: <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org>
Date: Mon, 26 Jan 2026 13:15:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by
 using spaces
To: Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 26.01.26 um 11:45 schrieb Chris Idema via GitGitGadget:
> From: Chris Idema <github_chris_idema@proton.me>
> 
> Tabs were not properly rendered in TK regardless of tab width settings.

Sorry, I cannot reproduce what I read into this sentence. When I change
the "Tab spacing" option in the Options dialog, the display changes to
the specified tab width. I'm using Tcl/Tk 8.6.

> Converting tab alignment to spaces before rendering in TK fixes this.

Do "Stage Line/Hunk for Commit" still work after this conversion?

-- Hannes

