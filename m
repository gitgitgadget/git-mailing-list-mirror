From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 11:45:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291140250.3611@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
 <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org>
 <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org>
 <20070129192911.GA12903@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 29 20:46:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBcRs-0003qB-0n
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 20:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbXA2TpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 14:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbXA2TpY
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 14:45:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53015 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbXA2TpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 14:45:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0TJjD1m009035
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Jan 2007 11:45:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0TJjCBJ028653;
	Mon, 29 Jan 2007 11:45:13 -0800
In-Reply-To: <20070129192911.GA12903@thunk.org>
X-Spam-Status: No, hits=-0.466 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38093>



On Mon, 29 Jan 2007, Theodore Tso wrote:
> 
> One approach which might work is where you hover your mouse over a
> line, and it pops up a tiny window with the blame information if the
> mouse remains stationary for more than a second or two.

Yes. I think that's the kind of interface that most people really want.

Of course, almost always, you'd actually want it in your editor of choice, 
and that's not going to happen. But if it looks basically just like a 
normal editor (perhaps with line numbers - that is fairly traditional in 
annotations), that's the basic most spartan interface I can think of. With 
"hover" just causing the extended information for the few lines around the 
mouse to show up (and a "select <n> lines with mouse" for more than just a 
few lines).

> Another thing which would be really useful is where the lines that
> have been changed in the last n commits (where n is probably between
> 3-5) are highlighted using different colors.

That would be very natural for the way "git blame --incremental" works, so 
yes, I agree. Not only does it highlight the likely interesting places, 
but it's very much the natural flow for the whole tool.

Ok. Now we just need some sucker^H^H^H^H^H^Henterprising person to 
actually do this ;)

			Linus
