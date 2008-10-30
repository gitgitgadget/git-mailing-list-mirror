From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 07:52:53 -0700
Message-ID: <20081030145253.GK14786@spearce.org>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:54:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYuY-0005GX-Jc
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbYJ3Owy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbYJ3Owy
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:52:54 -0400
Received: from george.spearce.org ([209.20.77.23]:56633 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbYJ3Owy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:52:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 47EA43835F; Thu, 30 Oct 2008 14:52:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99476>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 29 Oct 2008, Sam Vilain wrote:
> > From: Sam Vilain <samv@vilain.net>
> > 
> > For cross-command CLI changes to be effective, they need to be
> > cohesively planned.  Add a planning document for this next set of
> > changes.
> > 
> > Signed-off-by: Sam Vilain <sam@vilain.net>
> [...]
> 
> > +  * 'git checkout branch' would, if there is a remote branch called
> > +    'branch' on exactly one remote, do what
> > +    'git checkout -b branch thatremote/branch' does now.  If it is
> > +    ambiguous, it would be an error, forcing the explicit notation.
> 
> I can't do otherwise but disagree with this.  Currently, when a remote 
> branch is checked out, the commit corresponding to that remote branch is 
> put on a detached head which is IMHO completely sane and coherent. It 
> even tells you how to create a local branch from there if that's what 
> you wanted to do.  So if it is still too confusing at that point then 
> more explanations are needed and not the removal of a perfectly fine 
> feature. Please don't change that behavior.

+1 to Nico's NAK.

Although I was at the GitTogether I don't remember this change to
checkout being discussed.  I must have been asleep reading email
or something.  I am _NOT_ in favor of this change; I think the
current behavior of "git checkout origin/master" is correct and as
sane as we can make it.

-- 
Shawn.
