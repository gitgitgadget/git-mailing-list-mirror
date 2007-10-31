From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: How to remove a specific hunk
Date: Wed, 31 Oct 2007 13:00:11 +0100
Message-ID: <20071031120011.GI4435@xp.machine.xx>
References: <4722036E.5030204@wanadoo.fr> <20071026192034.GA3062@steel.home> <13D08D3F-3647-4E20-AF80-8EC6FD14E66A@lrde.epita.fr> <Pine.LNX.4.64.0710311104450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Alex Riesen <raa.lkml@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:00:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InCFA-0005l4-CI
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 13:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbXJaMAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 08:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbXJaMAG
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 08:00:06 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:41639 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753156AbXJaMAF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 08:00:05 -0400
Received: (qmail 5950 invoked by uid 0); 31 Oct 2007 12:00:00 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 31 Oct 2007 12:00:00 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710311104450.4362@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


spearce Cc'ed, because this seems like a nice feature to add to git-gui
In no way should this imply that YOU have to implement this!


On Wed, Oct 31, 2007 at 11:06:18AM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 31 Oct 2007, Benoit SIGOURE wrote:
> 
> > On Oct 26, 2007, at 9:20 PM, Alex Riesen wrote:
> > 
> > > Pascal Obry, Fri, Oct 26, 2007 17:10:38 +0200:
> > > > 
> > > > Before committing sometimes I want to remove a specific hunk. Say in
> > > > file a.txt I have in the diff 3 hunks, I want to revert/delete/remove
> > > > the second one. Is there a way to do that ?
> > > 
> > > Take a look at git-gui. Try right-clicking in the diff pane at the
> > > bottom.
> > 
> > This only allows you to stage a given hunk, not to remove one.  Right 
> > now I'm in a situation where I need to remove a specific hunk to compile 
> > and it's sad that git-gui doesn't provide an option so that you can 
> > right-click -> revert hunk.
> 
> You have seen that there are two different file lists, "staged changes" 
> and "unstaged changes", right?  AFAIK if you click on the file in "staged 
> changes", you can find the staged hunk and then remove it from the staged 
> area.
> 
> "Revert hunk" would not make any sense, since the hunk disappears once you 
> staged/unstaged it.
> 

On the other hand, something like this would allow you to remove bogus
hunks like debug statements you want to lose, because you tested it and
all works now.

Now you first have to stage all the things you want to keep, and then
select "Commit->Revert Changes" in the menu to remove a hunk forever which
is a little clumsy if you have many hunks and just want to remove one of
them. Seems like a nice feature to add to git gui if you throw in an extra
Yes-No question for the user IFF he realy wants to remove the hunk forever.

-Peter
