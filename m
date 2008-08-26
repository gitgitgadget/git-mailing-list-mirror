From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 15:23:53 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808261517200.19665@iabervon.org>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <20080826172410.GJ26523@spearce.org> <7v1w0bab1c.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808261455010.19665@iabervon.org>
 <20080826190752.GM26523@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, andi@firstfloor.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:25:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4A0-0001PR-91
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757560AbYHZTXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757458AbYHZTXz
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:23:55 -0400
Received: from iabervon.org ([66.92.72.58]:47565 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956AbYHZTXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:23:54 -0400
Received: (qmail 7242 invoked by uid 1000); 26 Aug 2008 19:23:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2008 19:23:53 -0000
In-Reply-To: <20080826190752.GM26523@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93803>

On Tue, 26 Aug 2008, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Tue, 26 Aug 2008, Junio C Hamano wrote:
> > > 
> > > Unless/until we have an easy way to obtain the information "git-ls-files
> > > -u" gives during conflict resolution, ls-files should stay on the list of
> > > commonly used commands.
> > 
> > Doesn't "git status" tell you that? Or do you want the extra info from the 
> > implicit --stage?
> 
> I think he doesn't want to see the other files that are already
> merged successfully.  git status shows them, git ls-files -u
> does not.

I think it might make sense to support "git status --unmerged" or 
something like that, where it filters the output by the tags it would 
show.

	-Daniel
*This .sig left intentionally blank*
