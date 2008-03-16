From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 18:18:58 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803161812340.19665@iabervon.org>
References: <frh8dg$t9j$1@ger.gmane.org> <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo> <7vwso2ieuu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803161716470.19665@iabervon.org> <7vwso2gwnf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:19:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1Ce-0000Iv-Go
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 23:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYCPWTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 18:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYCPWTA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 18:19:00 -0400
Received: from iabervon.org ([66.92.72.58]:56422 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYCPWS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 18:18:59 -0400
Received: (qmail 13230 invoked by uid 1000); 16 Mar 2008 22:18:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2008 22:18:58 -0000
In-Reply-To: <7vwso2gwnf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77392>

On Sun, 16 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I'm not sure any older code actually enforced this, either
> 
> I am fairly sure the old code was written with the intention in mind (I
> wrote it, in other words).  It meant to accept refs/<anything>/* and no
> other wildcard.

I know that's all it was supposed to accept, but I don't remember seeing 
anything to enforce that. Actually, I don't now remember what the old code 
looked like at all, so I might be wrong about that.

Is "refs/*:refs/*" (mirror everything, including weird stuff) supposed to 
be prohibited?

> Does your patch require * to be at the end?

Looks like it just ignores anything after a *. Want checks for that as 
well?

	-Daniel
*This .sig left intentionally blank*
