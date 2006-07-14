From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 14:21:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607141402520.9789@iabervon.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org> 
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
  <1152840456.31372.75.camel@shinybook.infradead.org> 
 <Pine.LNX.4.64.0607132157370.5623@g5.osdl.org>  <1152872626.3191.56.camel@pmac.infradead.org>
  <Pine.LNX.4.64.0607140843570.5623@g5.osdl.org>  <Pine.LNX.4.64.0607141256170.9789@iabervon.org>
 <1152899889.3191.71.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 20:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1SHq-0005Ct-2Q
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 20:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWGNSVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWGNSVK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 14:21:10 -0400
Received: from iabervon.org ([66.92.72.58]:14853 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1422690AbWGNSVJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 14:21:09 -0400
Received: (qmail 14075 invoked by uid 1000); 14 Jul 2006 14:21:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Jul 2006 14:21:51 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152899889.3191.71.camel@pmac.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23906>

On Fri, 14 Jul 2006, David Woodhouse wrote:

> And no, I don't do any further simplification of the graph of commits
> other than what 'git-rev-list' does for me. I need to fully go over
> Linus' last mail and understand it, but I think the conclusion is that
> the above scripts are fine, and I can happily drop --topo-order from
> them.

I think the mechanism you're using is fine, but it's also generally 
useful, and it would be nice to have the generic part split out from the 
particular application. Also, those scripts really are as evil as 
advertized, and using more of the git programs would make that a lot 
saner.

	-Daniel
*This .sig left intentionally blank*
