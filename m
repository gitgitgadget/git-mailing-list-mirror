From: Petr Baudis <pasky@suse.cz>
Subject: Re: Calling ssh from git-gui
Date: Wed, 3 Sep 2008 19:33:10 +0200
Message-ID: <20080903173310.GY10360@machine.or.cz>
References: <20080903165455.GU10544@machine.or.cz> <20080903171543.GC28315@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawFN-0003ng-7Q
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbYICRdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbYICRdR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:33:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56594 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395AbYICRdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:33:15 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 73CD43939B4B; Wed,  3 Sep 2008 19:33:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080903171543.GC28315@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94822>

On Wed, Sep 03, 2008 at 10:15:43AM -0700, Shawn O. Pearce wrote:
> And that is why it doesn't handle (ii) or (iii) at the present time,
> and unless I am given a nice patch series for any git-gui related
> parts of this, why it will continue to remain that way for quite
> some time.

My writeup was not actually intended as 'how we might do it' but 'how
should *I* implement this'. ;-) I _do_ plan for a nice patch series.
For now I'm defaulting on the SSH_ASKPASS approach.

> Damn annoying for git-gui to be invoking a new terminal window, but
> maybe that's what we have to do.  Be nice though if the window only
> was opened because we couldn't do "git ls-remote url" but its hard
> to tell "hanging because SSH needs the user" and "hanging because
> the network is a 2400 baud modem".

Oh, indeed - that is something what I had in mind when starting to write
this mail about a week ago, but forgot to mention now. It's the
possibility of having console spawn a real tty (or do some more stuff to
*emulate* a tty, but again, this might get hairy in TCL). However, this
feels very... "untidy" compared to SSH_ASKPASS.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
