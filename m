From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Fri, 19 May 2006 21:36:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605192116360.6713@iabervon.org>
References: <e4f1ta$e07$1@sea.gmane.org> <87y7wyv72m.fsf@morpheus.hq.vtech>
 <20060519092136.GN22257@spearce.org> <Pine.LNX.4.64.0605192006400.6713@iabervon.org>
 <7vy7wxfs7v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 03:35:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhGNe-0003yS-7P
	for gcvg-git@gmane.org; Sat, 20 May 2006 03:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWETBfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 21:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWETBfg
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 21:35:36 -0400
Received: from iabervon.org ([66.92.72.58]:38920 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964787AbWETBff (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 21:35:35 -0400
Received: (qmail 5960 invoked by uid 1000); 19 May 2006 21:36:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 May 2006 21:36:47 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7wxfs7v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20370>

On Fri, 19 May 2006, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > $ git pull . stuff
> > # Notice that the diffstat is exciting
> > # What did I just get?
> > $ git log master@{5 minutes ago}..master
> >
> > This is about the only easy way to find out that the fast-forward you just 
> > did included merging a line which contains a commit from several weeks 
> > ago. (Because the "before" state isn't easily accessible for a 
> > fast-forward, and the date of the old commit puts it way back in a 
> > date-ordered log.)
> 
> Did you forget about "git log ORIG_HEAD.."?

I guess I did forget that it sticks around. So you have to be doing 
something somewhat more complicated, like fetching the latest versions of 
multiple topic branches.

	-Daniel
*This .sig left intentionally blank*
