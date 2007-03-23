From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 18:11:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703231758090.6485@iabervon.org>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org>
 <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
 <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
 <20070323103426.GA15923@diana.vm.bytemark.co.uk> <20070323152102.GA4818@c3sl.ufpr.br>
 <Pine.LNX.4.64.0703231758020.8105@reaper.quantumfyre.co.uk>
 <20070323193427.GA12126@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	=?X-UNKNOWN?Q?Karl_Hasselstr=C3=B6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Mar 23 23:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUryv-00069l-CL
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 23:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327AbXCWWLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 18:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934328AbXCWWLY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 18:11:24 -0400
Received: from iabervon.org ([66.92.72.58]:2716 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934327AbXCWWLX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 18:11:23 -0400
Received: (qmail 30500 invoked by uid 1000); 23 Mar 2007 18:11:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Mar 2007 18:11:22 -0400
In-Reply-To: <20070323193427.GA12126@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42966>

On Fri, 23 Mar 2007, Bruno Cesar Ribas wrote:

> I began to think about it... the idea to have a git-svnserver is to move from
> svn to git and get my dev team not to worry about the transition at the
> start, but it is a good idea to make people get moving to git idea of
> devlopment, right?
> Or the main idea is that we will have a group devloping under git repo and a
> group under svn-gateway for the same project? I don't see a point to have
> this! when a repo type is defined everyone must begin to understand that way,
> even if it was changed in the middle of the project.

It's been useful in the past (when Wine went from CVS to git) to make it 
unnecessary for all developers to switch which software they're using at 
the same time. With that particular project, it really went from having a 
CVS repository and a git gateway to having a git repository and a CVS 
gateway without users seeing a difference (except that the CVS access was 
suddenly faster).

Then, of course, the git users were able to start making use of the more 
flexible representation of history, since the official repository then 
could represent it.

	-Daniel
*This .sig left intentionally blank*
