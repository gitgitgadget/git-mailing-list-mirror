From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] [TOPGIT] make creating a commit from a topgit branch a function
Date: Wed, 21 Jan 2009 11:16:44 +0100
Message-ID: <20090121101644.GA19052@pengutronix.de>
References: <1231968443-13960-1-git-send-email-u.kleine-koenig@pengutronix.de> <1231968443-13960-2-git-send-email-u.kleine-koenig@pengutronix.de> <20090121031913.GA7422@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 11:18:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPaAB-0006mf-3p
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 11:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763770AbZAUKQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 05:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764003AbZAUKQv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 05:16:51 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43663 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761107AbZAUKQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 05:16:49 -0500
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LPa8a-0000LE-3q; Wed, 21 Jan 2009 11:16:47 +0100
Content-Disposition: inline
In-Reply-To: <20090121031913.GA7422@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=AWL,BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106588>

On Wed, Jan 21, 2009 at 02:19:13PM +1100, martin f krafft wrote:
> also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009=
=2E01.15.0827 +1100]:
> > This helps avoiding code duplication for the next commit.
>=20
> What's the "next commit"?
oh, sorry.  I intended to post my patch that implements `tg export
--linearize`, but then found a bug and so didn't send it.

You can find it in my pu branch at

	git://git.pengutronix.de/git/ukl/topgit.git pu

=2E  It's not yet ready for general use, but I look forward to any
constructive feedback.

Best regards and thanks for the reminder,
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
Peiner Strasse 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-=
0    |
Amtsgericht Hildesheim, HRA 2686              | Fax:   +49-5121-206917-=
5555 |
