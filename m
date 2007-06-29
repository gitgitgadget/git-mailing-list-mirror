From: walt <wa1ter@myrealbox.com>
Subject: Re: Problem with Linus's git repository?
Date: Fri, 29 Jun 2007 05:47:28 -0700 (PDT)
Organization: none
Message-ID: <Pine.LNX.4.64.0706290537130.7055@x2.ybpnyarg>
References: <f5r8q5$pbr$1@sea.gmane.org> <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
     <Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>  
 <alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>  
 <Pine.LNX.4.64.0706280632540.5321@x2.ybpnyarg>
 <alpine.LFD.0.98.0706280840570.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 14:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Fwm-0000lV-VQ
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 14:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933290AbXF2Mvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 08:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764631AbXF2Mvb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 08:51:31 -0400
Received: from psmtp-in.myrealbox.com ([72.8.126.107]:7687 "EHLO myrealbox.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755471AbXF2Mva (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 08:51:30 -0400
Received: from k2 wa1ter@myrealbox.com [69.234.198.180]
	by myrealbox.com with M+ Extreme Email Engine 5.0.0
	via secured & encrypted transport (TLS);
	Fri, 29 Jun 2007 06:48:50 -0600
X-MailFrom: wa1ter@myrealbox.com
In-Reply-To: <alpine.LFD.0.98.0706280840570.8675@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51174>



On Thu, 28 Jun 2007, Linus Torvalds wrote:


> On Thu, 28 Jun 2007, walt wrote:
> >
> > No, every morning I pull from you and Junio and Petr Baudis using cg-update,


> Oh, don't use "cg-update", or just fix it to do "git pull".

I'm happy to stick with using git.  From reading the latest Docs, it seems
that git-pull -v will do what I need (I think).

That's what I did just now to update from you and Junio, and the output
seemed exactly appropriate -- ended with a fast-forward and no errors
for either one.

However, a git-fsck turned up four dangling commits for Junio, and 42
danglers for you, including a mix of blobs, trees, and commits.

Will a simple git-prune bring me correctly up to date, or am I missing
some steps?

Thanks!


--- Scanned by M+ Guardian Messaging Firewall ---
