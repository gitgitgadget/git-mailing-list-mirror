Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DB342169
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146938; cv=none; b=JDdR7fi9lfuGBjLY30V0gRlpgvtQ8Jjvqs3FrL5lcW/sWomyr/zWadaypV1thXPmrq+9DWuXEVlnRQaE2IdACXzrrxYinR4wD7/llKjiX9KuV+h+U5cUVdzQ1tqLedbxVs9bN3Kl0gwjG5yiI+KodGYt/i4+3JCUOTYgWbQchvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146938; c=relaxed/simple;
	bh=8dqxtJxNfIv21GfiH7uJvMyzvYrl5axTQNsrBTPl6SE=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=K+1dLk6WFxxBjrjFNfHRcXZ/Ha8TtrdRn4Hdu/v94Nxk01lhQzL2ws1S81Zt8goP6a2/D2FHouSdBjU17VjvdIiwP1xXvhY2HN9HY9ruqFvUba1jHeIG7ynUqshYkGjl9ecH4wIhLDIk0z0BNhiRVmUcKA3kKWQ+o+nl+Ls8sL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 84049 invoked by uid 3782); 11 Jan 2026 16:55:35 +0100
Received: from muc.de (pd953a70b.dip0.t-ipconnect.de [217.83.167.11]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Sun, 11 Jan 2026 16:55:34 +0100
Received: (qmail 7433 invoked by uid 1000); 11 Jan 2026 15:55:34 -0000
Date: Sun, 11 Jan 2026 15:55:34 +0000
To: git@vger.kernel.org
Cc: acm@muc.de
Subject: Re: Difficulties using git rebase.  Help, please!
Message-ID: <aWPH9gY9VA6vW-gc@MAC.fritz.box>
References: <aWPC39kUFrvt00lY@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWPC39kUFrvt00lY@MAC.fritz.box>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

On Sun, Jan 11, 2026 at 15:33:51 +0000, Alan Mackenzie wrote:
> Hello, Git.

> Some while ago I made some amendments to the Linux kernel for my own use
> (at least).  I now want to rebase these changes onto the master branch of
> the Linux Stable repository.

[ .... ]

Sorry, I forgot to mention I'm using git version 2.52.0.

-- 
Alan Mackenzie (Nuremberg, Germany).
