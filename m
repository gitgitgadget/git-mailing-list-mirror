From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: gitweb: cloud tags feature produces malformed XML for errors
Date: Wed, 2 Mar 2011 09:45:28 +0100
Message-ID: <20110302084528.GB22310@pengutronix.de>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
 <20110301222141.GB7918@elie>
 <201103020105.04440.jnareb@gmail.com>
 <201103020924.32924.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	admin@repo.or.cz, John Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puhgh-0000nv-SP
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 09:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab1CBIpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 03:45:34 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55058 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab1CBIpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 03:45:34 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuhgY-0005jR-8P; Wed, 02 Mar 2011 09:45:30 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuhgW-0000gC-J7; Wed, 02 Mar 2011 09:45:28 +0100
Content-Disposition: inline
In-Reply-To: <201103020924.32924.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168300>

On Wed, Mar 02, 2011 at 09:24:28AM +0100, Jakub Narebski wrote:
> On Wed, 2 Mar 2011, Jakub Narebski wrote:
> > On Tue, 1 Mar 2011, Jonathan Nieder wrote:
> > > Uwe Kleine-K=F6nig wrote [1]:
> > > [1] http://bugs.debian.org/616005
> >=20
> > > > I experiment with $feature{'ctags'}.  After installing
> > > > libhtml-tagcloud-perl (0.34-1) and adding
> > > >
> > > >	$feature{'ctags'}{'default'} =3D [1];
>=20
> This is also invalid... but this one actually is described:
>=20
>  # gitweb by itself can show existing tags, but it does not handle
>  # tagging itself; you need an external application for that.
>  # For an example script, check Girocco's cgi/tagproj.cgi.
>  # You may want to install the HTML::TagCloud Perl module to get
>  # a pretty tag cloud instead of just a list of tags.
>=20
>  # To enable system wide have in $GITWEB_CONFIG
>  # $feature{'ctags'}{'default'} =3D ['path_to_tag_script'];
>  # Project specific override is not supported.
>=20
> Using "$feature{'ctags'}{'default'} =3D [1];" would lead to errors wh=
en=20
> you would want to create a tag from web interface.
Yeah, I was aware of that (but of course I should have written that).  =
I
also tried ... =3D ['/bin/sh'] and a few others.  Obviously this is
pre-production :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
