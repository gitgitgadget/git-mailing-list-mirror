From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] get_remote_url(): use the same data source as
 ls-remote to get remote urls
Date: Tue, 1 Mar 2011 09:41:10 +0100
Message-ID: <20110301084110.GT22310@pengutronix.de>
References: <20110114090645.GA13060@pengutronix.de>
 <1298885779-10045-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <7v4o7nhgr1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:41:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuL90-000076-QD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 09:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab1CAIlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 03:41:17 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47832 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab1CAIlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 03:41:17 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuL8q-0004lZ-Jl; Tue, 01 Mar 2011 09:41:12 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuL8o-0008Ce-O9; Tue, 01 Mar 2011 09:41:10 +0100
Content-Disposition: inline
In-Reply-To: <7v4o7nhgr1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168191>

On Mon, Feb 28, 2011 at 03:38:26PM -0800, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
>=20
> > with this patch git-request-pull.sh (=3D=3D the only in-tree user o=
f
> > git-parse-remote.sh:get_remote_url()) could directly use
> >
> > 	git ls-remote --get-url
> >
> > .  I guess you wouldn't want to remove git-parse-remote.sh:get_remo=
te_url()
> > though?!
>=20
> If nobody uses it, why not?  I was actually hoping for the day that n=
obody
> uses any of the defined function so taht we can remove that whole fil=
e.
Ok for me.  Probably I'm a bit conservative here because I usually work
on the kernel and people are picky here to remove interfaces.

I can followup with a patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
