From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 11:51:47 -0400
Message-ID: <20071004155147.GA17487@fieldses.org>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com> <20071004125641.GE15339@genesis.frugalware.org> <7vy7ej9g38.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710041534000.4174@racer.site> <vpqtzp7ndn3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdT08-0006yi-OJ
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbXJDPwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 11:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbXJDPwY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:52:24 -0400
Received: from mail.fieldses.org ([66.93.2.214]:58462 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbXJDPwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:52:23 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IdSzL-0004uc-CN; Thu, 04 Oct 2007 11:51:47 -0400
Content-Disposition: inline
In-Reply-To: <vpqtzp7ndn3.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59970>

On Thu, Oct 04, 2007 at 04:44:00PM +0200, Matthieu Moy wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Thu, 4 Oct 2007, Junio C Hamano wrote:
> >
> >>  * --cached means work only on index and ignore work tree.
> >
> > I guess I could live with "--staged" as a synonym for "--cached" (and 
> > maybe deprecating "--cached").
> 
> It makes more sense to me.
> 
> For me, a "cache" is a fast-access copy of something, that I can
> rebuild at any time. Cache should be only a matter of performance, if
> the "cache" for an application changes its functionality, it means the
> cache has been too optimistic. Git's index is not that, "git add"
> means "add this to the index", which itself means "put that in the
> list of things to commit", and not "get a copy of that to work faster
> with it".

Yes, the index differs from the work tree or HEAD temporarily, but most
of it's life it's just a fast-access copy of something that you can
rebuild at any time.

So it's partly a "cache", partly a "staging area", and "index" is as
good a term for it as any.

--b.
