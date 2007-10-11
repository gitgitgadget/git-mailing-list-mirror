From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Spam: Re: git branch performance problem?
Date: Thu, 11 Oct 2007 11:58:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710111148000.4174@racer.site>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> 
 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> 
 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> 
 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com> 
 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com> 
 <20071010213925.GB2963@fieldses.org>  <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
  <470D585D.1030808@nrlssc.navy.mil> <e2b179460710110241i445bc61ep8ae60e421c19c0f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Lars Hjemli <hjemli@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 12:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifvl5-0000rX-SW
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 12:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbXJKK6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 06:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbXJKK6y
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 06:58:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:44364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbXJKK6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 06:58:53 -0400
Received: (qmail invoked by alias); 11 Oct 2007 10:58:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 11 Oct 2007 12:58:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18T4elEBhcTnUKL2xyHWTeRLFTIBkghXDkIHLWQVO
	k2TgufbRRj0271
X-X-Sender: gene099@racer.site
In-Reply-To: <e2b179460710110241i445bc61ep8ae60e421c19c0f0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60591>

Hi,

On Thu, 11 Oct 2007, Mike Ralphson wrote:

> It's not something I've really looked into, but there seems to be a
> reflogs mechanism which can temporarily pin an otherwise unreferenced
> object so it doesn't get deleted. Would it be possible to populate the
> remote's view of referenced objects into this, at the point of clone,
> push or pull, which would seem to be the points at which this might be
> changing.
> 
> Obviously this is of no use if you're 'anonymously' poncing off a
> third repo to save clone time, but if you're in control of both repo's
> it might be useful.

I cannot really allege that I understood what you were trying to say, but 
I guess you want to use clone to get rid of objects you just threw out by 
either filter-branch or deleting a branch.

The answer is that the file:// as well as the git:// protocol will do 
that.  For local clones, they are not the default, since they are slower 
than hardlinking.

Hth,
Dscho
