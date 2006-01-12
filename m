From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: merging initial part of a branch?
Date: Wed, 11 Jan 2006 20:13:11 -0500
Message-ID: <20060112011311.GC14599@fieldses.org>
References: <20060111230451.GH8618@fieldses.org> <7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <43C59FB6.20803@op5.se> <7vu0cai98f.fsf@assigned-by-dhcp.cox.net> <43C5A9F4.1040604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 02:13:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewr1h-0004LX-JR
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 02:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWALBNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 20:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWALBNP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 20:13:15 -0500
Received: from mail.fieldses.org ([66.93.2.214]:50361 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964933AbWALBNO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 20:13:14 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1Ewr1b-0004J8-SH; Wed, 11 Jan 2006 20:13:11 -0500
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43C5A9F4.1040604@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14541>

On Thu, Jan 12, 2006 at 01:59:32AM +0100, Andreas Ericsson wrote:
> Junio C Hamano wrote:
> >Andreas Ericsson <ae@op5.se> writes:
> >>$ git format-patch -m -k v2.6.14..v2.6.15 --stdout > mega-mbox-patch
> >>$ git checkout our-own-branch
> >>$ git am -3 -k mega-mbox-patch
> >>
> >>That'll take some time though, so be sure to have a six-pack or two handy.
> >
> >
> >I do not think that should be done.  You will create an
> >alternate history that way, not the true v2.6.15 history.
> >
> 
> I took their request to mean that they already have patches of their own 
> in that, so they'll never have v2.6.15 vanilla history anyway.

If I have some local changes, and do a git pull linus tag v2.6.15, I
find that the final commit in the result is a merge commit whose first
parent refers to my last commit, and whose second commit points to
Linus's v2.6.15 commit from the "vanilla history".  Which is what I
think you really need for a history that makes sense and that can be
used by future merges.

--b.
