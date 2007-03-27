From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 11:19:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271115580.6730@woody.linux-foundation.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org>
 <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703271338210.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWGGe-0006By-OA
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 20:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934149AbXC0STd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 14:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934150AbXC0STd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 14:19:33 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36718 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934146AbXC0STc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 14:19:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RIJ2U2008849
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 11:19:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RIJ1Ks024271;
	Tue, 27 Mar 2007 11:19:02 -0700
In-Reply-To: <Pine.LNX.4.64.0703271338210.6485@iabervon.org>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43293>



On Tue, 27 Mar 2007, Daniel Barkalow wrote:
> 
> Is it fair to say that subproject support means that there's a use case 
> where everybody will need shallow clones? And that it points out natural 
> triggers for shallowness?

No.

I personally don't believe in shallow clones. And I *certainly* don't 
believe that it has anything to do with subprojects. So people may want 
shallow clones, but it's at least independent of the issue of submodules.

With subprojects, it's not that you don't want the history. It's just that 
you don't want the history for *all* projects. Most people care about a 
very small subset.

(The exception, of course, is when the superproject simply isn't that big, 
and only has a couple of subprojects. In git, for example, the xdiff stuff 
could be a subproject if you wanted to do it that way. But then, the 
subproject isn't a size issue, it's purely an organizational thing, and 
there is no argument for/against shallowness there either).

			Linus
