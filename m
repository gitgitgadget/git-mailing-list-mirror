From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Tue, 5 Oct 2010 09:01:13 +0200
Message-ID: <20101005070113.GE11737@pengutronix.de>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de> <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com> <1285967766.6750.2.camel@gandalf.stny.rr.com> <4CA9815D.3040801@drmicha.warpmail.net> <20101004075015.GN28679@pengutronix.de> <4CA98EF1.1050102@drmicha.warpmail.net> <20101004085050.GQ28679@pengutronix.de> <4CA99E43.1000204@drmicha.warpmail.net> <7vlj6d988o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 09:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P31Wo-0006bD-1T
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469Ab0JEHBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 03:01:23 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54700 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272Ab0JEHBW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 03:01:22 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31WW-0004k2-Hs; Tue, 05 Oct 2010 09:01:16 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31WT-0007PJ-MI; Tue, 05 Oct 2010 09:01:13 +0200
Content-Disposition: inline
In-Reply-To: <7vlj6d988o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158165>

Hi Junio,

On Mon, Oct 04, 2010 at 10:29:43AM -0700, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>=20
> >> I choosed to write "overwritten" instead of "updated" to make it c=
learer
> >> that it makes no sence to push into these branches from a differen=
t
> >> source.  Should this be noted more explicit?
> >
> > "update" may be more Git lingo but I think either is fine. "overwri=
tten"
> > makes it clearer this is not a repo to do development in...
>=20
> In a repository with remote.origin.mirror set to true, "git fetch ori=
gin"
> does not seem to prune a ref that has been removed from the origin.  =
I
> think that is a design bug, albeit a minor one ("git fetch -p origin"=
 can
> fix, but "-p" should not be necessary).  A "mirror"'s purpose is to, =
ehh,
> mirror a remote so that local people can share it as a nearby copy.
>=20
> A wording that also implies this automatic deletion of a stale ref wo=
uld
> be nice; "overwritten" does not exactly sound like that, though.
So you intend to change git fetch origin to remove stale refs, right?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
