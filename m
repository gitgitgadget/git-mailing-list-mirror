From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: linux-next: manual merge of the security-testing tree with the
 tree
Date: Thu, 30 Jun 2011 14:17:10 +0200
Message-ID: <20110630121710.GJ11559@pengutronix.de>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au>
 <20110630072559.GA4048@pengutronix.de>
 <20110630193023.6056d48e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Morris <jmorris@namei.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	Linus <torvalds@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: linux-next-owner@vger.kernel.org Thu Jun 30 14:17:22 2011
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1QcGBI-0001wu-Ia
	for glkn-linux-next@lo.gmane.org; Thu, 30 Jun 2011 14:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab1F3MRP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glkn-linux-next@m.gmane.org>);
	Thu, 30 Jun 2011 08:17:15 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41701 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1F3MRO (ORCPT
	<rfc822;linux-next@vger.kernel.org>); Thu, 30 Jun 2011 08:17:14 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1QcGBE-0008S7-LY; Thu, 30 Jun 2011 14:17:12 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.76)
	(envelope-from <ukl@pengutronix.de>)
	id 1QcGBD-00067V-0p; Thu, 30 Jun 2011 14:17:11 +0200
Content-Disposition: inline
In-Reply-To: <20110630193023.6056d48e.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-next@vger.kernel.org
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176486>

On Thu, Jun 30, 2011 at 07:30:23PM +1000, Stephen Rothwell wrote:
> Hi Uwe,
>=20
> On Thu, 30 Jun 2011 09:25:59 +0200 Uwe Kleine-K=F6nig <u.kleine-koeni=
g@pengutronix.de> wrote:
> >
> > Long history short: James probably used -s ours or similar and it's=
 fine
> > not to merge that commit into next :-)
>=20
> Ah ha!  Thanks for the explanation.  My mind was clearly not up to it
> today. :-)
The uncomfortable issue here is that=20

	git show bcd05ca10420

(or gitk or gitweb or <enteryourfavoritetoolhere>) doesn't indicate tha=
t
it's "strange". The patch shown is simply empty, as it would be if the
tree matched the other parent or if it were a clean merge.

A flag would be nice that does what I did: redo the merge and compare
bcd05ca10420^{tree} with the result?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
