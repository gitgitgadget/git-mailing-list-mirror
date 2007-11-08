From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git push mirror mode
Date: Thu, 8 Nov 2007 13:44:32 +0000
Message-ID: <20071108134432.GK9736@shadowen.org>
References: <20071108121136.GG9736@shadowen.org> <Pine.LNX.4.64.0711081218090.4362@racer.site> <20071108124435.GH9736@shadowen.org> <47330BA4.6030101@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7gf-0000PX-6e
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbXKHNoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756693AbXKHNo3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:44:29 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2962 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbXKHNo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:44:29 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1Iq7gG-0003CC-PH; Thu, 08 Nov 2007 13:44:25 +0000
Content-Disposition: inline
In-Reply-To: <47330BA4.6030101@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64021>

On Thu, Nov 08, 2007 at 02:14:12PM +0100, Andreas Ericsson wrote:

> Barring any errors in my understanding of the matter, here's how it
> works for git.
> 
> git separates author from committer, so code attribution is done with
> author, and "I verified this is sane" is done by committer. Those two
> usually only ever differ when the user tells git commit that the author
> was someone else than him/her self, or when rewriting history with git
> rebase or similar. git am also maintains authorship (using the From:
> line in emails), but sets $committer to the person running it, so when
> you apply patches sent by email from someone else you get the code
> attribution right by default.
> 
> The Signed-off-by line is, in git, used as "I touched the code here and
> agree that it may be included in the mothership repo and all future
> releases" (the spirit of that sentence is also in
> Documentation/SubmittingPatches).
> 
> We also have Acked-by (as does the kernel, no? I think we inherited it
> from there) to mean something along the lines of "I vote we include this",
> but not always based on technical merit (ie, patches can have many acks
> without having ever been tested).
> 
> Suggested-by, Tested-by and Reported-by are used less often, not always
> written in dash-form, but hopefully always self-explanatory ;-)

What that doesn't tell me is how when sending an email carrying a patch
one ensures the attribution is correct when loaded into git.

Having messed about with it a bit it does seem that if one wants git to
attribute the patch to junio I have to add a From: line to the top of
the email payload.

I'll resend so attributed.

-apw
