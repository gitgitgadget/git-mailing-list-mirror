Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02522258C
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443115; cv=none; b=ezbfIP5CNvcKL38GqtJDhoysVHAhBIN1D+dQ97jHVtyz5EfVuQUx8o4NqcCHC9T8LuXlcHv28hHmeXQuz0qqRn7G8pXu+7xRz32TO/dGeCvsoq87zPhCcqn83WdBtQ/Em7R389WlG7WnyRB/9jSydPjv1w+K3BgqUNVJC82pm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443115; c=relaxed/simple;
	bh=twj8olAN+oMmPBHOZUCH4af9aJja+kztVMsUXQV2yH4=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To; b=CmFKV0cMNt+0bDPLUre3SD1vh7jfmKj3OXBRRFmeiw47CYD8fs83me1P1lUK2EmGgCuzj6Wn8Jh5tZTCeiWthczkEQWz0q3wVm3egpf3LmWTSIBoPKZhLT2L1V0nFkj2tgUa0UfBb9GJq8gv9fRMcfFMJoEjxvaRdQnlOG9g+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcvg-git-3@m.gmane-mx.org>)
	id 1uw39f-0006vj-Co
	for git@vger.kernel.org; Tue, 09 Sep 2025 20:33:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
From: Jon Forrest <nobozo@gmail.com>
Subject: Re: Is Git Add Supposed to Work Like This (git 2.50)?
Date: Tue, 9 Sep 2025 11:33:18 -0700
Message-ID: <109prte$j8b$1@ciao.gmane.io>
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
 <20250907233456.GA1281511@coredump.intra.peff.net>
 <b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>

On 9/9/25 9:00 AM, Jon Forrest wrote:
> 
> 
> If this were a big deal, which it isn't, I'd suggest a command line
> flag that says what to do if there's an invalid file specified on
> the command line. One setting of the flag would result in the
> current behavior and the other setting would result in all the
> invalid file(s) being ignored and the valid file(s) being
> handled normally.

Nevermind. I should have checked the man page.
The '--ignore-errors' option already does this.

Sorry for the bother.

Jon


