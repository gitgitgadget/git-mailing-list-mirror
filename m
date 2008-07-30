From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] Add NO_RSYNC to allow building without rsync
Date: Wed, 30 Jul 2008 15:42:09 -0600
Message-ID: <alpine.LNX.1.10.0807301539160.13032@xenau.zenez.com>
References: <20080730185225.GG10399@yugib.highrise.ca> <7vod4f3zfu.fsf@gitster.siamese.dyndns.org> <20080730204948.GK10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:44:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJS5-0001mj-46
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYG3VmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbYG3VmM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:42:12 -0400
Received: from zenez.com ([166.70.62.2]:15883 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbYG3VmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:42:10 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 07E333F973; Wed, 30 Jul 2008 15:42:09 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id E87373F972;
	Wed, 30 Jul 2008 15:42:09 -0600 (MDT)
In-Reply-To: <20080730204948.GK10399@yugib.highrise.ca>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90861>

On Wed, 30 Jul 2008, Aidan Van Dyk wrote:
> * Junio C Hamano <gitster@pobox.com> [080730 16:11]:
> > > I came about this because SCO OpenServer doesnt' have mkdtemp.  But I never use
> > > rsync, so making it optional was an easy fix.
> > 
> > Perhaps "make NO_MKDTEMP=YesPlease" is a much better fix for your
> > particular environment?
> 
> Yes, I found that out after...
> 
> > The patch is seriously whitespace damaged, in any case.
> 
> Ooops... copy-n-paste from git-format-patch|more on some crappy sco terminal
> through a screen session...  I guess someone in there translated tabs to
> spaces...

I do have rsync.  I use it all the time on OpenServer 6.  I have automated 
rsync backups of certain Openserver 6 machines.

tech0 > rsync --version
rsync  version 3.0.2  protocol version 30
Copyright (C) 1996-2008 by Andrew Tridgell, Wayne Davison, and others.
Web site: http://rsync.samba.org/
Capabilities:
    64-bit files, 64-bit inums, 32-bit timestamps, 64-bit long ints,
    socketpairs, hardlinks, symlinks, no IPv6, batchfiles, inplace,
    append, ACLs, no xattrs, iconv, no symtimes

tech0.zenez.com and osr600.zenez.com are OpenServer 6 machines.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
