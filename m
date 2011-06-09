From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] clone: accept config options on the command line
Date: Thu, 9 Jun 2011 13:12:14 -0400
Message-ID: <20110609171214.GA30888@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
 <20110609155740.GJ25507@sigill.intra.peff.net>
 <BANLkTinBqSVpREg6667Ydf2JjL3r14BgRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUimS-0007qa-Hs
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778Ab1FIRMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 13:12:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab1FIRMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:12:17 -0400
Received: (qmail 16599 invoked by uid 107); 9 Jun 2011 17:12:25 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 13:12:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 13:12:14 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinBqSVpREg6667Ydf2JjL3r14BgRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175553>

On Thu, Jun 09, 2011 at 07:10:33PM +0200, Bert Wesarg wrote:

> On Thu, Jun 9, 2011 at 17:57, Jeff King <peff@peff.net> wrote:
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.=
txt
> > index b093e45..3e24064 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -159,6 +159,15 @@ objects from the source repository into a pack=
 in the cloned repository.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the directory from which templat=
es will be used;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0(See the "TEMPLATE DIRECTORY" section of=
 linkgit:git-init[1].)
> >
> > +--config <key>=3D<value>::
> > +-c <key>=3D<value>::
> > + =C2=A0 =C2=A0 =C2=A0 Set a configuration variable in the newly-cl=
oned repository. The
>=20
> Shouldn't this be 'newly-created repository', because the
> configuration variables are set before the actual cloning, but after
> initializing the new repository.

Yeah, I think your wording is better. It might also make sense to
explicitly say that the config takes effect during the fetch and
checkout phases of the clone (there's otherwise no point, of course, bu=
t
it never hurts to make the documentation clear).

-Peff
