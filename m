From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 3/3] Silence a bunch of format-zero-length warnings
Date: Wed, 7 May 2014 22:05:42 +0200
Message-ID: <20140507200542.GC4013@sandbox-ub>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
 <20140504190121.GP75770@vauxhall.crustytoothpaste.net>
 <20140505052117.GC6569@sigill.intra.peff.net>
 <xmqq4n11bgf6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:05:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi86C-0003z6-N6
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaEGUFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2014 16:05:49 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:49769 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaEGUFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:05:48 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Wi863-0003XC-Mc; Wed, 07 May 2014 22:05:43 +0200
Content-Disposition: inline
In-Reply-To: <xmqq4n11bgf6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248355>

On Wed, May 07, 2014 at 11:19:09AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Sun, May 04, 2014 at 07:01:22PM +0000, brian m. carlson wrote:
> >
> >> On Sun, May 04, 2014 at 01:12:55AM -0500, Felipe Contreras wrote:
> >> > This is in gcc 4.9.0:
> >> >=20
> >> >   wt-status.c: In function =E2=80=98wt_status_print_unmerged_hea=
der=E2=80=99:
> >> >   wt-status.c:191:2: warning: zero-length gnu_printf format stri=
ng [-Wformat-zero-length]
> >> >     status_printf_ln(s, c, "");
> >> >     ^
> >> >=20
> >> > We could pass -Wno-format-zero-length, but it seems compiler-spe=
cific
> >> > flags are frowned upon, so let's just avoid the warning altogeth=
er.
> >>=20
> >> I believe these warnings existed before GCC 4.9 as well, but I'm n=
ot
> >> opposed to the change.
> >
> > Yeah, this started last summer when we added __attribute__((format)=
) to
> > the status_printf_ln calls, and I posted essentially the same patch=
=2E  We
> > kind of waffled between "eh, just set -Wno-format-zero-length" and =
doing
> > something, and ended up at the former. I'd be fine with doing it th=
is
> > way; we're not likely to add a lot of new callsites that would make=
 it a
> > hassle to keep up with.
>=20
> OK, so I'll take it as your Ack ;-)

What happened to this patch? These warnings are still annoying me on my
Ubuntu 14.04.

Cheers Heiko
