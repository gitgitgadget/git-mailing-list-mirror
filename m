From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 11:28:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:29:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWprf-00063B-8l
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZBJK1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbZBJK1s
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:27:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:37152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752433AbZBJK1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 05:27:47 -0500
Received: (qmail invoked by alias); 10 Feb 2009 10:27:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 10 Feb 2009 11:27:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18B39lMtKMBM7t/I8NpuJdjmNJT03/9+lQz/ht/Xo
	INlsQh3PggyzQH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0902092218050.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109197>

Hi,

[nice typo in the subject BTW]

On Mon, 9 Feb 2009, Daniel Barkalow wrote:

> I'm getting a "fatal: failed to apply delta" from fast-import. I'm using 
> a lot of checkpoints, and I haven't had it happen without making 
> progress, so I was eventually able to import what I was importing (bunch 
> of stuff I can't distribute, imported from perforce with the latest 
> version of my p4 importer that I'm still working on). Also, everything 
> that was saved by the checkpoints was valid and correct (at least after 
> the fact).
> 
> I'm going to see if it's reproducable, and, if so, if I can get a test 
> case that I can distribute, but I wanted to post to see if anyone had 
> any special debugging advice for this error message and program 
> combination.

I see three likely candidates: two in index-pack.c and one in sha1_file.c.  
My advice: instrument the code (IOW litter the code with debug output that 
tells you where it did what), and then run it on the same test case you 
had the problems.

Ciao,
Dscho
