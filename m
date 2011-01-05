From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [minor BUG] cherry-pick -x doesn't work if a conflict occurs
Date: Wed, 5 Jan 2011 07:50:47 +0100
Message-ID: <20110105065047.GJ25121@pengutronix.de>
References: <20101229141638.GA14865@pengutronix.de> <24C35180-AED6-4848-9F05-908831F911F9@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 07:50:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaNCx-0006y6-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 07:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab1AEGut convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 01:50:49 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34927 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab1AEGus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 01:50:48 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PaNCp-0001h6-NW; Wed, 05 Jan 2011 07:50:47 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PaNCp-0004bE-4r; Wed, 05 Jan 2011 07:50:47 +0100
Content-Disposition: inline
In-Reply-To: <24C35180-AED6-4848-9F05-908831F911F9@dewire.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164553>

On Wed, Jan 05, 2011 at 07:31:05AM +0100, Robin Rosenberg wrote:
>=20
> 29 dec 2010 kl. 15:16 skrev Uwe Kleine-K=F6nig:
>=20
> > Hello,
> >=20
> > when hitting a conflict cherry-pick suggests using
> >=20
> > 	git commit -c $sha1
> >=20
> > but the resulting (suggested) commit log doesn't have the extra
> > reference requested by -x.
> >=20
>=20
> The man page says -x only takes effect when you do not have a conflic=
t, so there
> is no bug.
ah, I wonder if this is intended or just documenting a short-coming :-)

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
