From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [OT] How to get the discussion details via notes
Date: Thu, 1 Nov 2012 08:49:40 +0100
Message-ID: <20121101074940.GC18557@m62s10.vlinux.de>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
 <20121031003721.GV15167@elie.Belkin>
 <CAGdFq_jNM_48muXJ0BX2ehC=k8T9GLui_QtRO8D8C7h6b5jyHg@mail.gmail.com>
 <20121031060529.GA30432@elie.Belkin>
 <20121031095327.GB18557@m62s10.vlinux.de>
 <20121031141024.GB24291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 08:50:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTpXL-0002iH-7S
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 08:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab2KAHtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 03:49:47 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:50929 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753715Ab2KAHtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 03:49:46 -0400
Received: (qmail invoked by alias); 01 Nov 2012 07:49:44 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp016) with SMTP; 01 Nov 2012 08:49:44 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18fEIwnVzAfREo9xW9reoVsL/PGovJPSegit4WpXN
	Y7+FvlEgzNsIuR
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id CF278EC002; Thu,  1 Nov 2012 08:49:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121031141024.GB24291@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208867>

On Wed, Oct 31, 2012 at 10:10:24AM -0400, Jeff King wrote:
> On Wed, Oct 31, 2012 at 10:53:27AM +0100, Peter Baumann wrote:
> 
> > > covers the basics (current behavior and intent of the change) in its
> > > first two paragraphs and anyone wanting more detail can use
> > > 
> > > 	GIT_NOTES_REF=refs/remotes/charon/notes/full \
> > > 	git show --show-notes <commit>
> > > 
> > > to find more details.
> > 
> > I seem to miss something here, but I don't get it how the notes ref
> > becomes magically filled with the details of this discussion.
> 
> Thomas Rast (aka charon) keeps a mapping of commits to the email threads
> that led to them. You can fetch it from:
> 
>    git://repo.or.cz/git/trast.git
> 
> (try the notes/full and notes/terse refs).
> 

Nice! I didn't know about that.

-Peter
