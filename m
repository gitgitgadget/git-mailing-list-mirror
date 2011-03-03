From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: gitweb: cloud tags feature produces malformed XML for errors
Date: Thu, 3 Mar 2011 09:19:04 +0100
Message-ID: <20110303081904.GM22310@pengutronix.de>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
 <201103022218.46640.jnareb@gmail.com>
 <20110302215556.GL22310@pengutronix.de>
 <201103030142.17258.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 09:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv3lk-0000q1-5p
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 09:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237Ab1CCIUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 03:20:04 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33353 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab1CCIUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 03:20:00 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pv3kz-0002I3-OW; Thu, 03 Mar 2011 09:19:33 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pv3kW-0004DA-7q; Thu, 03 Mar 2011 09:19:04 +0100
Content-Disposition: inline
In-Reply-To: <201103030142.17258.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168379>

Hello Jakub,

On Thu, Mar 03, 2011 at 01:42:15AM +0100, Jakub Narebski wrote:
> On Wed, 2 Mar 2011, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 02, 2011 at 10:18:44PM +0100, Jakub Narebski wrote:
>=20
> > > What is most important that makes this feature to be considered f=
or
> > > removal (or rehauling) is that only half of this feature is imple=
mented
> > > in gitweb: the displaying part.  There is half-attempt of providi=
ng
> > > some web interface for managing tags... which needs external scri=
pt with
> > > strict coupling, doesn't offer any access control as far as I kno=
w, do
> > > not allow deleting tags, etc.
> >
> > For a small set of repositories the need to hand-edit the tags is O=
K
> > IMHO.  That's what I intended to do.
>=20
> So what would you like to see?
>=20
> 1. Hardening parsing of ctags files, so that gitweb does not crash on
>    malformed entries, but e.g. just ignores them.
>=20
> 2. Generating tag cloud upfront, before sending any output to browser=
,
>    to catch error better (and perhaps separate CSS for HTML::TagCloud=
).
>=20
> 3. Describe format of ctags files, either in comments in code, or in
>    gitweb/README.
>=20
> 4. Either:
>=20
>    A. Remove editing ctags from gitweb, or
>    B. Add some simple generation of ctags file to gitweb
>=20
yes :-)  (1-3, 4a)  I wouldn't mind 4b, but it should be possible to
disable the possibility to publically edit tags via gitweb.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
