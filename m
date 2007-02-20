From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Tue, 20 Feb 2007 01:53:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702200152230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
 <7vps854qf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:53:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJFr-0001K5-19
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965831AbXBTAxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965832AbXBTAxK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:53:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:55098 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965831AbXBTAxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:53:07 -0500
Received: (qmail invoked by alias); 20 Feb 2007 00:53:06 -0000
X-Provags-ID: V01U2FsdGVkX1+9nyNZea69uxWkyUOslkTVd6BfLbs9AgebnkAf7Q
	w3vg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vps854qf8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40187>

Hi,

On Mon, 19 Feb 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > I agree that it is sensible, but it's sensible only within the context of 
> > purely self-generated patches, where the patch itself was generated not 
> > just with git, but with that exact project.
> 
> That makes sense, except that the patch could be made with any
> other tools; it just has to follow the "patch is from the top of
> the tree, with -p1" convention.
> 
> I think it might make sense to change (this might have to be
> read "break", unfortunately) "git apply" for all three cases.

Just for the subdirectory case.

> So the new rule, which would affect only when you run from a 
> subdirectory, would be that "diff -u a/foo b/foo" would be parsed, 1 
> level (or -p <n> levels) of leading paths stripped, and then prefix is 
> added to form "new" and "old" filenames.

Wouldn't it be easier to just cd to the prefix?

> And I think Johannes is happy with that change as well.

Yes, thank you.

Ciao,
Dscho
