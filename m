Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9BA1D0B9E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042167; cv=none; b=CWIxYNzQfSYC2RDJk2EBlvrRMo542F9n1v57ZdCYhUEWzl0imPvwG8/LXbL2uuWYbrGiOqCGxDHZGKUaNmctLiJzPbkiJCH6yQz8Ba+b1BKR8LBNadbeXTRYRRFIz2T4kEfe2Jqip7ndebLOyZcW4Uzhw1hie+aq4N2CVO/F8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042167; c=relaxed/simple;
	bh=JNxhMcaZMEP3ENOHaJ3rgVrtuEK+ko9zqLrNLdu1fJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgL0OW0XBME7uYFvWuhh0egmc2lvDYTKuv/8wTX9s8/eZKCt95EmX24PiqxiFHco6P6ICwaBRaS9F6orCtOB8Ye77lLS0WSMgOQce3Jx5UDO5OKgFoxmSe8nj09pWcbQF/8u0417AvDVqVBZNX3dHiBCs769iSUU2EltM8Oydk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XtD6w2vJMzRnlK;
	Tue, 19 Nov 2024 19:49:10 +0100 (CET)
Message-ID: <3184ac87-f53c-4b21-99ba-e3ef7fc648a7@kdbg.org>
Date: Tue, 19 Nov 2024 19:49:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Gitk maintainership, was Re: The health of gitk
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Beat Bolli <dev+git@drbeat.li>, Tobias Pietzsch <tobias.pietzsch@gmail.com>
References: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
 <bdaab72b-37f4-658a-716a-d6a958b6f709@drbeat.li>
 <ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>
 <ZzWkgblaoWehC0kY@thinks.paulus.ozlabs.org>
 <5ccc1943-c2a3-4896-a858-aa5fd6cdd426@kdbg.org>
 <Zzxhn64xeQv6ItXm@thinks.paulus.ozlabs.org>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Zzxhn64xeQv6ItXm@thinks.paulus.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.11.24 um 10:59 schrieb Paul Mackerras:
> In the current upstream git tree, I see two commits that were applied
> to a clone of my tree, then pulled into the git tree:
> 
> bb5cb23daf751790950ff9f761f8884e21c88d00
> 7dd272eca153058da2e8d5b9960bbbf0b4f0cbaa
> 
> I assume you can pull them into your clone of my tree using suitable
> git commands (I guess you would create a branch with 7dd272eca153 as
> its head and do git pull --ff from that).
> 
> There are three commits that touch the gitk-git directory in the git
> tree directly:
> 
> 65175d9ea26bebeb9d69977d0e75efc0e88dbced
> d05b08cd52cfda627f1d865bdfe6040a2c9521b5
> 728b9ac0c3b93aaa4ea80280c591deb198051785
> 
> I assume you want to make the same changes in your gitk tree, so as to
> avoid conflicts in future.  I expect git would merge commits in the
> gitk tree making the same changes as are already in the git repo
> without fuss.
> 
> There is also b117cee32259acf923c3ada52b4dd89f2ea6a454 which touches
> gitk-git in the 'seen' branch of the git tree.  I don't know what you
> would need to do about that, if anything.

Thanks a lot for doing all the digging, this is very helpful. I'll
publish the repository on Github later this week or over the weekend.

-- Hannes

