From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 04:30:39 -0500
Organization: Exigence
Message-ID: <20080923043039.bf380694.stephen@exigencecorp.com>
References: <20080922155749.c8070681.stephen@exigencecorp.com>
	<20080922231927.ef18f420.stephen@exigencecorp.com>
	<48D88813.9060400@viscovery.net>
	<20080923024653.a3bb8666.stephen@exigencecorp.com>
	<48D8A6EA.4020805@op5.se>
	<20080923040302.c4d0d33b.stephen@exigencecorp.com>
	<48D8B2C1.5070800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 23 11:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki4FP-00080p-Rf
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 11:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYIWJaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 05:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYIWJaq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 05:30:46 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:52217 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbYIWJap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 05:30:45 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 20D64E0650;
	Tue, 23 Sep 2008 05:30:44 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id C8065E01B4;
	Tue, 23 Sep 2008 05:30:43 -0400 (EDT)
In-Reply-To: <48D8B2C1.5070800@op5.se>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96542>


> > Does this sound reasonable?
> 
> It sounds very reasonable indeed

Ah, cool, thanks for validating our approach. We have so far been
slowly figuring it out and it has been nice.

> but then I don't understand why you held off pushing the merge.

Ah, yes, that is the trick, to get it out quickly. Usually it is not a
problem, but in ~2-3 months of using git, it's happened on high-churn
branches about 4-5 times (usually it is the next release candidate
branch where people are actively making small bug fixes and one guy
gets caught with a non-trivial merge in from stable).

Not all that bad, really, other than it caused a few "wtf git"
comments. Which is unfortunate as, while I enjoy git, the team as a
whole is still learning. Seeing the DAGs, and understanding the
patch/apply approach of the non-interactive rebase, it makes sense to
me what git is doing. And so while I know to watch for it, I'm trying to
find a more bullet proof approach.

> That's beside the point though, as I firmly believe git should be more
> helpful in this situation. If "git rebase -i -p" doesn't help you fix
> the problems, I'll see what I can do to help.

That's very cool, thanks. I'll start writing a test now.

- Stephen
