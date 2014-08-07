From: Tony Finch <dot@dotat.at>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 17:42:34 +0100
Message-ID: <alpine.LSU.2.00.1408071735410.23775@hermes-1.csi.cam.ac.uk>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com> <20140806200726.GE23449@localhost> <alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk> <20140807155828.GM23449@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 18:42:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQm4-0000sB-8p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbaHGQmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:42:40 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:44358 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500AbaHGQmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:42:39 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:57229)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XFQlu-00025f-EP (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 07 Aug 2014 17:42:34 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XFQlu-0007SS-Cn (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 07 Aug 2014 17:42:34 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <20140807155828.GM23449@localhost>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254977>

Nico Williams <nico@cryptonector.com> wrote:
> On Thu, Aug 07, 2014 at 12:38:48PM +0100, Tony Finch wrote:
>
> > But [a rebasing workflow] is inconvenient for deploying the patched
> > version to production (which is the point of developing the fixes) - I
> > want a fast-forwarding branch for that.
>
> I'm not sure I follow this.  You deploy what you build, and you build
> the HEAD of the production branch, whatever that is.  If it gets
> rebased, so it it does.

The problem is that the production branch gets copied around: pushed to
the repo server, pulled by other team members, etc. Forced pushes
are accident-prone, as is resetting a rebased branch after a pull.

> > So I have a small tool which maintains a publication branch which
> > tracks the head of a rebasing branch. It's reasonably satisfactory so
> > far...
> >
> > https://git.csx.cam.ac.uk/x/ucs/git/git-repub.git
>
> Yeah, that's useful.

Glad you think so :-)

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Thames: Northeast veering southeast 4 or 5, occasionally 6. Slight, becoming
slight or moderate. Fair then rain or thundery showers. Good, becoming
moderate or poor for a time.
