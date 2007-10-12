From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 12:34:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710121231410.25221@racer.site>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
 <Pine.LNX.4.64.0710112144380.4174@racer.site>
 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710121057540.25221@racer.site> <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Oct 12 13:35:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgInY-0007lk-9T
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXJLLfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbXJLLfH
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:35:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:41890 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753590AbXJLLfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:35:06 -0400
Received: (qmail invoked by alias); 12 Oct 2007 11:35:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 12 Oct 2007 13:35:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mCL1P54KmDEDWJ3f1WHiPGbdRVJa81j4+DWVJMH
	ZwncvQgSon1lNJ
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60677>

Hi,

On Fri, 12 Oct 2007, Peter Karlsson wrote:

> > But don't you see?  When switching branches, this totally breaks down.
> 
> Why would it? If the file is the same on both branches, nothing would 
> happen (it is still the same version), and if the file is different, it 
> gets changed anyway, and a new keyword expansion would take place.

Finding out which commit last changed that file is slow.  That's why it 
breaks down.  It is possible, yes.  But then I think that you really do 
not want this.  You are just to used to CVS/SVN to see that there is a 
much better way in git.

> > No, really, IMHO it is enough to show either the commit name or the 
> > blob name of the file. After all, you are not interested in the date 
> > that this file was last committed, but in the _contents_.
> 
> Yes, but I want it on the lowest addressable unit size, i.e on the file 
> level (I could possibly want to have the last commit for a set of files 
> when I have something that get generated from several sources, but that 
> is rare for a regular website, unless since javascripts and stylesheets 
> etc. are delivered separately).

The lowest addressable unit size is the file level, alright.  And $Id$ 
contains the blob name.  IOW it contains a key to retrieve the contents of 
exactly this version of the file.

Ciao,
Dscho
