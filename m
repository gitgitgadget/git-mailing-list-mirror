Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817E1946F
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871298; cv=none; b=Lt+nNh6UlUU79Nc7YVfReLT1gJILhJnGK1yIBhjOITUNVBK4PozvHNEklQDmxEeU7+FdZVZE6OW3KwJN8GQKcNj4H9+lsxsOWlX/AJbuGEOHPdiC8IN9PoDjxBIJSi26Jdy2Qgw+moxcfZiRyMt0a/czl5Iu81wjYIvzXzQ5zWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871298; c=relaxed/simple;
	bh=ZidGPjJ+YNYPVG/JoSgUbDVotdPwL+kdVOc5sZZK3Jg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=n3FMIYTweULZpY1tC43nkKXmjEuGC7ouxVRa5ybSsAIzgoNBWoc2T3oPCSwMyzwpMDwUfZT301FbqclWaI/iQrMt8Zyzsqk8te4abrDgS+xxgUzv9ORR48HtU6uE8n+LUL8I2cqGHt/UNAz485rskfAzOrPHoURXW7gPdO7qE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jJKM8cmx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jJKM8cmx"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706871292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWBaS8W9okOow4B1spgol0tSeUaIxaq4BdY4B+T8Aic=;
	b=jJKM8cmxcoFWIG4JHCLhw4wYUmTquY9PeRhSBH/3rJc24GYgGa0GmVeMmyaLwu01UTaeLp
	sMvndLZfw50xuH9zwNyh2xVD0rwpJXLud7m9HcLUu/sdYH2Nx7gYcb33cJNpLGxJ0bMdhv
	2NWiuUNqG999EdxTqDxvG3Y9i53Hi86jNBg/qpbJtLNonWaZluHH9PZL7iXHZD4oaizxTV
	YG8RFXEmY0eXBf9Ks3UZ4fWU+lWZYRbPC9yuqs1j4US3q3abcpd5rtB4jQmMH1o4tBt6zm
	IUFLoINpbK1cKYgyG2q7RVyPT0zv3NjuMgO3EwR+AadIjwMl2AfGtXEfEWZt7A==
Date: Fri, 02 Feb 2024 11:54:51 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Hans Meiser <brille1@hotmail.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <DB9P195MB2130EB8EB69A8140A31BB432E2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
 <DB9P195MB2130EB8EB69A8140A31BB432E2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
Message-ID: <c9a0cb1fe64f8e7d21c21458e5e76af9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-02 11:18, Hans Meiser wrote:
>> Please keep in mind that editing the git man pages requires very
>> intimate knowledge of the related git source code.  Many times even
>> small changes to the language style can change the meaning and diverge
>> the man pages from the source code, making the man pages useless.
> 
> Sure. Eventually, I'd rather propose to have parts of the man pages be
> generated from code comments (XmlDoc, JsDoc or similar), particularly
> syntax and parameter list. That would keep documentation from
> deviating from code right from the beginning. And it would keep
> documentation writers from manually updating obvious parts.

That might work out in some places, but I'm not really sure about the
overall effectiveness.  The git man pages don't document function calls.

>> A git server?  I was under impression that you proposed running an
>> own instance of GitLab or something similar.
> 
> Basically, GitLab, GitHub, Azure DevOps are all just Git servers, plus
> collaboration and automation functionality. I suggested using GitWeb
> only in case you wanted to write  (and keep control over)
> collaboration and automation functionality yourself. Otherwise you may
> use one of the existing ones that have already been written (i.e.,
> GitLab, GitHub, Azure DevOps).

The plus brings additional issues.  It's been already noted that 
favoring
any of those solutions actually wouldn't be in the interest of git 
itself
as a project, because it wants to remain neutral.

IMHO, these days too much is expected to be handled by "something else",
instead of the developers handling that.  It's like offloading the 
basically
unavoidable complexity to some utility, and expecting that the 
complexity
will somehow go away.

In other words, a developer has to keep quite a lot in their short-term
memory, and a lot in their long-term memory, to be able to accomplish 
some
task, and hardly any utility is going to make that significantly easier.
The same principle, in general, applies to a group of developers working
on the same task.
