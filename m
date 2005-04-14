From: bert hubert <ahu@ds9a.nl>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 21:11:58 +0200
Message-ID: <20050414191157.GA27696@outpost.ds9a.nl>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org> <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org> <425EA152.4090506@zytor.com> <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 21:12:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9kL-0005i7-OQ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVDNTOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDNTOs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:14:48 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:9604 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261589AbVDNTOf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 15:14:35 -0400
Received: by outpost.ds9a.nl (Postfix, from userid 1000)
	id 445D83FD6; Thu, 14 Apr 2005 21:11:58 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2005 at 10:42:56AM -0700, Linus Torvalds wrote:
> > Eh?!  n_link limits the number of *subdirectories* a directory can 
> > contain, not the number of *entries*.
> 
> Duh. I'm a git.

That may be true :-), but from the "front lines" I can report that
directories with > 32000 or > 65000 entries is *asking* for trouble. There
is a whole chain of systems that need to get things right for huge
directories to work well, and it often is not that way.

Even though it should be.

So the question is, should git be the harbringer of improvements in this
area, or should it go with the flow.

Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
