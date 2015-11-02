From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: git filter-branch and merging of signed tags
Date: Mon, 2 Nov 2015 18:13:26 +0100
Message-ID: <20151102171326.GY4931@pengutronix.de>
References: <20151102080428.GO4931@pengutronix.de>
 <56378D6F.8080508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 18:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtIfl-0008D5-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 18:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbbKBRN3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 12:13:29 -0500
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48223 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbbKBRN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 12:13:28 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZtIff-0003TC-2u; Mon, 02 Nov 2015 18:13:27 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.84)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZtIfe-0001JV-Q4; Mon, 02 Nov 2015 18:13:26 +0100
Content-Disposition: inline
In-Reply-To: <56378D6F.8080508@drmicha.warpmail.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280703>

Hello Michael,

On Mon, Nov 02, 2015 at 05:21:03PM +0100, Michael J Gruber wrote:
> Uwe Kleine-K=F6nig venit, vidit, dixit 02.11.2015 09:04:
> > 	~/gsrc/linux$ git version
> > 	git version 2.6.1
>=20
> Does your git include
> a5a4b3f (filter-branch: remove multi-line headers in msg filter,
> 2015-10-08)? That takes care of the incomplete header tag parsing.
No, it does not. Thanks for the hint.

> Should be in master by now, I think.
>=20
> Keeping the mergetag signature would require some extra logic in
> filter-branch.
that I'd like to have :-). It seems I have to dig into that myself. (If
someone is quicker than me, I promise not to be angry :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
