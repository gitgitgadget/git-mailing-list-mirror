Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDC567D
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529388; cv=none; b=MjO98/QjbSs6+f7dsmAMb/dhzgUjgzvmtMQQOAmy+3XMAFNJ3rNfeycaAzeZGPDCxSYWGTifWWlOop3llHwfAagEW5RdtRW+d86A2233fJNYkuu40m/jnNLypN/FsuWIY2vRIB+q49hX0jEZzeA4uSf1ZKhdU7dEHAdzgHevC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529388; c=relaxed/simple;
	bh=T9mnV4UPsNAk/3w+LbN54T7eBQCXpwYRNIOD9Q3DdIo=;
	h=To:From:Subject:Date:Message-ID:Mime-Version:Content-Type; b=swlgcaD+QDDxhUW8zFf1BjgmbjZPWXMFMZ68pWNlqBlXrkCBmadmY/OiUfGery78hTMq/dBXDe5oTh075WRphKA7QSP7cHWxfRYefLsNqr/bZVa+xkEE0aYs2IyJJClGUF4UMt2/kJ6NjpZ6BThZhT9+QxmBn2jVbP7zzzhBqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcvg-git-3@m.gmane-mx.org>)
	id 1tWIXS-0008pU-M2
	for git@vger.kernel.org; Fri, 10 Jan 2025 18:11:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
From: Jon Forrest <nobozo@gmail.com>
Subject: Using Visual Studio Code to Debug/Trace Git?
Date: Fri, 10 Jan 2025 09:11:09 -0800
Message-ID: <vlrkbd$a0r$1@ciao.gmane.io>
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

I'm interested in using Visual Studio Code to help understand
how git works. I'm thinking it would make it easy to see what
actually happens when git commands are run.

What I don't know is how to integrate git's build system into
Visual Studio Code. Has anybody tried this? If not, what tools
do you use to debug git?

Please note that I'm *not* interested in running git from
Visual Studio Code. That's another topic entirely that seems
to be well covered on the Web.

Cordially,
Jon Forrest


