From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 12:29:38 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903111159530.19665@iabervon.org>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 17:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRLu-0000Ea-2r
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZCKQ3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbZCKQ3m
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:29:42 -0400
Received: from iabervon.org ([66.92.72.58]:37379 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbZCKQ3l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 12:29:41 -0400
Received: (qmail 8336 invoked by uid 1000); 11 Mar 2009 16:29:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Mar 2009 16:29:38 -0000
In-Reply-To: <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112951>

On Wed, 11 Mar 2009, saurabh gupta wrote:

> On Wed, Mar 11, 2009 at 7:32 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 11 Mar 2009, saurabh gupta wrote:
> >
> >> What I think is to implement file formats other than text like that
> >> written on wiki i.e. latex, xml, or even any database file (db file).
> >> Another idea (although it can be weired also) is to implement the new
> >> file formats in the plug-in formats. For example, to incorporate the
> >> merger engine for a new file format, a plug-in is created and can be
> >> integrated with the present merger in the git. However, I am not sure
> >> how much valid is this idea to make the present merger in git to be
> >> compatible with the plug-ins for enabling newer file formats.
> >
> > I am not sure that a plugin structure is needed.  Take, for example, three
> > different .xml based formats: OpenOffice documents, .svg files and Ant
> > build.xml files.  They need very different user interfaces.
> 
> okay. In that case, if they have  a different user interfaces then
> separate plug-in would be needed for each of these. May be this will
> get more messy.

One thing that I think would be good whenever possible is to have the 
merge program generate a file in the same format which is easily 
recognizable as having conflict markers. For example, I think it should be 
possible to show conflicts in the text of office documents by having 
styles for each side of the merge, and show each side's content in the 
appropriate style. Then the user opens the document with their choice of 
office software, finds the things in the conflict styles, and decides what 
the result should be.

Of course, if the two sides conflict over something that isn't text, it 
gets harder.

Also remember that, for a merge, there are two important cases: (1) the 
two sides changed things that aren't related at all; (2) the two sides 
changed things that might affect each other. In case (1), the tool should 
take care of everything automatically and report that it took care of it; 
in case (2), it should reliably determine that user assistance is 
required.

	-Daniel
*This .sig left intentionally blank*
