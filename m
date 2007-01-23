From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack
 without exploding
Date: Tue, 23 Jan 2007 17:43:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231738460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701230809440.32200@woody.linux-foundation.org>
 <87sle17lnm.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-414557693-1169570620=:22628"
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jan 23 17:43:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9OkO-0004lP-V5
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbXAWQnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 11:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932954AbXAWQnp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:43:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:46930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932905AbXAWQno (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:43:44 -0500
Received: (qmail invoked by alias); 23 Jan 2007 16:43:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 23 Jan 2007 17:43:42 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <87sle17lnm.fsf@morpheus.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37549>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-414557693-1169570620=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

[Re-Cc'ing Linus]

On Tue, 23 Jan 2007, David Kågedal wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Tue, 23 Jan 2007, Johannes Schindelin wrote:
> >> 
> >> P.S.: These patches make me dream of yet another diff format enhancement: 
> >> code moves!
> >
> > It's basically impossible.
> >
> > Why? You need the context. 
> 
> Yes, I think that a diff format for code moves wouldn't be useful.
> What could potentially be useful is a graphical diff browser that can
> e.g.  show two versions side-by-side and show code moves in that.  I
> have a vague memory that the ClearCase merge tool did that.

I don't need no steenking graphical tools. I want to read me mailing list, 
that's it.

> But as long as the code moves are within a single file, that merge tool 
> could derive that move from an ordinary diff.

Actually, you could even derive a code movement between files from the set 
of diffs. Though not code copies. But then, we don't do code copies.

Seriously again, your comment got me thinking: it could actually make 
sense to include the information of code moves and code copies (for easier 
review) in the "@@ .. @@" lines (or before them, if git apply does not 
choke on inserting garbage lines before them).

But maybe it is not that good after all: if you review code, you should 
inspect it (even if it was only moved), since it might have all kinds of 
side effects, or you might have missed some other aspect before.

Ciao,
Dscho

---1148973799-414557693-1169570620=:22628--
