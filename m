From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix warnings on PowerPC - use C99 printf format if available
Date: Wed, 10 Jan 2007 01:37:26 -0500
Message-ID: <20070110063726.GD30765@spearce.org>
References: <20070110040710.7403.74668.stgit@localhost.localdomain> <7vk5zvfobp.fsf@assigned-by-dhcp.cox.net> <20070110012443.xixagu9e5s04wwss@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 07:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4X5c-0001z2-8j
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 07:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbXAJGhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 01:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbXAJGhc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 01:37:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45863 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbXAJGhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 01:37:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4X5U-00004x-AO; Wed, 10 Jan 2007 01:37:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 91CE120FBAE; Wed, 10 Jan 2007 01:37:26 -0500 (EST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <20070110012443.xixagu9e5s04wwss@webmail.spamcop.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36480>

Pavel Roskin <proski@gnu.org> wrote:
> Quoting Junio C Hamano <junkio@cox.net>:
> > Pavel Roskin <proski@gnu.org> writes:
> >
> > > Signed-off-by: Pavel Roskin <proski@gnu.org>
> >
> > This needs a better subject.  I do not see anything PowerPC specific...
> 
> Indeed, it happens on i386 as well (but not on x86_64).  OK, the subject should
> be:
> 
> Fix warnings in sha1_file.c - use C99 printf format if available

When I wrote that code it was warning free on Mac OS X/PowerPC.
Apparently that wasn't true elsewhere.  :-)
Thanks for cleaning up after me.

-- 
Shawn.
