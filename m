From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 0/8] use "git diff" in the test suite
Date: Mon, 26 Feb 2007 00:19:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702260015560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252329550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vps7xrfxa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 00:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLSf7-0006Iv-DA
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 00:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbXBYXT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 18:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbXBYXTz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 18:19:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:45991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965243AbXBYXTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 18:19:53 -0500
Received: (qmail invoked by alias); 25 Feb 2007 23:19:52 -0000
X-Provags-ID: V01U2FsdGVkX1/juRwKV+Djmci6KgDudo9Nup3qOyLa94G38tm411
	xbjg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vps7xrfxa.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40595>

Hi,

On Sun, 25 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now that --no-index is supported by git's diff, we can use much of the 
> > test suite to do the job, instead of relying on GNU diff.
> >
> > This is a bit work-in-progress, since the handling of "-" as a 
> > filename is not fleshed out yet, and we really should have the 
> > "--quiet" option. But I got side-tracked by the edit-patch-series 
> > script, and did not want to hold these patches off any longer.
> 
> As you said yourself [6/8], [7/8], and [8/8] are mechanical conversions, 
> and I do not think it is too much effort involved on your side to "hold 
> these patches off".
> 
> My preference is to apply [1/8] now, cook the result in 'next' for a few 
> days longer to see if anybody complains or finds glitches in the diff-ni 
> series so far, push it out to 'master' and then apply [2/8] and [3/8] 
> while on 'master'.  The remainder would be forked into a topic branch 
> and cooked in 'pu' and then 'next' as usual.

I fully agree.

BTW I think that using 020600 as mode for "-" when it means stdin would 
fix [4/8]...

> Also I do not think we would necessarily want [7/8] and [8/8]. It would 
> help with tests on broken distributions whose 'cmp' misbehaves when the 
> output is redirected to /dev/null, but I do not think it is a good 
> enough reason to make the tests slower.

I think with the upcoming "--quiet", which exits early on error, 
performance should be about par. Actually, I went off in this direction 
because I still use an OpenSUSE 10.1 install DVD, which has this broken 
cmp...

But I do not care deeply. (It was a good test case for diff-ni, though...)

Ciao,
Dscho
