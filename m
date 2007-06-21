From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 16:53:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211649520.4059@racer.site>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com>
 <Pine.LNX.4.64.0706211252190.4059@racer.site> <200706211344.47560.andyparkins@gmail.com>
 <vpqodj9zcxf.fsf@bauges.imag.fr> <Pine.LNX.4.64.0706211417090.4059@racer.site>
 <vpqfy4lxwvl.fsf@bauges.imag.fr> <Pine.LNX.4.64.0706211451480.4059@racer.site>
 <467A9B2C.2060907@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1OyZ-0006Qp-Ta
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 17:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbXFUPxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 11:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbXFUPxh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 11:53:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:59098 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752521AbXFUPxg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 11:53:36 -0400
Received: (qmail invoked by alias); 21 Jun 2007 15:53:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 21 Jun 2007 17:53:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/IrJRdRl/KuhqPwfkwwr5Eb+9kZDuISURnbf7OX
	M8FlLjHrG0wpIi
X-X-Sender: gene099@racer.site
In-Reply-To: <467A9B2C.2060907@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50636>

Hi,

On Thu, 21 Jun 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > Yes. And Git explicitely allows what I call stupid. And yes, those
> > _identical_ files in the test suit should probably all be folded into
> > single files, and the places where they are used should reference _that_
> > single instance.
> >   
> 
> Two files that are identical in the current revision have not necessarily
> been identical from the beginning. Doing what you suggest will cause you to
> lose the history of all but one of those files.
> 
> Files can absolutely become identical in the real world. I know that for a
> fact because it happened to me just this week (see my "Directory renames"
> message from a few days ago.)

No, that message did not convince me. It was way too short on the side of 
facts.

And no, I do not think that two unrelated files can get exactly the same 
content.

Be that as may, even _if_ there were such a case, I'd still try to reuse 
the same file in the working directory. Just because Git can deal 
efficiently with millions of identical files does not mean that a working 
directory can, or worse, human developers.

Ciao,
Dscho
