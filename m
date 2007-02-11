From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 17:49:42 -0500
Message-ID: <20070211224942.GB31488@spearce.org>
References: <20070211084030.GE2082@spearce.org> <45CF2EBC.8070107@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNWC-00058A-3A
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbXBKWtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbXBKWtu
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:49:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51679 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932712AbXBKWtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:49:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGNVm-0002so-Rs; Sun, 11 Feb 2007 17:49:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AC7A120FBAE; Sun, 11 Feb 2007 17:49:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45CF2EBC.8070107@verizon.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39319>

Mark Levedahl <mdl123@verizon.net> wrote:
> I have recently moved a project involving multiple companies developing 
> on Windows and Linux from cvs(nt) over to git. The availability of 
> git-gui at the time was an important point: many folks working this 
> project simply will not work at the command line. We are still spinning 
> up on git, but several of the developers are relying upon git-gui now 
> and I expect that most will use it. So, I am definitely for moving 
> git-gui into git. It definitely fits well with the 1.5 usability theme.

I'm glad git-gui has helped you migrate a team away from CVS.
The case you are describing is definately one of the reasons for
creating git-gui.

> Side note: with my gitk fix for Cygwin now in master, git-gui should not 
> be deleting ~/.gitk on Cygwin anymore.

Gah. I forgot about that feature of git-gui.  It is now removed,
and a new version has been pushed out.  Thank you for the reminder!
 
> Whatever the decision: Shawn - thank you for developing this.

You are most welecome.  :)

Paul Mackerras deserves some credit too, as his prototype gitool
was the original insipiration behind git-gui.  And his icons are
still in use within git-gui.

-- 
Shawn.
