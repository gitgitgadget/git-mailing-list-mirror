From: Theodore Tso <tytso@mit.edu>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 14:29:12 -0500
Message-ID: <20070129192911.GA12903@thunk.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 20:32:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBcEN-0005h9-VV
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 20:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXA2Tbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 14:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXA2Tbk
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 14:31:40 -0500
Received: from thunk.org ([69.25.196.29]:53710 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXA2Tbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 14:31:39 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HBcIr-0002bU-NV; Mon, 29 Jan 2007 14:36:33 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HBcBk-00022r-61; Mon, 29 Jan 2007 14:29:12 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38092>

On Mon, Jan 29, 2007 at 08:24:52AM -0800, Linus Torvalds wrote:
> Anyway, all of these issues makes me suspect that the proper blame 
> interface is to basically *hide* the blame almost entirely, in order to 
> make the important parts much more visible, and in order to encourage 
> people to start looking for the piece of code that they are actually 
> interested in.

One approach which might work is where you hover your mouse over a
line, and it pops up a tiny window with the blame information if the
mouse remains stationary for more than a second or two.

Another thing which would be really useful is where the lines that
have been changed in the last n commits (where n is probably between
3-5) are highlighted using different colors.  That way you can see
what was changed recently, which is often what you are most interested
in.  (As in, what changed recently that might have caused this file to
get all screwed up?)

						- Ted
