From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn dcommit failure
Date: Sat, 9 Jun 2007 13:05:27 -0700
Message-ID: <20070609200527.GC32225@muzzle>
References: <87veecat2k.fsf@mid.deneb.enyo.de> <87d50kas6p.fsf@mid.deneb.enyo.de> <20070529144742.GG1025@.intersec.eu> <87k5ur64hx.fsf@mid.deneb.enyo.de> <20070605101744.GA12948@muzzle> <87abvb508z.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Jun 09 22:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx7Bi-0003Hu-IH
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 22:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937AbXFIUF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758863AbXFIUF3
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 16:05:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42277 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758772AbXFIUF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 16:05:28 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 31E072DC032;
	Sat,  9 Jun 2007 13:05:27 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 09 Jun 2007 13:05:27 -0700
Content-Disposition: inline
In-Reply-To: <87abvb508z.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49610>

Florian Weimer <fw@deneb.enyo.de> wrote:
> * Eric Wong:
> 
> >> After manually committing the offending changes via Subversion, I
> >> git-svn has begun to work again, too (but I haven't yet tried to
> >> change the same files).
> >
> > Would upgrading to 1.5.2 final have helped?
> 
> I've upgraded to this version, but since it's not exactly trivial for
> me to test this on the Subversion side, it'll take some time until I
> can be confident that the bug was indeed fixed in the
> 6442754d6cc0056cf5b69b43d218f8b6d317e7f5 revision.
> 
> Is there some kind of magic environment variable I could set to get
> tracing information?

Nope.  I usually strace protocol or put print statements all over the
code :x

> If such bugs turn up, I'd try to debug them on
> my own and submit a fix, or at least a reproduction recipe.  (The
> repository itself may contain personally identifiable information in
> test cases and hence, cannot be shared.)

Was the commit modifying a file that was just one directory deep from
the project you were working on?

-- 
Eric Wong
