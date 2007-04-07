From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] git pull and importers
Date: Sat, 7 Apr 2007 14:50:28 -0700
Message-ID: <20070407215027.GA20424@hand.yhbt.net>
References: <Pine.LNX.4.64.0704062239420.27922@iabervon.org> <20070407202409.GA5107@muzzle> <7vr6qvc1kl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 00:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIo4-00052M-2a
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966352AbXDGVu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966360AbXDGVu3
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:50:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50067 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966352AbXDGVu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:50:28 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 29F547DC091; Sat,  7 Apr 2007 14:50:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr6qvc1kl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43990>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > When git-fetch is called without any remote arguments, it would look for
> > [remote "origin"] as it does now.  However, if no [remote "..."]
> > sections are found (as is common with importer-created repos), it would
> > try other importers: [svn-remote "svn"], (and hopefully one day
> > [cvs-remote "cvs"], [arch-remote "arch"], ...).
> 
> I wonder why wouldn't the alternative of noticing the URL scheme
> of '[remote "svn"] url' variable is "svn://".  That is...

SVN repositories can also be http:// or https://, too.

-- 
Eric Wong
