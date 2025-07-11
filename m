Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170C28B519
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244822; cv=none; b=dfhtCfu7/WoGRKXpR8OztSfM9D4yLQxip/GkX6KaTSbs1VndeeRUSWwI2vx9EXCTqO3M16rACgjeTuIZEzoW2KbHsFA0QJxnJFXt5GTKGVrWKJ3jbipiA9pBh+DYRiwpFp9AnEKUqbdXArNt4v+gXu4nKxq2H6UQ8EHq6mSm/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244822; c=relaxed/simple;
	bh=Wa+BFINExoBK2646C5MKaWN8FHwek30CKRqP2/IZEZc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yq+2r/ZguUHuUvmMQodWtO3+MIwoqN+ayADf2EagWMmbmagMiMEpCOFEPT/gxSTh4cXdi5HVO5wXrIS8wspYzPG0rUcH3oKrqmhT8yyQHa4I8LhASb2SaJs2xzOWXNHMeni11xvfSbBAszWtzKlEJoH3Af3mt6I05w6ogxbUY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Wli7T2Lu; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Wli7T2Lu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752244813; x=1752849613;
	i=johannes.schindelin@gmx.de;
	bh=pPXPRlyaK1ndYTJ8oS8tAvND5Ll+lbiUKqjjLn30ICE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wli7T2LuYso4yxYBFxTnOIZwc1psOjDpDGdXB5lYL72HmzG+pAJhhTfHH4o9LBOt
	 +FLXGB5g4Bd0SpD9ilQ8bkvrafVqtODBYPEZQX3OF1KG4UWgV1YN2uH+1/yjRPWdr
	 EJgFsQBiCMgjUfv5PpIfUxoR47Z6KbVTirWdp/WQYxetIxsRut+TK9ajUaAY6w2ku
	 jF4pYa8yH4BQCW4gZb3niUMU6csBYu2IexgXq+NiB819pLcOaLNk4Q7eSu5iWhfHj
	 BwebT7+qiKy259cF9KYpoDrvxQ3pF6rqOJ2Ci6cWj30H+qIuOfUvqJG2YgZ5FEDaL
	 k5IKYw0WUx3gx5iPaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([176.6.68.98]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1uM1Q60OWi-00JYdj; Fri, 11
 Jul 2025 16:40:10 +0200
Date: Fri, 11 Jul 2025 16:40:03 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Preston, David J." <David.Preston@onegas.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git bash bug
In-Reply-To: <PH7PR11MB65466DEE20BA470C600C7B9B9549A@PH7PR11MB6546.namprd11.prod.outlook.com>
Message-ID: <a8cfe8ee-81ab-b0e6-a82b-f8cbeb0d9122@gmx.de>
References: <PH7PR11MB65466DEE20BA470C600C7B9B9549A@PH7PR11MB6546.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F+bLFkRwH8P0VZwjwQnZNEv3hc8R+kaFrG0NjFQClLrnhJx2e8K
 RoSJHczNaZskrV5cApWMxCwH+wDoary+CIcZdYERhruY5bWSNs5SxjGCauUULuq1oGpSkcb
 YC8RK4Ki4h4csThOqw9BqwhkFQThx+mbLLFI2M9MHG/e8b4x8X8TQveGEBJ79fXFuoPEcz8
 u5seODkhqV+gUZ2B4CflA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FKZO8qXChxk=;RkE1VKVlN8mI2gCTmH33GLA9S76
 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
 2W5pIe4oTo2Dkr5zefG6Vin8d+WhnCi0=

Hi David,

On Wed, 9 Jul 2025, Preston, David J. wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> started happening after an update to a newer version of git... has been
> happening for a while, so i am not sure what version it started with
>
> What did you expect to happen? (Expected behavior)
> when using git bash in windows environment, when a previously typed
> command is executing and i start typing, i expect that what i type will
> eventually show up on the command line, in the order i typed it, once
> the executing command completes.
>
> What happened instead? (Actual behavior)
> letters that i have typed show up in a different order than i typed
> them.  basically, i think there is some async processing going on, and
> keyboard input is being handled in such a way that the keystrokes are
> output to the console in an order that is random based on race
> conditions in the async code.
>
> What's different between what you expected and what actually happened?
> keys output in a different order than i typed them in.

This is essentially the same issue that has been reported at
https://github.com/git-for-windows/git/issues/5632.

The problem is in the MSYS2 runtime, which is the POSIX emulation layer
required to run Bash that Git for Windows employed, which in turn is a
friendly fork of the Cygwin runtime.

I haven't had time to report this bug over in Cygwin yet (for which I
would have to verify that this bug reproduces with their own Bash running
in their own MinTTY). Maybe you can help out and install Cygwin
(https://cygwin.com) and perform that test?

Thanks,
Johannes
