From: Peter Foley <pefoley2@verizon.net>
Subject: Re: [PATCH/RFC] Move contents of libgit.a to lib subdirectory
Date: Sun, 19 Jun 2011 21:21:42 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1106192111250.18284@linux.foleyremote.com>
References: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
 <BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Foley <pefoley2@verizon.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 03:23:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYTCy-0007Vw-5U
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 03:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1FTBXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 21:23:15 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:55866 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1FTBXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 21:23:14 -0400
Received: from linux ([unknown] [108.28.47.43]) by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LN2005VREIJ8Z91@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 19 Jun 2011 20:23:13 -0500 (CDT)
In-reply-to: <BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176045>



On Sun, 19 Jun 2011, Shawn Pearce wrote:

> On Sun, Jun 19, 2011 at 17:50, Peter Foley <pefoley2@verizon.net> wrote:
> > This patch tries to organize the git source tree by moving the files which
> > make up libgit.a to a lib subdirectory.
> > Before this patch the toplevel source directory contained 285 files.
> > After this patch the root directory will contain 167 files and
> > the lib subdirectory will contain 119 files
> ...
> 
> Thanks. But why is this amount of churn necessary or being
> recommended? What problem does this address? Is that worth the pain
> this puts on every other in-flight change that is still being
> developed, or is already in the review pipeline?
> 
> -- 
> Shawn.
> 

The basic idea is to organize the git source directory more than it is 
right now (a flat directory with all the source files at the toplevel).
Moving the contents of libgit.a seemed to be a logical way to start.
 
Thanks,

Peter
