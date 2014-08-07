From: Tony Finch <dot@dotat.at>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 18:47:04 +0100
Message-ID: <alpine.LSU.2.00.1408071829470.13901@hermes-1.csi.cam.ac.uk>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com> <20140806200726.GE23449@localhost> <alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk> <20140807155828.GM23449@localhost> <alpine.LSU.2.00.1408071735410.23775@hermes-1.csi.cam.ac.uk>
 <20140807172207.GP23449@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 19:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFRmV-0007KY-J4
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 19:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaHGRrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 13:47:10 -0400
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49884 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaHGRrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 13:47:09 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:35068)
	by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XFRmL-0003sS-Px (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 07 Aug 2014 18:47:05 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XFRmK-00041T-W9 (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 07 Aug 2014 18:47:05 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <20140807172207.GP23449@localhost>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254982>

Nico Williams <nico@cryptonector.com> wrote:
> On Thu, Aug 07, 2014 at 05:42:34PM +0100, Tony Finch wrote:
> >
> > The problem is that the production branch gets copied around: pushed to
> > the repo server, pulled by other team members, etc. Forced pushes
> > are accident-prone, as is resetting a rebased branch after a pull.
>
> When I rebase and I need the old HEAD around I do something like this:
> [...]
> Either way I retain the old HEAD with some name.

Hmm, yes, I can see that would work. However my previous workflow was
rather branch-heavy and I found the accumulation of names annoying. I have
not yet had enough usage out of git-repub to see if it goes too far in the
direction of lack-of-names. A big omission is no opportunity to edit its
commit messages.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Rockall: Southwesterly becoming cyclonic in north, 5 to 7. Moderate or rough.
Rain or showers. Moderate or good.
