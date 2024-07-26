Received: from donotpassgo.dyslexicfish.net (donotpassgo.dyslexicfish.net [209.250.224.51])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D02524F
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.250.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721955954; cv=none; b=u21WsXGDbBmqAv49HP4rQZSfsa7xTF/TPJ20v8ZFJ+Lcgo/yUba+y7dqupWFGfP+yc//N1yQgnT/NscjTUxcdDCHNk937STD+EZ/J6BO+yYrKJ54rM2WZCVluct4TaT7ZbzlLW5NDgLc2Am5GWBHPJoluR+3wgls+HpGAhbZyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721955954; c=relaxed/simple;
	bh=4QJI3BbW+KnDgdVt0iYCyYufOok/pBJPxQcICSE8mH8=;
	h=From:Message-Id:Date:To:Cc:Subject:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ZDo60ZTZCx2h6sltjZL9iaBIe1UUAd20g66Tod6BP/v222lqqAEgtQgf7mgTVMXizzW5QVzXPrsjI13JvRqqvSN6L5TqGj1wTisGMCg2Vr3Rp3XU42jIWw/EHMxK4zZA6wQqsX20nvFQyS6eBYgBg5wjZ5F7S+zCgOJCgcEb+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=catflap.org; spf=pass smtp.mailfrom=catflap.org; arc=none smtp.client-ip=209.250.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=catflap.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catflap.org
X-Catflap-Envelope-From: <jamie@donotpassgo.dyslexicfish.net>
X-Catflap-Envelope-To: git@vger.kernel.org
Received: from donotpassgo.dyslexicfish.net (donotpassgo.dyslexicfish.net [209.250.224.51])
	by donotpassgo.dyslexicfish.net (8.14.5/8.14.5) with ESMTP id 46Q0ctOE083267;
	Fri, 26 Jul 2024 01:38:56 +0100 (BST)
	(envelope-from jamie@donotpassgo.dyslexicfish.net)
Received: (from jamie@localhost)
	by donotpassgo.dyslexicfish.net (8.14.5/8.14.5/Submit) id 46Q0ctEV083266;
	Fri, 26 Jul 2024 01:38:55 +0100 (BST)
	(envelope-from jamie)
From: Jamie Landeg-Jones <jamie@catflap.org>
Message-Id: <202407260038.46Q0ctEV083266@donotpassgo.dyslexicfish.net>
Date: Fri, 26 Jul 2024 01:38:55 +0100
Organization: Dyslexic Fish
To: Johannes.Schindelin@gmx.de, gitster@pobox.com
Cc: msuchanek@suse.de, git@vger.kernel.org, drankinatty@gmail.com
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
In-Reply-To: <xmqqr0cl6lxl.fsf@gitster.g>
User-Agent: Heirloom mailx 12.4 7/29/08
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.7 (donotpassgo.dyslexicfish.net [209.250.224.51]); Fri, 26 Jul 2024 01:38:56 +0100 (BST)

Junio C Hamano <gitster@pobox.com> wrote:

> Dscho, the f4aa8c8b (fetch/clone: detect dubious ownership of local
> repositories, 2024-04-10) is your brainchild and people seem to be
> unhappy about having to adjust their settings.  Are there any advice
> you can offer them?

This thread has gone quiet. Is it going to be fixed? The issue isn't that
settings need to be adjusted, it's that it no longer works whatever
your settings are.

I had to go back to.2.45.0

Cheers

