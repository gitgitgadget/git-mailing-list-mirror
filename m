From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict resolution
Date: Thu, 3 Aug 2006 23:31:44 -0400
Message-ID: <20060804033144.GB24818@coredump.intra.peff.net>
References: <11546492331601-git-send-email-martin@catalyst.net.nz> <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net> <44D296D8.4030200@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 05:31:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8qPf-00041Y-En
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 05:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWHDDbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 23:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWHDDbr
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 23:31:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:30649 "HELO
	peff.net") by vger.kernel.org with SMTP id S1030196AbWHDDbq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 23:31:46 -0400
Received: (qmail 28725 invoked from network); 3 Aug 2006 23:31:10 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Aug 2006 23:31:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  3 Aug 2006 23:31:44 -0400
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <44D296D8.4030200@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24765>

On Fri, Aug 04, 2006 at 12:37:44PM +1200, Martin Langhoff (CatalystIT) wrote:

> >instead check for stage 2 ("ours") for the path.
> Reading Documentation/git-read-tree.txt it seems to mean that stage 1 is 
> merge base, 1 is ours and 2 is the branch being merged in.
> 
> I am confused...
> 
> Quote:
> >When performing a merge of another
> >branch into the current branch, we use the common ancestor tree
> >as <tree1>, the current branch head as <tree2>, and the other
> >branch head as <tree3>.

Look further down:
   OK, this all sounds like a collection of totally nonsensical rules,
   but it's actually exactly what you want in order to do a  fast
   merge.  The different stages  represent the "result tree" (stage 0,
   aka "merged"), the original tree (stage 1, aka "orig"), and the two
   trees you are trying to merge (stage 2 and 3 respectively).

HTH,
-Peff
