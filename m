From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Fri, 01 Oct 2010 17:16:06 -0400
Message-ID: <1285967766.6750.2.camel@gandalf.stny.rr.com>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Darren Hart <darren@dvhart.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 23:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1mxl-00050o-RI
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 23:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484Ab0JAVQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 17:16:10 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:53087 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab0JAVQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 17:16:09 -0400
X-Authority-Analysis: v=1.1 cv=QISHQ+x4xS+apxgDHgAvNvlUjyrXCzYsHvuXcbPYiKg= c=1 sm=0 a=7BCCabjZZQgA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=vA1A1dOfAAAA:8 a=meVymXHHAAAA:8 a=Jly3R9Wl-cQvOvWGTpsA:9 a=OoeM3jIJCIgPp1yq7_hT8G9Rg5YA:4 a=PUjeQqilurYA:10 a=XNN-oNMjSfgA:10 a=mAV_wwoo0HwA:10 a=jeBq3FmKZ4MA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:56475] helo=[192.168.23.10])
	by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id A3/B0-11377-79F46AC4; Fri, 01 Oct 2010 21:16:08 +0000
In-Reply-To: <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com>
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157785>

On Fri, 2010-10-01 at 13:18 -0700, Darren Hart wrote:
> 2010/10/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > Some people in #linux-rt claimed that you cannot define "--mirror" =
with
> > "mirror".
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Acked-by: Darren 'Some People' Hart <darren@dvhart.com>

  Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

>=20
> > ---
> >  Documentation/git-clone.txt |   11 ++++++++++-
> >  1 files changed, 10 insertions(+), 1 deletions(-)
> >
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.=
txt
> > index dc7d3d1..5eedfbd 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -128,7 +128,16 @@ objects from the source repository into a pack=
 in the cloned repository.
> >        configuration variables are created.
> >
> >  --mirror::
> > -       Set up a mirror of the remote repository.  This implies `--=
bare`.
> > +       Set up a mirror of the remote repository.
> > +       Using
> > +
> > +               git remote update origin
> > +
> > +       (or `<name>` instead of `origin` if -o is given) in the res=
ulting
> > +       repository overwrites the local branches without asking.
> > +       This implies `--bare`.
> > +       Without --mirror (but with --bare) git remote update doesn'=
t touch any
> > +       branches at all.
> >
> >  --origin <name>::
> >  -o <name>::
> > --
> > 1.7.2.3
> >
> >
>=20
>=20
>=20
