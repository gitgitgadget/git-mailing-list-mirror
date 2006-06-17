From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] cvsimport: ignore CVSPS_NO_BRANCH and impossible branches
Date: Sat, 17 Jun 2006 23:27:41 +0200
Message-ID: <20060617212741.GT7766@nowhere.earth>
References: <11500135293734-git-send-email-martin@catalyst.net.nz> <7vzmgb8plx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 23:27:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FriK4-00087H-5c
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 23:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWFQV1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWFQV1N
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 17:27:13 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:25495 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750937AbWFQV1N (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 17:27:13 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id C37C726563;
	Sat, 17 Jun 2006 23:27:11 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FriKU-0002kM-0r; Sat, 17 Jun 2006 23:27:42 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmgb8plx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22031>

On Sat, Jun 17, 2006 at 02:00:10PM -0700, Junio C Hamano wrote:
> Martin Langhoff <martin@catalyst.net.nz> writes:
> 
> > cvsps output often contains references to CVSPS_NO_BRANCH, commits that it
> > could not trace to a branch. Ignore that branch.
> >
> > Additionally, cvsps will sometimes draw circular relationships between
> > branches -- where two branches are recorded as opening from the other.
> > In those cases, and where the ancestor branch hasn't been seen, ignore
> > it.
> 
> This sounds more like an workaround than a real fix to me,
> although I'd apply it for now.  I see Yann is collecting cvsps
> patches but maybe there will be a real fix soonish?

I have not dig yet into the cases that trigger CVSPS_NO_BRANCH so
can't make any promise, unless someone comes in with a patch already
written :)

Since the patch seems to ensure the user gets warned when a branch
gets ignored this way, allowing it in could probably allow at least
some people to have cvsimport does a partial job, rather than failing
midway.  Maybe a final warning when all patchsets could not be
imported could be issued, so the existing ones do not get simply lost
in the verbose output.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
