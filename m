From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Lump commit HOWTO?
Date: Fri, 13 Jul 2007 06:54:47 +0200
Message-ID: <20070713045447.GA2430@steel.home>
References: <625fc13d0707121821l70e2d6aaw555c79b5d700585f@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 06:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9DBI-0001a4-Nr
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 06:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXGMEyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 00:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbXGMEyu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 00:54:50 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:36805 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbXGMEyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 00:54:50 -0400
Received: from tigra.home (Fc891.f.strato-dslnet.de [195.4.200.145])
	by post.webmailer.de (klopstock mo26) (RZmta 8.3)
	with ESMTP id t01b99j6CNqN7c ; Fri, 13 Jul 2007 06:54:48 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 32ACD277BD;
	Fri, 13 Jul 2007 06:54:48 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0A57BC164; Fri, 13 Jul 2007 06:54:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <625fc13d0707121821l70e2d6aaw555c79b5d700585f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+bxu8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52359>

Josh Boyer, Fri, Jul 13, 2007 03:21:17 +0200:
> Hi All,
> 
> I have a specific workflow in mind that I'm not entirely sure how to
> accomplish with git.  What I'd like to do is track a project in a
> local branch, and do commits of my own there as well.  Then when I'm
> ready to submit the work, I want to take all the incremental commits
> and lump them into a single new commit and push that out as a patch or
> into a branch for people to pull from.

See git merge --squash. It is exactly that.
Also git-rebase --interactive and git cherry-pick -n can help you to
get the same.
