From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to remove a specific hunk
Date: Wed, 31 Oct 2007 11:06:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710311104450.4362@racer.site>
References: <4722036E.5030204@wanadoo.fr> <20071026192034.GA3062@steel.home>
 <13D08D3F-3647-4E20-AF80-8EC6FD14E66A@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Wed Oct 31 12:07:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InBPs-00057M-Ee
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 12:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412AbXJaLHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 07:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757281AbXJaLHF
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 07:07:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:60537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756866AbXJaLHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 07:07:01 -0400
Received: (qmail invoked by alias); 31 Oct 2007 11:06:59 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp021) with SMTP; 31 Oct 2007 12:06:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vLi9jDkZv4oDUj3uhcnRlH+cENdC0FRhBODadOL
	z800IXVIduX2Ut
X-X-Sender: gene099@racer.site
In-Reply-To: <13D08D3F-3647-4E20-AF80-8EC6FD14E66A@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 31 Oct 2007, Benoit SIGOURE wrote:

> On Oct 26, 2007, at 9:20 PM, Alex Riesen wrote:
> 
> > Pascal Obry, Fri, Oct 26, 2007 17:10:38 +0200:
> > > 
> > > I'm very new to Git... but start to love it :)
> > > 
> > > Before committing sometimes I want to remove a specific hunk. Say in
> > > file a.txt I have in the diff 3 hunks, I want to revert/delete/remove
> > > the second one. Is there a way to do that ?
> > 
> > Take a look at git-gui. Try right-clicking in the diff pane at the
> > bottom.
> 
> This only allows you to stage a given hunk, not to remove one.  Right 
> now I'm in a situation where I need to remove a specific hunk to compile 
> and it's sad that git-gui doesn't provide an option so that you can 
> right-click -> revert hunk.

You have seen that there are two different file lists, "staged changes" 
and "unstaged changes", right?  AFAIK if you click on the file in "staged 
changes", you can find the staged hunk and then remove it from the staged 
area.

"Revert hunk" would not make any sense, since the hunk disappears once you 
staged/unstaged it.

Ciao,
Dscho
