From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 3/3] git-rebase--interactive.sh: Make 3-way merge
	strategies work for -p.
Date: Wed, 31 Oct 2007 03:53:20 +0100
Message-ID: <20071031025320.GA1375@atjola.homenet>
References: <1193797232-1062-1-git-send-email-B.Steinbrink@gmx.de> <1193797232-1062-2-git-send-email-B.Steinbrink@gmx.de> <1193797232-1062-3-git-send-email-B.Steinbrink@gmx.de> <Pine.LNX.4.64.0710310239100.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3i8-0005r4-OO
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 03:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbXJaCxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Oct 2007 22:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbXJaCxY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 22:53:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:39869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752081AbXJaCxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 22:53:23 -0400
Received: (qmail invoked by alias); 31 Oct 2007 02:53:21 -0000
Received: from i577B89A4.versanet.de (EHLO localhost) [87.123.137.164]
  by mail.gmx.net (mp047) with SMTP; 31 Oct 2007 03:53:21 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX188e01RNME8D0HU80VIRQWsscOdFFsRo07PUEOWMj
	eA3bsNz9LNFXpH
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710310239100.4362@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62786>

Hi Dscho,

On 2007.10.31 02:42:03 +0000, Johannes Schindelin wrote:
> Hi Bj=F6rn,
>=20
> On Wed, 31 Oct 2007, Bj=F6rn Steinbrink wrote:
>=20
> > +			new_parents=3D${new_parents# $first_parent}
>=20
> I wanted to comment that this might not be present in shells other th=
an=20
> bash, but I see that we rely on that construct already in am, clone,=20
> commit, filter-branch, merge, pull, rebase, stash and submodule.
>
> So I think it's okay.

Actually, I checked first that it's not bash-only (I saw the flames
about that on lkml some time ago, so I've been scared ;-)). Works fine
with dash here and it's in the posix sh specs. See 2.6.2 in
http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html

So I hope that there's a bit of a broader support for it :-)

> The whole series is _very_ nicely done, and appears to me as obviousl=
y=20
> correct.

Thanks :-)

Bj=F6rn
