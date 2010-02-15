From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/6] Fix 'git var' usage synopsis
Date: Sun, 14 Feb 2010 23:47:22 -0500
Message-ID: <20100215044722.GC3336@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214115533.GA3499@progeny.tock>
 <20100215023636.GA17444@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 05:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngsrj-0003VI-G1
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 05:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab0BOErS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 23:47:18 -0500
Received: from peff.net ([208.65.91.99]:58411 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840Ab0BOErS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 23:47:18 -0500
Received: (qmail 13169 invoked by uid 107); 15 Feb 2010 04:47:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 23:47:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 23:47:22 -0500
Content-Disposition: inline
In-Reply-To: <20100215023636.GA17444@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139970>

On Sun, Feb 14, 2010 at 08:36:36PM -0600, Jonathan Nieder wrote:

> > --- a/builtin-var.c
> > +++ b/builtin-var.c
> > @@ -6,7 +6,7 @@
> >  #include "cache.h"
> >  #include "exec_cmd.h"
> > =20
> > -static const char var_usage[] =3D "git var [-l | <variable>]";
> > +static const char var_usage[] =3D "git var (-l | <variable>)";
> >  static const char *editor(int flag)
> >  {
>=20
> As Junio noticed, this doesn=E2=80=99t apply.  The problem is a missi=
ng
> blank line between the static const char var_usage and static const
> char *editor lines.  Worse still, I have no clue how it happened.

I think it was a stray deletion in your editor. The patch is actually
corrupt (the hunk claims 7 lines, but contains only 6). And you put tex=
t
after the "---", so presumably you did so with an editor. So I think it
is probably not a bug, but just a weird once-off user error.

Or maybe cosmic rays ate your line feed.

-Peff
