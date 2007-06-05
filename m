From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow to specify svn branch for commands
Date: Tue, 5 Jun 2007 02:56:24 -0700
Message-ID: <20070605095624.GA32225@muzzle>
References: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz> <1181017002.27463.3.camel@megatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Git Central <git@vger.kernel.org>
To: Stephen Touset <stephen@touset.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvVmR-0006xK-7B
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 11:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763229AbXFEJ41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 05:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764285AbXFEJ41
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 05:56:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52386 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764275AbXFEJ40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 05:56:26 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 9D18A2DC034;
	Tue,  5 Jun 2007 02:56:24 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 05 Jun 2007 02:56:24 -0700
Content-Disposition: inline
In-Reply-To: <1181017002.27463.3.camel@megatron>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49177>

Stephen Touset <stephen@touset.org> wrote:
> On Tue, 2007-06-05 at 15:42 +1200, Sam Vilain wrote:
> > "git-svn dcommit" ends up making an arbitrary decision when pushing
> > back merges.  Allow the user to specify which one is used, albeit in a
> > rather hack-ish way.
> 
> I've been thinking about this. I'm rather new to git internals, but if
> I've created a local copy of a remote branch (git-checkout -b
> local-branch --track remote-branch), can't git-svn use the tracking
> metadata to determine which part of the tree to dcommit to?

Probably.  --track didn't exist when "git-svn dcommit" was written
and I didn't even know about it until now.  Needless to say,
not everybody uses or knows about it, but it would probably be
a good option to add to git-svn.

-- 
Eric Wong
