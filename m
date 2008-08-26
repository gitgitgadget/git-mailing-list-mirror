From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 12:07:52 -0700
Message-ID: <20080826190752.GM26523@spearce.org>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <20080826172410.GJ26523@spearce.org> <7v1w0bab1c.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808261455010.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, andi@firstfloor.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:09:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3uX-0004ni-FI
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758798AbYHZTHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757614AbYHZTHx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:07:53 -0400
Received: from george.spearce.org ([209.20.77.23]:48139 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757593AbYHZTHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:07:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 632E438375; Tue, 26 Aug 2008 19:07:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0808261455010.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93801>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 26 Aug 2008, Junio C Hamano wrote:
> > 
> > Unless/until we have an easy way to obtain the information "git-ls-files
> > -u" gives during conflict resolution, ls-files should stay on the list of
> > commonly used commands.
> 
> Doesn't "git status" tell you that? Or do you want the extra info from the 
> implicit --stage?

I think he doesn't want to see the other files that are already
merged successfully.  git status shows them, git ls-files -u
does not.

-- 
Shawn.
