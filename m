From: Joi Ellis <gyles19@visi.com>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Thu, 5 Feb 2009 22:45:13 -0600 (CST)
Message-ID: <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
Reply-To: gyles19@visi.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 06:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVIqu-0002NT-MX
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbZBFFAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 00:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbZBFFAl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:00:41 -0500
Received: from mailfront2.g2host.com ([208.42.176.213]:33529 "EHLO g2host.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750704AbZBFFAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 00:00:41 -0500
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Feb 2009 00:00:41 EST
Received: from [209.98.98.8] (account gyles19@visi.com HELO localhost)
  by mailfront2.g2host.com (CommuniGate Pro SMTP 5.1.16)
  with ESMTPSA id 87130801; Thu, 05 Feb 2009 22:45:39 -0600
X-X-Sender: joi@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108653>

On Fri, 6 Feb 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 6 Feb 2009, Joi Ellis wrote:
> 
> > "make all" fails becuase my libaries are old:
> > 
> >     LINK git-fast-import
> > fast-import.o: In function `store_object':
> > /usr/local/src/git/git/fast-import.c:1086: undefined reference to `deflateBound'
> > /usr/local/src/git/git/fast-import.c:1109: undefined reference to `deflateBound'
> 
> You need to install a newer libz.  (And this is not a chicken & egg 
> problem.)

Yes, this *is* a chicken & egg problem.  As I said in my original post,
git will build on this machine if I have a configure script to run
first.  The configure script explicitly checks for the version of libz
and sets a DEFINE appropriately.  Because there is no configure script
provided, and because my autoconf is considered too old, I simply can't
start the build process because I can't generate the missing configure
script.

Other projects put the configure script into source control to avoid
exactly this issue.

-- 
Joi Ellis                    
gyles19@visi.com

No matter what we think of Linux versus FreeBSD, etc., the one thing I
really like about Linux is that it has Microsoft worried.  Anything
that kicks a monopoly in the pants has got to be good for something.
           - Chris Johnson
