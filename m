From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Tue, 19 Feb 2008 19:02:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802191856420.19024@iabervon.org>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org> <47BAF18F.5040709@freescale.com> <alpine.LNX.1.00.0802191127080.19024@iabervon.org> <7vy79ghbob.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:02:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRcQ7-0008OQ-Rn
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbYBTACJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYBTACI
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:02:08 -0500
Received: from iabervon.org ([66.92.72.58]:40657 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659AbYBTACG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:02:06 -0500
Received: (qmail 31841 invoked by uid 1000); 20 Feb 2008 00:02:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2008 00:02:04 -0000
In-Reply-To: <7vy79ghbob.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74480>

On Tue, 19 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Tue, 19 Feb 2008, Jon Loeliger wrote:
> >
> >> Also, is "host" really the right config key?  Maybe "rewritehost"?
> >> Or is this thought to be the basis of other (perhaps not rewrite
> >> related) properties of the same host as well?
> >
> > I think it's likely that other properties of the host could show up. I 
> > suspect that uploadpack and receivepack would be useful host-wide if you 
> > were using a lot of ad-hoc repository names on a big site. Rewriting the 
> > URLs is just the itch I had with this scope.
> 
> I'd agree that per-host configuration may be useful, and your
> "paths to programs" may be a good example.  But I think it is
> plausible that a host needs multiple <rewritefrom,rewriteto>
> tuples.

That's probably true, even taking into account the option of having 
multiple froms for the same to.

> Either your '[host "$this_url"] aka = $that_url' or
> Dscho's earlier '[rewrite "$this_url_to"] url = $that_url' shows
> that this is not about host but "prefix part of URL".

Well, it shows that it's *possible* to do this feature that way, although 
I'm not entirely convinced that it's best to do it like that. Are there 
character set concerns with having urls in config keys?

	-Daniel
*This .sig left intentionally blank*
