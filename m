From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the  
 --compose flag
Date: Mon, 10 Nov 2008 13:12:00 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811101303090.30187@maintenance05.msc.mcgregor-surmount.com>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <200811091513.55544.fg@one2team.com> <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site> <7viqqwa6wo.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811091910570.21142@sys-0.hiltweb.site>
 <7vbpwo88gh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-829932302-1226340720=:30187"
Cc: Francis Galiegue <fg@one2team.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzbGP-0007Np-HM
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 19:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbYKJSMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 13:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbYKJSMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 13:12:09 -0500
Received: from mail.gmx.com ([74.208.5.67]:38766 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754555AbYKJSMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 13:12:08 -0500
Received: (qmail invoked by alias); 10 Nov 2008 18:12:05 -0000
Received: from mail.mcgregor-surmount.com [70.61.40.162]
  by mail.gmx.com (mp-us005) with SMTP; 10 Nov 2008 13:12:05 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+kALgemPOkHCZxQVnjYXtZeeeNhZDopfwTJVtLxR
	W72tSSYxN/JCHe
In-Reply-To: <7vbpwo88gh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100540>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-829932302-1226340720=:30187
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 10 Nov 2008, Junio C Hamano wrote:
> Ian Hilt <ian.hilt@gmx.com> writes:
>=20
> > On Sun, 9 Nov 2008, Junio C Hamano wrote:
> >> Ian Hilt <ian.hilt@gmx.com> writes:
> >>=20
> >> > On Sun, 9 Nov 2008, Francis Galiegue wrote:
> >> >> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =C3=A9crit=
=C2=A0:
> >> >> > +=09if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
> >> >>=20
> >> >> Greedy operators are only supported with perl 5.10 or more... I thi=
nk it's a=20
> >> >> bad idea to use them...
> >> ...
> >> You expect something non-blank there anyway, so why not do:
> >>=20
> >> =09To:\s*(\S.*?)\s*\n....
> >
> > That works.  Although, I seem to be missing Francis' point.  According
> > to perlre, a quantified subpattern is "greedy".  So a "greedy operator"
> > is any one of the standard quantified subpatterns.  The "+" and "?"
> > modify its matching behavior.  And it seems to me that it _has_ to use =
a
> > q.s. to work ...
>=20
> The "perlre" documentation you are reading is from Perl 5.10.0; check
> "perldelta" documentation next to it.
>=20
> I think you are wrong in saying that "it _has_ to use".  Yes, you _can_
> use possessive quantifiers to write that pattern (provided if you can
> limit your users to Perl 5.10.0 or later), but you do _not_ have to (and =
I
> just showed you how).  By not using the new feature, you can make it work
> for people with older version of Perl.

Right.  I was saying it has to use quantifiers, in general, not that it
has to use possessive quantifiers.
--8323328-829932302-1226340720=:30187--
