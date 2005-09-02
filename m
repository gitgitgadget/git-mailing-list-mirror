From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Fri, 02 Sep 2005 11:33:20 -0700
Message-ID: <7voe7bfhfz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0508171341380.23242@iabervon.org>
	<Pine.LNX.4.63.0508172156090.17234@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0508171630140.23242@iabervon.org>
	<Pine.LNX.4.63.0508180009180.18104@wgmdd8.biozentrum.uni-wuerzburg.de>
	<430C8C31.1070902@progeny.com>
	<7v4q9eak9k.fsf@assigned-by-dhcp.cox.net>
	<43174090.5070503@progeny.com>
	<7vek88tib4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509021358000.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 20:34:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBGM9-0003V5-GW
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 20:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVIBSdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 14:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVIBSdY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 14:33:24 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39368 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbVIBSdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 14:33:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050902183322.YEOX6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Sep 2005 14:33:22 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <Pine.LNX.4.63.0509021358000.23242@iabervon.org> (Daniel
	Barkalow's message of "Fri, 2 Sep 2005 14:09:13 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8027>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 1 Sep 2005, Junio C Hamano wrote:
>
>> Tim Ottinger <tottinge@progeny.com> writes:
>> 
>> > git-update-cache for instance?
>> 
>> Logically you are right, but I suspect that may not fly well in
>> practice.  Too many of us have already got our fingers wired to
>> type cache, and the glossary is there to describe both cache and
>> index.
>
> My vote's for changing the official names, but keeping symlinks for the 
> old names. As far as I know, there aren't any actual conflicts, and we 
> might as well have new users pick up the logical names. I particularly 
> think "git merge" would be really good to have.

OK.  As Horst also says, we should do this before 1.0.

0.99.6::
	This hopefully will be done on Sep 7th.  Tool renames
	will not happen in this release, but the set of cleaned
	up names will be discussed on the list during this
	timeperiod.  I'll draw up a strawman tonight unless
	somebody else does it first.

0.99.7::
	We install symbolic links for the old names.  For the
	documentation, we do not bother --- just install under
	new names.  Also remove support for ancient environment
	variable names from gitenv().  Aim for Sep 17th.

0.99.8::
	Aim for Oct 1st; we do not install symbolic links
	anymore and supply "clean-old-install" target in the
	Makefile that removes symlinks installed by 0.99.7 from
	DESTDIR.  This target is not run automatically from other
	usual make targets; it is just there for your
	convenience.
