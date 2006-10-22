From: Theodore Tso <tytso@mit.edu>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 21:00:10 -0400
Message-ID: <20061022010010.GB9082@thunk.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610211655130.3962@g5.osdl.org> <845b6e870610211713m413afd28tcdf24934df25d3f5@mail.gmail.com> <200610220222.29009.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik =?iso-8859-1?Q?B=E5gfors?= <zindar@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Sean <seanlkml@sympatico.ca>, Jan Hudec <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 22 03:00:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbRhb-0008Q4-VE
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 03:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422912AbWJVBAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 21:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422919AbWJVBAc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 21:00:32 -0400
Received: from thunk.org ([69.25.196.29]:6634 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422912AbWJVBAb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 21:00:31 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1GbRkA-0007j1-Od; Sat, 21 Oct 2006 21:03:15 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1GbRhC-0001aT-9J; Sat, 21 Oct 2006 21:00:10 -0400
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610220222.29009.jnareb@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29701>

On Sun, Oct 22, 2006 at 02:22:28AM +0200, Jakub Narebski wrote:
> If I understand correctly bzr came to life much earlier than Monotone,
> Mercurial and Git but it was in beta stages very long. Bazaar-NG
> "repositories" to group bunch of "branches" seems inspoted by hg or git.
> Git (and probably Mercurial) was inspired both by BitKeeper and Monotone.
> Monotone started to be reasonable fast around time when Git and Mercurial
> came to be.

Yes, bzr predates Mercurial and Git; I remember talking to Martin Pool
about Bazaar-BG at the the 2005 Linux.conf.au, which was before the BK
turnoff.  At the time, I had considered using bzr-ng (which has since
been renamed bzr), but it didn't have branch functionality at that
point if I remember correctly.  Both git and Mercurial started
development at almost the same time right after the Larry McVoy
announced the pending withdrawal of the BitKeeper no-cost license.   

About one month after the announced BK turnoff date, I looked at the
various options for transitioning e2fsprogs, and at that point
Mercurial was **substantially** faster than bzr, and I believe
slightly ahead in features.  I also looked at git, but at that point
Hg was easier to learn how to use, and I figured for a project the
size of e2fsprogs, I didn't need the power of git, so I decided in
favor of Mercurial because it looked like it would be easier for
people to learn how to use it.

I think it's fair to say that the exchange in ideas have profited all
three projects, and that the different projects have different
strengths,   

						- Ted
