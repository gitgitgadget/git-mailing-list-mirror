From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 18:01:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111800500.10498@intel-tinevez-2-302>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302> <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Mar 11 18:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRqv-0006Gp-Ly
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 18:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbZCKRBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755037AbZCKRBg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 13:01:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:59349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753883AbZCKRBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 13:01:35 -0400
Received: (qmail invoked by alias); 11 Mar 2009 17:01:30 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 11 Mar 2009 18:01:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nMgNf0ZDnQgYK+RVx0NgiyQ9YPrzBzxDAKTX1V+
	dznzRvx273pH0v
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112959>

Hi,

On Wed, 11 Mar 2009, david@lang.hm wrote:

> On Wed, 11 Mar 2009, Johannes Schindelin wrote:
> 
> > On Wed, 11 Mar 2009, saurabh gupta wrote:
> >
> > > What I think is to implement file formats other than text like that
> > > written on wiki i.e. latex, xml, or even any database file (db file).
> > > Another idea (although it can be weired also) is to implement the new
> > > file formats in the plug-in formats. For example, to incorporate the
> > > merger engine for a new file format, a plug-in is created and can be
> > > integrated with the present merger in the git. However, I am not sure
> > > how much valid is this idea to make the present merger in git to be
> > > compatible with the plug-ins for enabling newer file formats.
> >
> > I am not sure that a plugin structure is needed.  Take, for example, three
> > different .xml based formats: OpenOffice documents, .svg files and Ant
> > build.xml files.  They need very different user interfaces.
> >
> > > I am thinking of using gtk+ libraries to implement the GUI part (I am
> > > quite comfortable with gtk+).
> >
> > I mentioned Tcl/Tk, because it is portable, but I'll also take gtk-based
> > stuff ;-)
> >
> > > However, I think in merging and notifying about the conflicts in the xml
> > > files, other things can also be put forward. Like the GUI will show the
> > > number of tags differing and what are the new tags added and even if any
> > > tag is renamed with the content unchanged. If possible, how about
> > > showing a tree like structure (just like DOM model) to compare (or diff)
> > > the two xml files.
> >
> > This is a little bit too low-level for my liking.  Taking the OpenOffice
> > example again, the GUI should not expose XML at all...
> 
> don't assume that you have a GUI just to handle a filetype. if you have one,
> good, make use of it. but have a fallback for how to deal with things if all
> you have is a text terminal.

I do not think it makes sense to assume all you have at your hands is a 
terminal when you try to resolve a merge conflict in an .svg file.

Ciao,
Dscho
