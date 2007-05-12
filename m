From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/3] Remotes library, take 4
Date: Sat, 12 May 2007 15:37:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705121531480.18541@iabervon.org>
References: <Pine.LNX.4.64.0705121137400.18541@iabervon.org>
 <7vfy61zvtx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 21:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxPN-0005nu-FZ
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbXELThc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbXELThc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:37:32 -0400
Received: from iabervon.org ([66.92.72.58]:1807 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbXELThb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:37:31 -0400
Received: (qmail 8912 invoked by uid 1000); 12 May 2007 19:37:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 19:37:30 -0000
In-Reply-To: <7vfy61zvtx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47085>

On Sat, 12 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Updated for recent review. If remote section name starts with '/', it is 
> > ignored (like in 1.5.0). If a remote section option has no value, it is 
> > also ignored (so it doesn't crash, and to be forward-compatible if we 
> > introduce a boolean option later).
> >
> > The struct refspec field and associated variables are spelled "dst".
> >
> > Part 3 is unchanged.
> 
> It cannot be left unchanged as it is affected by the dest stuff.
> 
> I'll push out a fixed-up one on 'pu' soonish.  Let's stabilize
> this a bit without too many resends.

Yeah, I think we agree on how it should be now, and I'm just confusing 
myself regenerating patches. Although, possibly, the comment about NULL 
value should go into documentation for config_fn_t instead, since it's of 
more general applicability than just this.

	-Daniel
*This .sig left intentionally blank*
