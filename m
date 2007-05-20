From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit ID in exported Tar Ball
Date: Sat, 19 May 2007 23:57:52 -0400
Message-ID: <20070520035752.GG3141@spearce.org>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 05:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpcYi-0002Bo-FB
	for gcvg-git@gmane.org; Sun, 20 May 2007 05:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390AbXETD6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 23:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758190AbXETD6M
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 23:58:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54303 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618AbXETD6L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 23:58:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HpcYA-0002zO-K6; Sat, 19 May 2007 23:57:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F26B220FBAE; Sat, 19 May 2007 23:57:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd50wv88t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47795>

Junio C Hamano <junkio@cox.net> wrote:
> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> > Something like the following patch?  Since we're already embedding =
the
> > commit ID in a comment, we might as well offer creating a synthetic=
 file
> > for it, too, if that solves a user's problem that might be difficul=
t to
> > work around otherwise.

What about being able to get the output of git-describe embedded
into an archive file?  Doesn't git.git do that in its Makefile?  ;-)

git-describe is more human-friendly than a SHA-1...

--=20
Shawn.
