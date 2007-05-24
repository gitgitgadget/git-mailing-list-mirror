From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 24 May 2007 02:15:21 -0400
Message-ID: <20070524061521.GK28023@spearce.org>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net> <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 08:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr6bk-0008TQ-ED
	for gcvg-git@gmane.org; Thu, 24 May 2007 08:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbXEXGPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758270AbXEXGPa
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 02:15:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56895 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228AbXEXGP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 02:15:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr6ba-0001UU-Hb; Thu, 24 May 2007 02:15:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 32D4020FBAE; Thu, 24 May 2007 02:15:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48224>

Junio C Hamano <junkio@cox.net> wrote:
> * db/remote (Tue May 15 22:50:19 2007 -0400) 4 commits
>  + Update local tracking refs when pushing
>  + Add handlers for fetch-side configuration of remotes.
>  + Move refspec parser from connect.c and cache.h to remote.{c,h}
>  + Move remote parsing into a library file out of builtin-push.
> 
> Will need to look at this once more; I do not expect too much
> problems with it.

I spent all day today working with this series.  Lots of pushing new
branches, deleting existing branches, updating existing branches
across many repositories.  Its an *awesome* change.  I'm really
happy with it.

-- 
Shawn.
