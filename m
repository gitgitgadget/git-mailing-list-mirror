From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 14:39:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701271432450.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <20070127201640.GA25637@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-135048198-1169937570=:25027"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 23:39:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAwD8-0007sY-Dk
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 23:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbXA0Wje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 17:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbXA0Wjd
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 17:39:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37115 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbXA0Wjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 17:39:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RMdU1m021734
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 14:39:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RMdUtH017995;
	Sat, 27 Jan 2007 14:39:30 -0800
In-Reply-To: <20070127201640.GA25637@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.476 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38004>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-135048198-1169937570=:25027
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 27 Jan 2007, Jeff King wrote:
> 
> And here's a (very hackish) incremental viewer using perl/gtk (you will
> need the Gtk2 perl module installed). It doesn't take any options, and it
> just shows the blame output (no lookup of committer/date).

Heh. Ok, this is absolutely the ugliest thing I have ever seen, but after 
doing a simple "yum install perl-Gtk2" it clearly does work ;)

(For some reason I have never fathomed, gtk apps seem to always like 
adding about a mile of empty space around lines. I want my text nice and 
tight - gtk menus and text always look like it's 1½ line spacing to me. 
Which may be ok when you're writing a paper and want space to add your 
scribbles and underlining etc, but not when you're looking at the screen, 
and it just means that there's *less* space for commentary).

> It needs much work (and cleanup) to be useful, but I think it proves
> your point: in the time it takes me to actually start looking through
> the output, the blame has finished without me noticing!

Yeah. It needs the logic to coalesce consecutive file-name/line-nr 
entries, but even after you add a "-C" to the arguments (which really 
makes 'git-blame' quite a bit more expensive), it doesn't feel "slow". 

Just ugly ;)

		Linus "shouldn't throw stones when anything
			I would have done would have been
			uglier still" Torvalds
			
---1463790079-135048198-1169937570=:25027--
