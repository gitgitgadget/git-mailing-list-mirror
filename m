From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PVCS (or RCS) importer for Git?
Date: Fri, 28 Mar 2008 17:33:59 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803281730060.18259@racer.site>
References: <Pine.LNX.4.64.0803281713230.24460@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:34:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfHXO-0006ZQ-Gd
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 17:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbYC1QeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 12:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbYC1QeA
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 12:34:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:38101 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750793AbYC1Qd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 12:33:59 -0400
Received: (qmail invoked by alias); 28 Mar 2008 16:33:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 28 Mar 2008 17:33:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LsEx5GEJLxGhJzEsg3bAj71rICm10xeosIlN/Eb
	dXda0xjx+/VRrU
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0803281713230.24460@ds9.cixit.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78427>

Hi,

On Fri, 28 Mar 2008, Peter Karlsson wrote:

> Has anyone written an importer to import sources stored in PVCS into
> Git?

I once tried, but apparently, there are different repository formats for 
PVCS.  For example, pvcs2cvs did not work for me.  IIRC I used a simple 
shell script to convert pvcs (using the mega-slow command line tools) to 
,v files.  Then I converted that to Git.

But it was pretty bad, the incremental update was broken more often than 
not.

And after a few days, it became apparent that I do not need a full import, 
but that a simple commit-to-git-after-a-pvcs-update would be sufficient.

> I have had some limited success by running a the pvcs2rcs.pl script from 
> CVS's sources and converting that to Git using cvs2svn, but I believe 
> the result could be better if I converted directly.

Judging from the problems of importing CVS to Git (which mostly stem from 
the file-versioning paradigm), I suggest not trying to be too clever, but 
convert it to cvs and use a good cvs importer, such as cvs2svn (which 
despite its name also imports into Git) or parsecvs.

Ciao,
Dscho
