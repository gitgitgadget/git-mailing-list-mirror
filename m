From: Ted Ts'o <tytso@mit.edu>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 18:41:39 -0400
Message-ID: <20100904224139.GD4887@thunk.org>
References: <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org>
 <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
 <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
 <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
 <AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
 <20100904181405.GB4887@thunk.org>
 <AANLkTikAfSrfKRaK3ozXV_eT6Rd-VRbXQUQLk3SY8QnJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 00:42:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os1Qy-0004ua-08
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab0IDWlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:41:44 -0400
Received: from THUNK.ORG ([69.25.196.29]:39710 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096Ab0IDWlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:41:44 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Os1Qa-00033m-Eg; Sat, 04 Sep 2010 18:41:40 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Os1QZ-0006Ru-Mz; Sat, 04 Sep 2010 18:41:39 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikAfSrfKRaK3ozXV_eT6Rd-VRbXQUQLk3SY8QnJ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155381>

On Sat, Sep 04, 2010 at 09:00:56PM +0100, Luke Kenneth Casson Leighton =
wrote:
> > Which brings me back to my original question --- what problem exact=
ly
> > are you trying to solve? =A0What's the scenario?
>=20
> i described those in prior messages.  to summarise: they're basically
> reduction of dependence on centralised infrastructure, and to allow
> developers to carry on doing code-sprints using bugtrackers, wikis an=
d
> anything else that can be "git-able" as its back-end, _even_ in the
> cases where there is little or absolutely no bandwidth... and _still_
> sync up globally once any one of the developers gets back online.

So at all of the code sprints I've been at, the developers all have
locally very good bandwidth between each other.  And if they don't
have wifi, what *will* they have?  In the example you gave, you never
were able to bring up a local area network, because you had one or two
lamers who couldn't even do wifi in adhoc mode.  Hell, even if you had
to hook up someone's laptop using an RS-232 line and PPP, that would
be plenty of bandwidth for git.  So you weren't specific enough in
your scenario.  How could it happen?  And is it really all that realist=
ic?

Even if it did, it wouldn't be hard to just set up a git server on one
of the laptop.  What makes peer2peer so critically important in this
use case?  (And no, carrier pigeons are not particularly realistic for
a code sprint....)

							- Ted
