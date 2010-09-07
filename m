From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: gitweb not friendly to firefox revived
Date: Tue, 7 Sep 2010 10:22:53 +0200
Message-ID: <20100907082253.GA16198@pengutronix.de>
References: <20100801195138.GA1980@pengutronix.de> <4C6670EE.3060806@gmail.com> <AANLkTimR9Wkz+YOchyjvO8fgAwk5YsGtcpMOpyZY4Fjv@mail.gmail.com> <201008141433.35451.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	kernel@pengutronix.de
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 10:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OstSQ-0007Y9-Mq
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 10:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab0IGIXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 04:23:05 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46538 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab0IGIXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 04:23:01 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OstS9-0004KH-Gp; Tue, 07 Sep 2010 10:22:53 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OstS9-0004Ig-5B; Tue, 07 Sep 2010 10:22:53 +0200
Content-Disposition: inline
In-Reply-To: <201008141433.35451.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155686>

Hello,

just to stop this topic dying ...

On Sat, Aug 14, 2010 at 02:33:33PM +0200, Jakub Narebski wrote:
> On Sat, 14 Aug 2010, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> > 2010/8/14 Stephen Boyd <bebarino@gmail.com>:
> >> =A0On 08/03/2010 02:50 PM, Jakub Narebski wrote:
> >>>
> >>> +
> >>> + =A0 =A0 =A0 my $title =3D to_utf8("Search for commits $performe=
d by $author");
> >>> + =A0 =A0 =A0 $title =3D~ s/[[:cntrl:]]/?/g;
> >>> +
> >>>
> >>
> >> Isn't it possible that other data coming from git could have escap=
e
> >> characters in them such as the commit subject line? In which case =
this same
> >> bug would occur?
> >>
> >> Therefore isn't it better to strip out control characters (that's =
what this
> >> patch is doing right?) in esc_html?
> >=20
> > I don't think stripping them out is the right thing either, hiding
> > from you that something is Really Wrong (binary garbage in patches)
> > isn't good.
> >=20
> > Something like this would be better:
> >=20
> >     s/([[:cntrl:]])/sprintf("\\%03x", ord $1)/ge
>=20
> Or=20
>       s|([[:cntrl:]])|quot_cec($1)|eg;
>=20
> But is it worth it?  This is about _title_ attribute, shown only on=20
> mouseover (mouse hover).
>=20
>=20
> But perhaps it would be worth it to add 'prep_attr' and 'esc_attr'
> functions, though esc_html can be used in those places where esc_attr
> would be needed...
Is there something I can do to bring this forward?  (I assume this isn'=
t
fixed yet, at least it isn't in Debian's 1.7.2.3 package.)

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
