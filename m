From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [ANNOUNCE] GIT 1.5.4
Date: Fri, 8 Feb 2008 01:53:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802080143440.11591@racer.site>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com>
 <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802071157360.2896@woody.linux-foundation.org>
 <4C918ADB-6FF5-458E-AC81-5683850E1FE4@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@visageimaging.com>,
	Luciano Rocha <luciano@eurotux.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 02:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNIQy-0006EO-Fy
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 02:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYBHBxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 20:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbYBHBxK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 20:53:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:43614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751299AbYBHBxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 20:53:08 -0500
Received: (qmail invoked by alias); 08 Feb 2008 01:53:05 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp012) with SMTP; 08 Feb 2008 02:53:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ro201lJKRy+4wrRFTSS9hDJD7bgtX3Vo/4082ry
	LchhKj63C61REp
X-X-Sender: gene099@racer.site
In-Reply-To: <4C918ADB-6FF5-458E-AC81-5683850E1FE4@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73025>

Hi,

On Thu, 7 Feb 2008, Steffen Prohaska wrote:

> On Feb 7, 2008, at 8:59 PM, Linus Torvalds wrote:
> > 
> > On Thu, 7 Feb 2008, Junio C Hamano wrote:
> > > 
> > > I think removing the license dialog is a bad idea.  You need to tell 
> > > the end-user about his rights, and one of the things is that he can 
> > > get source to git under the terms of GPLv2.  The bug is not about 
> > > showing the license, but is about refusing to install unless the end 
> > > user agrees with it.
> > 
> > Yeah. Why not just rather than the whole ok/cancel discussion, go with 
> > a single button saying "good for me!" and be done with it.
> > 
> > IOW, the license thing should be considered *informational* rather 
> > than a choice. Because to a user, that's exactly what the GPL is.
> 
> Ok, if there are no further objections, we'll do that.
> 
> Sebastian, can we easily modify the license dialog with Inno Setup? The 
> license should be displayed and a single click should be sufficient to 
> "continue".

It looks like "LicenseFile" is a special variable in InnoSetup, and it is 
not _that_ easy to change it to an "I am okay with it; I read it" text.  
Maybe something like the release notes would be good ("Source: ... Flags: 
isreadme")?

In any case, I think this discussion has outlived its usefulness: there 
are _many_ _more_ pressing issues with msysGit.

Having said that, I am really amazed that we seem to finally have picked 
up some Windows experts...  So my hopes are high for a catch-up with 
git.git that will lead to an msysGit-from-git.git soon!

For example, the git-svn issue seems resolved now (thanks Simon, Christian 
and Mike -- I call them the "S-C-M" gang).  If we can squeeze better 
performance out of it, all the better.

git-cheetah also appears to gather way nicely: it seems that the only 
obstacle is my own laziness (and admittedly, lack of time) to review the 
changes and push them!

Hoist the anchors,
Dscho
