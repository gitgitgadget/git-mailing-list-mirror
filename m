From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: Storing Maintainers info around the kernel tree
Date: Thu, 16 Aug 2007 11:31:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708161128540.3757-100000@iolanthe.rowland.org>
References: <46C469A5.8020003@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Salikh Zakirov <salikh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-pm@lists.linux-foundation.org>, <git@vger.kernel.org>
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 17:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILhJv-0000xm-J8
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 17:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763239AbXHPPbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762013AbXHPPbX
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 11:31:23 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:35782 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763239AbXHPPbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 11:31:10 -0400
Received: (qmail 10336 invoked by uid 2102); 16 Aug 2007 11:31:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2007 11:31:04 -0400
X-X-Sender: stern@iolanthe.rowland.org
In-Reply-To: <46C469A5.8020003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56018>

On Thu, 16 Aug 2007, Rene Herman wrote:

> > It would be much easier to put in the "kernel/somesubsys" directory a 
> > Maintainers file which has:
> 
> It's ofcourse possible, but note that if we want this stuff to be minimally 
> manual, moving files around (and deleting them) then requires editing these 
> actual in-tree files via a tool.
> 
> With the properties deleting files just requires deleting any file-specific 
> properties alongside which is trivial since those are linked from the file.
> 
> Moving stuff works by building a list of all properties that are set on the 
> source starting at the source and destination's highest shared parent 
> directory and then reconstructing this list at the destination, striking 
> properties off the list that are already set at the destination.
> 
> Adding properties, alongside added files or after the fact, could be done 
> via standard patch submissals via the kind of "meta-diff" that already 
> exists for "git move".
> 
> I really believe this stuff should be meta-data -- and these properties as 
> outlined work well it seems.

Please remember that not everybody uses git.  The MAINTAINERS data 
should be available in the kernel source itself.

(Maybe your suggestion is consistent with this -- I simply wanted to 
raise the point.)

Alan Stern
