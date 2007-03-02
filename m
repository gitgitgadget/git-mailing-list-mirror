From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: defaults for where to merge from
Date: Fri, 2 Mar 2007 10:53:48 -0500
Message-ID: <20070302155348.GB24547@fieldses.org>
References: <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk> <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com> <45E5DE8A.2080101@lu.unisi.ch> <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com> <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com> <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com> <7vejo9xtot.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, bonzini@gnu.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 16:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNA4c-0005c2-Fb
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992536AbXCBPxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992537AbXCBPxb
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:53:31 -0500
Received: from mail.fieldses.org ([66.93.2.214]:54578 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992536AbXCBPxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:53:31 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HNA4q-000096-Q9; Fri, 02 Mar 2007 10:53:48 -0500
Content-Disposition: inline
In-Reply-To: <7vejo9xtot.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41222>

On Thu, Mar 01, 2007 at 12:18:58AM -0800, Junio C Hamano wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> >> If everyone hated the old behavior, old users should already be careful
> >> about not git-pull'ing (without options) from any branch but master.  So
> >> they won't see any difference.
> >
> > except for .git/config growing uncontrollably
> 
> I think this should be a new option, not the _modified default_.
> Otherwise it would be harder to sell to olde timers.
> 
> 	$ git checkout -B <newbranch> remotes/<blah>
>         $ git branch --track <newbranch> remotes/<blah>
> 
> might be a good compromise.

Personally I usually use <blah> as <newbranch>.  I might have gone for
something like

	git remote checkout [remote] blah [-b newbranch]

with defaulted to newbranch = blah.

--b.
