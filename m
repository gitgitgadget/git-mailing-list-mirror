From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 18:47:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504191846160.29929@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com> <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:43:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1Re-0007O8-04
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVDSWr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVDSWr5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:47:57 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:14258 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261271AbVDSWry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:47:54 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DO1VO-0001Ix-00; Tue, 19 Apr 2005 18:47:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, Linus Torvalds wrote:

> (*) Actually, I think it's the compression that ends up being the most
> expensive part.

You're also using the equivalent of '-9', too -- and *that's slow*.
Changing to Z_NORMAL_COMPRESSION would probably help a lot
(but would break all existing repositories, sigh).
  --scott

DES WTO Indonesia NRA LCPANGS supercomputer plastique class struggle 
AEFOX Pakistan ODEARL Secretary KUGOWN Cheney ODIBEX SDI AP JMMADD
                          ( http://cscott.net/ )
