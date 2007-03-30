From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem with gitk on cygwin
Date: Fri, 30 Mar 2007 01:25:33 -0400
Message-ID: <20070330052533.GQ13247@spearce.org>
References: <000001c771ec$12729c30$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'git' <git@vger.kernel.org>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 07:25:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX9cM-000534-Re
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 07:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbXC3FZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 01:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbXC3FZj
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 01:25:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57363 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964974AbXC3FZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 01:25:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HX9cF-0004jT-KL; Fri, 30 Mar 2007 01:25:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE8FB20FBAE; Fri, 30 Mar 2007 01:25:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <000001c771ec$12729c30$0b0aa8c0@abf.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43495>

Raimund Bauer <ray007@gmx.net> wrote:
> When trying to use gitk from current cygwin-install, I get an error-dialog
> and no gitk-window.
> 
> Error title: "Error in startup script"
> Error message:
> --------------------------------
> .git
>     8 [main] git 1620 tty_list::allocate: No tty allocated while executing
> "exec git rev-parse --git-dir"
>   (procedure "gitdir" line 6)
>   invoked from within
> "gitdir"
>   invoked from within
> "set gitdir [gitdir]"
>   (file  "/usr/bin/gitk" line 6270)
> --------------------------------

I have seen this failure before, and its usually a result of having
your CYGWIN environment variable including 'notty':

  http://www.cygwin.com/cygwin-ug-net/using-cygwinenv.html

Or maybe its the opposite.  I don't have access to my Cygwin system
right now, so I cannot check if I have notty, tty, or just ommitted
it entirely from my CYGWIN environment varible.  But I think that's
the issue.

-- 
Shawn.
