From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 15:02:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 15:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhP22-0004LF-TK
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 15:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbZCKOCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 10:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754046AbZCKOCG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 10:02:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:47463 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753934AbZCKOCD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 10:02:03 -0400
Received: (qmail invoked by alias); 11 Mar 2009 14:02:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 11 Mar 2009 15:02:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YrXpuzFaYGc10k9M+aDNSg9W9WDjs2/8vqIc8Nx
	ZSQNYcfnSUM2pS
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112930>

Hi,

On Wed, 11 Mar 2009, saurabh gupta wrote:

> What I think is to implement file formats other than text like that 
> written on wiki i.e. latex, xml, or even any database file (db file).  
> Another idea (although it can be weired also) is to implement the new 
> file formats in the plug-in formats. For example, to incorporate the 
> merger engine for a new file format, a plug-in is created and can be 
> integrated with the present merger in the git. However, I am not sure 
> how much valid is this idea to make the present merger in git to be 
> compatible with the plug-ins for enabling newer file formats.

I am not sure that a plugin structure is needed.  Take, for example, three 
different .xml based formats: OpenOffice documents, .svg files and Ant 
build.xml files.  They need very different user interfaces.

> I am thinking of using gtk+ libraries to implement the GUI part (I am 
> quite comfortable with gtk+).

I mentioned Tcl/Tk, because it is portable, but I'll also take gtk-based 
stuff ;-)

> However, I think in merging and notifying about the conflicts in the xml 
> files, other things can also be put forward. Like the GUI will show the 
> number of tags differing and what are the new tags added and even if any 
> tag is renamed with the content unchanged. If possible, how about 
> showing a tree like structure (just like DOM model) to compare (or diff) 
> the two xml files.

This is a little bit too low-level for my liking.  Taking the OpenOffice 
example again, the GUI should not expose XML at all...

Ciao,
Dscho
