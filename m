From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 10:15:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231014050.20400@racer.site>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708222033040.16727@xanadu.home>
 <alpine.LFD.0.999.0708222006110.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8nj-0001He-1e
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760629AbXHWJQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 05:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756644AbXHWJQS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:16:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:38908 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760349AbXHWJQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 05:16:17 -0400
Received: (qmail invoked by alias); 23 Aug 2007 09:16:15 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp046) with SMTP; 23 Aug 2007 11:16:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WJypGCr+WO1yo28BgWaluA5I4qujHdXD929e3kU
	c8T+zQtV/mEEmh
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0708222006110.30176@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56481>

Hi,

On Wed, 22 Aug 2007, Linus Torvalds wrote:

> On Wed, 22 Aug 2007, Nicolas Pitre wrote:
>
> > Linus wrote:
> >
> > > I'd love for every single shell-script in git core to be written in 
> > > C, so that we can drop the dependency on shell *entirely*.
> > 
> > What about the test suite?
> 
> The test suite is indeed special. But I think that's a "build 
> requiement", and if we require something like shell for *building*, 
> that's different from requiring normal users to have it.

And do not forget that "make install" is not _part_ of "make install".  If 
you do not want to check that all is fine, but trust the other 
suc^Wdevelopers, you can just omit running the tests.

Ciao,
Dscho
