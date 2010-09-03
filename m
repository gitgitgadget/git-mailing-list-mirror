From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c
Date: Fri, 3 Sep 2010 20:23:23 +0200
Message-ID: <20100903182323.GA17152@pengutronix.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com> <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	git@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
X-From: linux-sh-owner@vger.kernel.org Fri Sep 03 20:23:27 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1Orav8-0003Np-7j
	for glps-linuxsh-dev@lo.gmane.org; Fri, 03 Sep 2010 20:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab0ICSXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glps-linuxsh-dev@m.gmane.org>);
	Fri, 3 Sep 2010 14:23:25 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33434 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab0ICSXZ (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Fri, 3 Sep 2010 14:23:25 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1Orav5-0002Zt-IS; Fri, 03 Sep 2010 20:23:23 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Orav5-0005S4-Cs; Fri, 03 Sep 2010 20:23:23 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155259>

Hello,

[added git ML to Cc:]

On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
> On Thu, Sep 2, 2010 at 10:39 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > factorise some generic infrastructure to assist looking up struct c=
lks
> > for the ARM & SH architecture.
> >
> > as the code is identical at 99%
> >
> > put the arch specific code for allocation as example in asm/clkdev.=
h
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.=
com>
> > ---
> > v3:
> > =A0 =A0 =A0 =A0wrong comment removed
> > =A0 =A0 =A0 =A0headers fixed
>=20
> [snip]
>=20
> I can't apply this patch using GNU patch. I've tested 2.5.9 and 2.6.1
> from Gentoo.
>=20
> Using --dry-run is fine, but omitting dry-run gives me:
>=20
> ...
> patching file arch/arm/common/clkdev.c
> patching file arch/sh/include/asm/clkdev.h
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 11.
> 2 out of 2 hunks FAILED -- saving rejects to file
> arch/sh/include/asm/clkdev.h.rej
>=20
> I guess this is caused by the last "renaming" hunk, see below.
>=20
> I thought these things were supposed to work out of the box...
Yes, they work out of the box, but only for people using git :-)

Maybe git-apply can be used instead of patch?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
