From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Sun, 15 May 2005 08:22:43 +0200
Message-ID: <20050515062243.GA22021@elte.hu>
References: <20050512094406.GZ5914@waste.org> <20050512182340.GA324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 15 08:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXCYh-0000Fk-HG
	for gcvg-git@gmane.org; Sun, 15 May 2005 08:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEOGYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 02:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVEOGYx
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 02:24:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46271 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261493AbVEOGYt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 02:24:49 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 63A8231C33C;
	Sun, 15 May 2005 08:21:01 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id DE9A41FC2; Sun, 15 May 2005 08:22:54 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050512182340.GA324@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

> > Mercurial is also much smarter than rsync at determining what
> > outstanding changesets exist. Here's an empty pull as a demonstration:
> > 
> >  $ time hg merge hg://selenic.com/linux-hg/
> >  retrieving changegroup
> > 
> >  real    0m0.363s
> >  user    0m0.083s
> >  sys     0m0.007s
> > 
> > That's a single http request and a one line response.
> 
> So, what about comparing it with something comparable, say git pull 
> over HTTP? :-)

Matt, did you get around to do such a comparison?

	Ingo
