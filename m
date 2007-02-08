From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Correct some language in fast-import documentation.
Date: Thu, 8 Feb 2007 13:32:44 -0500
Message-ID: <20070208183243.GA30673@spearce.org>
References: <20070208075851.GB3950@spearce.org> <20070208082850.GA4334@informatik.uni-freiburg.de> <7vveidyqw5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 19:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFE59-0003ZI-CS
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 19:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbXBHScv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 13:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbXBHScv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 13:32:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55362 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbXBHScu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 13:32:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFE4V-0001kE-8o; Thu, 08 Feb 2007 13:32:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2CE4C20FBAE; Thu,  8 Feb 2007 13:32:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vveidyqw5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39069>

Junio C Hamano <junkio@cox.net> wrote:
> Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:
>=20
> > Shawn O. Pearce wrote:
> >> Minor documentation improvements, as suggested on the Git mailing
> >> list by Horst H. von Brand and Karl Hasselstr~A(P)m.
> > you have an encoding problem here     ---------^
> >
> > That "o umlaut" seems to be UTF-8 encoded, but the headers of you m=
ail
> > claim iso-8859-1.
>=20
> I noticed it, too.  This seems to be purely between the
> format-patch output and the mailing list.  In Shawn's tree, the
> corresponding commit f842fdb0 does not have the encoding
> problem.

Yes, correct.  I took great care to copy Uwe's name from a prior
commit of his in git.git, to make sure I got it spelled correctly
in the commit message.  :)

Unfortunately mutt set the wrong charset on the message.
Uwe thoughtly sent some notes on how to correct that, so I'll try
to fix my mutt.
=20
> As Shawn's tree currently has only these two commits on top of
> what my tree already has, I do not mind pulling from it.  It
> would make life easier for people who are following his tree.

Those are built upon a commit you already merged, but not the tip
of `master` at the time they were written (kernel.org mirror lag
strikes again).  Please feel free to rebase them into the current
tip of master (instead of merging them in) if you want.

--=20
Shawn.
