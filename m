From: Jeff King <peff@peff.net>
Subject: Re: [PATCH WIP 0/3] top-level gitignore considered less harmful
Date: Sat, 26 May 2012 17:45:29 -0400
Message-ID: <20120526214529.GA29463@sigill.intra.peff.net>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <CACsJy8Bbn3hSDC_LmFtOXfJZhV9SqStwSSXFwcQLjDyUUAjOpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 23:45:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYOo8-0004cv-U4
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 23:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048Ab2EZVpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 17:45:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56797
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab2EZVpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 17:45:31 -0400
Received: (qmail 24487 invoked by uid 107); 26 May 2012 21:45:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 May 2012 17:45:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 May 2012 17:45:29 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Bbn3hSDC_LmFtOXfJZhV9SqStwSSXFwcQLjDyUUAjOpQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198569>

On Sat, May 26, 2012 at 08:25:54PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Sat, May 26, 2012 at 7:31 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
> > The result is not so impressive (i'm on -O0 though). Old webkit.git=
,
> > before:
>=20
> (it's "git status" by the way)
>=20
> >
> > real =C2=A0 =C2=A00m6.418s
> > user =C2=A0 =C2=A00m5.561s
> > sys =C2=A0 =C2=A0 0m0.827s
> >
> > after:
> >
> > real =C2=A0 =C2=A00m5.262s
> > user =C2=A0 =C2=A00m4.407s
> > sys =C2=A0 =C2=A0 0m0.850s
>=20
> and with your patch to redistribute .gitignore in webkit, so top-leve=
l
> is small again:
>=20
> real    0m4.185s
> user    0m3.271s
> sys     0m0.905s
>=20
> so my numbers look "ok".

Is that last number just with the redistribution, or with the
redistribution _and_ your patch? I'd like to see both to see whether it
is the case that the two optimizations work together for combined
benefit, or if doing one makes the other one pointless.

-Peff
