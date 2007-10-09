From: Jonathan del Strother <maillist@steelskies.com>
Subject: Adding color to git-add--interactive
Date: Tue, 9 Oct 2007 14:06:31 +0100
Message-ID: <91EBB71E-BB4E-4089-8C33-6B0C4A61223A@steelskies.com>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEnX-0006lq-KZ
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbXJINGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbXJINGq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:06:46 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:49883 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbXJINGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:06:45 -0400
Received: from host217-35-101-26.in-addr.btopenworld.com ([217.35.101.26]:50997 helo=[192.168.1.59])
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IfEnN-0007t9-5A
	for git@vger.kernel.org; Tue, 09 Oct 2007 09:06:45 -0400
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60405>

I find git-add--interactive incredibly awkward to use, mostly due to  
the lack of visual differentiation as you type in a sequence of  
commands.  For example, when stepping through hunks to patch, every  
time it shows a new hunk I have to carefully scan up the screen to  
find where the hunk starts, before I can actually start reading what's  
contained in that hunk.

For me at least, adding color would make the interactive mode far more  
readable.   I hacked in basic color support (just coloring PROMPT &  
HEADER in list_and_choose, and the "Stage this hunk?" prompt) - which  
helped a lot - but then reached the limits of my perl knowledge.  For  
instance, I can't see a sensible way of reusing git-svn's  
log_use_color function without importing the entire file, and I can't  
figure out how you'd go about diff-coloring the hunks.  Is anyone with  
more perl knowledge than me interested in taking this on?

Or am I alone in finding interactive mode basically unreadable?
Jon
