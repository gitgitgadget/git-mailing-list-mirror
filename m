From: Jeff King <peff@peff.net>
Subject: Re: git-diff on touched files: bug or feature?
Date: Fri, 3 Aug 2007 03:04:07 -0400
Message-ID: <20070803070407.GA17287@coredump.intra.peff.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net> <7v1wemxnkk.fsf@assigned-by-dhcp.cox.net> <vpqzm1a2l72.fsf@bauges.imag.fr> <7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGrCz-0008Jt-3S
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbXHCHEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757516AbXHCHEK
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:04:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1377 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757506AbXHCHEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:04:09 -0400
Received: (qmail 12134 invoked from network); 3 Aug 2007 07:04:11 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Aug 2007 07:04:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2007 03:04:07 -0400
Content-Disposition: inline
In-Reply-To: <7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54679>

On Thu, Aug 02, 2007 at 12:56:19PM -0700, Junio C Hamano wrote:

> Personally, I almost never run "git status".  The command is
> there primarily because other systems had a command called
> "status", and migrant wondered why we didn't.  We do not need
> it, and we do not have to use it.

So what is the recommended command to summarize which files have been
modified, which files have been marked for commit, and which remain
untracked?

I find "git-diff --stat" totally insufficient for seeing the progress of
my work. How will it remind me that I have also previously git-added
some changes? They won't be mentioned at all, unless you are really
advocating "git-diff --stat HEAD". How will I be reminded that some
files from my work need to be git-added? git-diff won't mention
untracked files at all.

> You do not have to say, to the above paragraph, that it is
> different from your workflow.  I am showing what the opmimum
> workflow would be, and it is up to you not to listen to me.

You are throwing the word "optimum" out here, but I have no idea what
you mean in this context. Optimum with respect to what criteria?

I know you are just trying to show your workflow, and that you
understand that others might have a different workflow. But you seem to
be implying that workflows using "git-status" are lesser for some
reason, and I really think it is a matter of taste.

-Peff
