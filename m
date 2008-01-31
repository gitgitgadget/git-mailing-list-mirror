From: "Ed S. Peschko" <esp5@pge.com>
Subject: Re: simple cvs-like git wrapper
Date: Wed, 30 Jan 2008 21:41:24 -0800
Message-ID: <20080131054124.GG9612@venus>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus> <20080130040002.GM24004@spearce.org> <20080130225254.GC9612@venus> <20080131040839.GW24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 06:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKSBw-0004G5-9q
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 06:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbYAaFln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 00:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYAaFln
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 00:41:43 -0500
Received: from mta01.pge.com ([131.89.129.71]:56212 "EHLO mta01.pge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbYAaFlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 00:41:42 -0500
Received: from mta16.comp.pge.com (mta16.comp.pge.com [10.244.4.51])
	by mta01.pge.com (Switch-3.3.1/Switch-3.3.0) with ESMTP id m0V5fQKD024578;
	Wed, 30 Jan 2008 21:41:26 -0800 (PST)
Received: from mdssdr01.utility.pge.com (mdssdr01.utility.pge.com [10.244.52.48])
	by mta16.comp.pge.com (Switch-3.3.1/Switch-3.3.0) with ESMTP id m0V5fPG4024535;
	Wed, 30 Jan 2008 21:41:25 -0800 (PST)
Received: (from esp5@localhost)
	by mdssdr01.utility.pge.com (8.11.7p3+Sun/8.11.7) id m0V5fOC12127;
	Wed, 30 Jan 2008 21:41:24 -0800 (PST)
X-Authentication-Warning: mdssdr01.utility.pge.com: esp5 set sender to esp5@pge.com using -f
Content-Disposition: inline
In-Reply-To: <20080131040839.GW24004@spearce.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72101>

> Merging all branches on the remote named "origin" is simply not an
> intelligent thing to do.  Nobody blindly merges everything available
> from a remote, and nobody has ever asked for such a function before
> in Git.  I still think its nuts, but I don't know all details of
> your situation so I'll just shut up now and hope you know what you
> are really asking for.

Ok, I'm not going to belabor the point, but for the most part, the
requests in our particular domain are separate. A developer for the
most part works only on files that other developers are not working on.

There are exceptions to this, but for the most part this is true..
Hence, most of the time there will be no conflicts.

Anyways, I'll try to improve on your script, but it looks like what I
want to do.

> This is going to be slow as you are running git-merge for each
> and every branch available to you.  You can do a lot better by
> loading the branch DAG into memory in Perl/C/Python and doing a
> graph coloring algorithm to see if a merge is necessary or not,
> as if you are merging everything all of the time almost everything
> is going to be always merged to everything else.  Which as I said
> earlier is nuts.

hmm. Is there a simple method to get this graph? I'm assuming that you
would have to get all the local commits and compare them to the remote
commits, and only merge the branches that have commits not yet 
merged..

Ed

> -- 
> Shawn.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
