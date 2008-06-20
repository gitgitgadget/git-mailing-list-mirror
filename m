From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: git svn --use-log-author misbehavior?
Date: Fri, 20 Jun 2008 12:57:29 +0200
Message-ID: <20080620105729.GB27940@frsk.net>
References: <485AF10B.7060202@mircea.bardac.net> <20080620085618.GA27940@frsk.net> <485B82BD.2000404@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mircea Bardac <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 12:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9eK4-0006TZ-59
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 12:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbYFTK5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 06:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYFTK5c
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 06:57:32 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:49871 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbYFTK5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 06:57:32 -0400
Received: from asterix.samfundet.no ([2001:700:300:1800::f] ident=postfix)
	by cassarossa.samfundet.no with esmtp (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1K9eJ7-0004FP-FL; Fri, 20 Jun 2008 12:57:29 +0200
Received: by asterix.samfundet.no (Postfix, from userid 1000)
	id 63F5AA6039D; Fri, 20 Jun 2008 12:57:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <485B82BD.2000404@mircea.bardac.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85619>

On Fri, Jun 20, 2008 at 11:13:17AM +0100, Mircea Bardac wrote:

> I haven't tested this yet but I have a feeling this is not my case, or I 
> might not be fully understanding the implications of "--add-author-from" 
> on the functionality of "--use-log-author". Technically, they should be 
> independent and the options should not depend on each other:
> * --use-log-author only applies to getting info from the commits
> * --add-author-from only applies to putting info in the commits
> 
> From the documentation, these 2 options can only be used with git svn 
> init/clone so they should somehow be saved for future use. Maybe this 
> doesn't happen.
> 
> My Git commits (not dcommits) already have "Signed-off-by:" at the end, 
> added with "git commit -s". When I do a "git svn dcommit" they get 
> pushed to SVN and the entire commit is rewritten. I have 
> --add-author-from added on git clone, but nothing else is being added to 
> the commit except the git-svn-id - from my point of view, according to 
> the documentation, this is the correct behavior (since there already is 
> a Signed-off-by line)
 
Did you mean "git svn clone" here, not "git clone"? And if --use-log-author
is to be used to get retrieve info from the commits, it should be used
instead of --add-author-from when doing a clone. (Which as far as I can see
behaves correctly.)

However, looks like I might have misunderstood your problem, and possibly
found a bug in the process. I'll look closer into it. :-)

-- 
Regards,
Fredrik Skolmli
