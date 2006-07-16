From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Sun, 16 Jul 2006 16:00:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607161559010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyh1ncm0.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 16 16:00:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G27AM-00076Z-U7
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 16:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946067AbWGPOAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 10:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946073AbWGPOAG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 10:00:06 -0400
Received: from mail.gmx.net ([213.165.64.21]:50621 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1946067AbWGPOAF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 10:00:05 -0400
Received: (qmail invoked by alias); 16 Jul 2006 14:00:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 16 Jul 2006 16:00:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87fyh1ncm0.fsf@mid.deneb.enyo.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23951>

Hi,

On Sun, 16 Jul 2006, Florian Weimer wrote:

> * Johannes Schindelin:
> 
> > Hi,
> >
> > On Fri, 7 Jul 2006, Florian Weimer wrote:
> >
> >> -               s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
> >> +               s->data = mmap(NULL, s->size, PROT_READ, MAP_SHARED, fd, 0);
> >
> > Be advised that this breaks setups with NO_MMAP, in particular most (all) 
> > cygwin setups I know of.
> 
> Are these Cygwin setups running on top of the Windows 95 code base by
> chance?

No. One is Windows2000, the other WindowsXP, and both need the NO_MMAP 
set. For obvious reasons, NO_MMAP does not support MAP_SHARED...

Ciao,
Dscho
