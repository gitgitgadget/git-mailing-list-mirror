From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Thu, 21 Apr 2005 09:49:08 +0200
Message-ID: <20050421074908.GA1376@elte.hu>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Greg KH <greg@kroah.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 09:51:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOWS8-0001IB-Fr
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 09:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVDUHyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 03:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDUHy0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 03:54:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24708 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261488AbVDUHtP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 03:49:15 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 4987931F5CC;
	Thu, 21 Apr 2005 09:48:26 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id BA2461FC2; Thu, 21 Apr 2005 09:49:11 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Yeah, yeah, it looks different from "cvs update", but dammit, wouldn't 
> it be cool to just write "cg-<tab><tab>" and see the command choices?  
> Or "cg-up<tab>" and get cg-update done for you..

add this line to your ~/.bashrc:

 complete -W "add addremote apply cancel ci commit diff export fork help init log ls lsobj lsremote merge pull rm seek status tag track version" git

and you'll get all the argument completions, after "git " (it works on 
arguments, after the space). (you can even customize it to list only the 
ones you typically use, to make the completion faster) This first showed 
up in zsh but now bash knows it too. (see 'Programmable Completions' in 
man bash)

	Ingo
