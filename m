From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 10:04:21 -0600
Message-ID: <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 18:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5NOQ-00042v-Bh
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbYFHQEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYFHQEY
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:04:24 -0400
Received: from zenez.com ([166.70.62.2]:16062 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754500AbYFHQEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 12:04:24 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 17505E5DBC; Sun,  8 Jun 2008 10:04:23 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 015C3E5DB6;
	Sun,  8 Jun 2008 10:04:22 -0600 (MDT)
In-Reply-To: <m3prqsvsiq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84286>

On Sun, 8 Jun 2008, Jakub Narebski wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
> 
> > This patch adds support to compile git on 12 additional platforms.
> > They are based on UNIX Systems Labs (USL)/Novell and SYS V
> > based OS's, SCO OpenServer 5.0.X, SCO UnixWare 7.1.4, OpenServer 6.0.X and
> > SCO pre OSR 5 OS's to build and run git.
> > 
> > Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com> 
> > ---
> [...]
> > git-compat-util.h
> > 
> > __USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
> > compiler and/or some SysV based OS's.
> > 
> > __M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
> > of the SCO OS's.  It is used just like Apple and BSD, both of these
> > shouldn't have _XOPEN_SOURCE defined.
> 
> Above info is neither in commit message, not in comment in some file.
> It would be nice to have it in somewhere, and not only in mailing list
> archives.

This was from my own copy of the master archive.  It is my proposal.  I 
thought you had to get an OK from this list before you do a push to the 
main archive.  Am I missing something?  I am new to this list and the 
proper methods for submitting patches.  I thought I was following the 
guidelines from 

http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD

What am I missing?

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
