From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [WISH] git-rerere handling delete/modify conflicts [Was: Re: [GIT
 PULL] ARM irqchip consolidation]
Date: Thu, 17 Nov 2011 20:07:42 +0100
Message-ID: <20111117190742.GV30612@pengutronix.de>
References: <4EC39D44.8000706@arm.com>
 <20111117172319.GX9581@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Zyngier <marc.zyngier@arm.com>, jamie@jamieiles.com,
	linux-arm-kernel@lists.infradead.org,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 20:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR7JN-0002VF-Q2
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 20:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab1KQTHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 14:07:45 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53129 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1KQTHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 14:07:44 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1RR7JH-00054u-Ga; Thu, 17 Nov 2011 20:07:43 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.77)
	(envelope-from <ukl@pengutronix.de>)
	id 1RR7JH-0005hL-0L; Thu, 17 Nov 2011 20:07:43 +0100
Content-Disposition: inline
In-Reply-To: <20111117172319.GX9581@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185605>

On Thu, Nov 17, 2011 at 05:23:19PM +0000, Russell King - ARM Linux wrot=
e:
> On Wed, Nov 16, 2011 at 11:23:48AM +0000, Marc Zyngier wrote:
> > I've collected patches converting GIC and VIC based platforms to us=
e the
> > MULTI_IRQ_HANDLER configuration option in a single branch (as they =
depend
> > on a common patch).
> >=20
> > It also include the patch adding non-banked support to the GIC, whi=
ch is
> > required to convert EXYNOS to MULTI_IRQ_HANDLER in a sane way (not =
to
> > mention fixing obvious bugs).
> >=20
> > If you're happy with this, feel free to pull this branch.
>=20
> We need to sort out the conflicts between this and the arch_reset stu=
ff
> I'm carrying, because I'm not going to fight git from this early in t=
he
> cycle, dealing with stuff like this:
>=20
> CONFLICT (delete/modify): arch/arm/mach-omap2/include/mach/omap4-comm=
on.h deleted in HEAD and modified in devel-stable. Version devel-stable=
 of arch/arm/mach-omap2/include/mach/omap4-common.h left in tree.
>=20
> which is immune to git rerere, and I'm sure as hell not going to keep=
 on
> merging this with my for-next branch.
>=20
> Even though I've split out the conflicting cleanup commits from the
> arch_reset() stuff, many of them still don't have acked-bys from the
> maintainers of the affected code, so I don't feel like I can commit
> them to being stable.
>=20
> What we need are more responsive platform maintainers!
and git rerere handling delete/modify conflicts. I don't know how it
works internally, but I guess it's not trivial? Just in case it is and
the only thing that stops you implementing it is that you don't know
there is a need for it: voil=E0.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
