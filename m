From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [offtopic?] xdelta patch format wrapper
Date: Wed, 13 Feb 2008 11:33:51 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131128040.30505@racer.site>
References: <47B24D8A.5090703@catalyst.net.nz> <7vy79py1it.fsf@gitster.siamese.dyndns.org> <47B26830.6090501@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jmacd@cs.berkeley.edu
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Feb 13 12:34:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFsd-0002hA-Ro
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 12:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390AbYBMLdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 06:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756940AbYBMLdr
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 06:33:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:48683 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756245AbYBMLdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 06:33:46 -0500
Received: (qmail invoked by alias); 13 Feb 2008 11:33:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 13 Feb 2008 12:33:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IjJt8V8yI+GWuK2zZIdG/NX9FD7SRvVhKPPGjCi
	OLCMMkZn5aQB2p
X-X-Sender: gene099@racer.site
In-Reply-To: <47B26830.6090501@catalyst.net.nz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73777>

Hi,

On Wed, 13 Feb 2008, Martin Langhoff wrote:

> I don't think I'll use *any* git code at all for the time being. If it
> was trivial to produce a statically compiled git-diff.exe and
> git-apply-patch.exe that work without funny dependencies on any windows
> box then I would.

It is trivial.

Except that we do not have any git-apply-patch.exe.  Maybe you meant 
git-apply.exe?

> Don't think any of the windows ports of git are there (even though they 
> are excellent!).

How can you say that they are excellent, and then say they are not there 
yet?

FWIW I just checked.  In msysGit, git-apply.exe and git-diff.exe are 
identical (no mystery there: they are both builtins), and weigh in with 
2893142 bytes.

If you're serious about wanting something reliable, quick, but smaller 
than that, it should be _trivial_ to cut down.  For example, a simple 
"strip git-diff.exe" brings it down to 821248 bytes.

And that's without removing all the other builtins, which would be 
trivial, too (just cull "struct cmd_struct commands" in git.c, and 
"BUILT_INS" and "BUILTIN_OBJS" in the Makefile).

Hth,
Dscho
