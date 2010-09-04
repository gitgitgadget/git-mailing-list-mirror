From: Ted Ts'o <tytso@mit.edu>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 18:47:26 -0400
Message-ID: <20100904224726.GE4887@thunk.org>
References: <7voccezr7m.fsf@alter.siamese.dyndns.org>
 <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
 <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
 <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
 <AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
 <20100904181405.GB4887@thunk.org>
 <m3tym5mfce.fsf@localhost.localdomain>
 <AANLkTimhCi2vWWnHGwT5ToRtFbjkxTgVYVvYLR3UCb2S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 00:47:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os1WI-0006o1-AP
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab0IDWr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 18:47:29 -0400
Received: from THUNK.ORG ([69.25.196.29]:50949 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab0IDWr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:47:28 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Os1WB-00034h-BU; Sat, 04 Sep 2010 18:47:27 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Os1WA-0006fk-Mm; Sat, 04 Sep 2010 18:47:26 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimhCi2vWWnHGwT5ToRtFbjkxTgVYVvYLR3UCb2S@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155383>

On Sat, Sep 04, 2010 at 09:47:19PM +0100, Luke Kenneth Casson Leighton wrote:
> 
> Q: is git a "distributed source control system"?
> A: yeees, but the "distribution" part has to be done the hard way,
>    by setting up servers, forcing developers and users to configure
>    git to use those [single-point-of-failure] servers.  so it's
>    "more correct" to say that git is a "distributable" source control
>    system.

Is typing the command "git daemon" on the command line really that
hard?  For bonus points it could register with Avahi (i.e., the
Zeroconf protocol), which would make it easier to set up adhoc sharing
arrangements.  But if that's your goal, I'd suggest making "git
daemon" simpler to set up --- since it's pretty trivial to set up as
it is.  I'd then suggest adding to "git gui" an option to allow a user
to browse local git servers who have advertised themselves using the
Zeroconf protocol and do a git fetch from the local server.

But if you want to work on peer2peer because it's "cool", feel free.
But I suspect telling people that all if you have to do is run "git
daemon" on one machine, and using "git gui" to browse through the
available git servers on the other machines, it really isn't going to
get any easier....

						- Ted
