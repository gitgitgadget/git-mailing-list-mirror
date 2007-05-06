From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 12:19:53 +0200
Message-ID: <20070506101953.GA17498@diana.vm.bytemark.co.uk>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 06 12:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkdqe-0004eK-6L
	for gcvg-git@gmane.org; Sun, 06 May 2007 12:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933571AbXEFKUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 06:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933590AbXEFKUI
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 06:20:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1939 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933571AbXEFKUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 06:20:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkdqL-0004ca-00; Sun, 06 May 2007 11:19:53 +0100
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46323>

On 2007-05-05 10:26:12 -0700, Linus Torvalds wrote:

> The "-S" thing doesn't really interact well with "gitk", because it
> doesn't rewrite the parent information (it is basically just a "hide
> commits that don't pass this criteria"). As such, gitk, which
> requires parent information to generate the graph, is not very
> amenable to using "-S" and such.
>
> That said, you can apply this fairly trivial patch to "gitk" to make
> it parse the output of "git log" rather than "git rev-list", and
> that will actually get you working -S'xyz' parsing automatically.
> It's just that the commit history window will look like crap.

OK, now I've tested it, and just as you said, it works (and is _very_
useful) but looks like crap. :-)

Is there any fundamental reason why

  gitk -- some/path/name

generates a nice, connected graph, while

  gitk -S'some string'

generates disconnected spaghetti? Or could the latter be made to use
the same parent-rewriting logic as the first?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
