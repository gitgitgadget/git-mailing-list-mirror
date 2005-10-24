From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Mon, 24 Oct 2005 10:32:16 +0200
Message-ID: <20051024083216.GA4397@c165.ib.student.liu.se>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz> <200510202137.22311.dtor_core@ameritech.net> <4358597A.6000306@catalyst.net.nz> <20051021091551.GE30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 10:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETxl7-0007s8-1Z
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 10:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVJXIcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 04:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVJXIcZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 04:32:25 -0400
Received: from [85.8.31.11] ([85.8.31.11]:13278 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750759AbVJXIcY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 04:32:24 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A7B724114; Mon, 24 Oct 2005 10:39:45 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ETxke-00019A-00; Mon, 24 Oct 2005 10:32:16 +0200
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051021091551.GE30889@pasky.or.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10535>

On Fri, Oct 21, 2005 at 11:15:51AM +0200, Petr Baudis wrote:
> Dear diary, on Fri, Oct 21, 2005 at 04:59:06AM CEST, I got a letter
> where "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> told me that...
> > Almost. No, truly, I'm very impressed with git-merge.sh, which first 
> > does the simple git-read-tree -m, and it can then try several merger 
> > scripts to resolve the index. The "smartest" merge resolver we have 
> > follows renames, but we could have language-specific and 
> > project-specific resolvers, for instance.
> 
> Yes, following renames is nice. But as long as it is three-way, it
> suffers of inherent and rather nasty problems. Well, I'm watching the
> weave merge effort and plan to give it a try to port it to GIT when I
> have some time.
> 

Which "inherent and rather nasty problems" are you referring to?

I do not know of any merge case which is either cleanly merged to the
wrong result by git-merge -s recursive, or cleanly merged when it
should be a conflict. (At least not if there aren't any directory
renames going on) If you know about such an example I would be very
interested in taking a look at it.

- Fredrik
