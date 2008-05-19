From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: t3701 fails if core.filemode disabled
Date: Mon, 19 May 2008 22:23:42 +0200
Message-ID: <20080519202342.GA9694@steel.home>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net> <20080518200121.GA5789@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 22:25:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyBuQ-0000PT-Af
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 22:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbYESUXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754989AbYESUXr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 16:23:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:10847 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbYESUXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 16:23:46 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyHI8Q==
Received: from tigra.home (Fac8f.f.strato-dslnet.de [195.4.172.143])
	by post.webmailer.de (mrclete mo5) (RZmta 16.34)
	with ESMTP id Y017a8k4JJKQrB ; Mon, 19 May 2008 22:23:43 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CE4DD277BD;
	Mon, 19 May 2008 22:23:42 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A3E3956D28; Mon, 19 May 2008 22:23:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080518200121.GA5789@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82446>

Alex Riesen, Sun, May 18, 2008 22:01:21 +0200:
> Jeff King, Sun, May 18, 2008 21:08:39 +0200:
> > I don't mind disabling these tests if they don't make sense on certain
> > platforms, but regarding your specific proposal:
> > 
> >   - can you confirm that the test doesn't make sense, and not that it is
> >     simply broken on cygwin? Does changing your ~/.gitconfig's
> >     core.filemode make a difference? It shouldn't, but that could be
> >     a bug in test-lib. What happens if you run the test manually? Does
> >     git-add just not prompt for the mode change?
> 
> I setting core.filemode _inside_ the test breaks it in exactly the
> same way (on Linux, I'm at home). I'll retest tomorrow

It is "git init" which sets core.filemode false (of course!)
