From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 11:57:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0505031153550.32767@cag.csail.mit.edu>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
 <200505030724.57827.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 17:52:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSzgZ-0004IZ-5M
	for gcvg-git@gmane.org; Tue, 03 May 2005 17:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVECP57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVECP57
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:57:59 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:55256 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261799AbVECP54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 11:57:56 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DSzm4-0007xe-00; Tue, 03 May 2005 11:57:28 -0400
To: Chris Mason <mason@suse.com>
In-Reply-To: <200505030724.57827.mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Chris Mason wrote:

> your delta generator later this week.  Some quick and dirty space numbers to
> show why we need to pack the files together:

Are you accurately accounting for the cost of the extra hard/soft links 
your scheme requires?  Ie the directories get larger, lookups take 
slightly longer, etc.  Also access to a given file takes longer, and the 
deltas are referring to *other* packed files which *also* take longer to 
decompress and access...

How much better does delta-fication do, compared to just packing?
  --scott

NSA FJDEFLECT radar WASHTUB justice LCFLUTTER KUCLUB PBHISTORY Ft. Bragg 
ammunition immediate ESMERALDITE DC terrorist C4 SLBM affinity group
                          ( http://cscott.net/ )
