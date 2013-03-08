From: Jeff King <peff@peff.net>
Subject: Re: git-scm.com/book/ru -- incorrect "next" link containing a
 question mark
Date: Fri, 8 Mar 2013 05:40:20 -0500
Message-ID: <20130308104019.GA16068@sigill.intra.peff.net>
References: <5fe58162-33ed-48c2-a095-e98a355ed4f6@googlegroups.com>
 <20130307124736.3d738c5aab39345fa9ca2930@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-users@googlegroups.com, Aleksey Rozhkov <ekkertan@gmail.com>,
	git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Fri Mar 08 11:40:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDujM-0007LU-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 11:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab3CHKk0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 05:40:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40830 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab3CHKkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 05:40:25 -0500
Received: (qmail 15561 invoked by uid 107); 8 Mar 2013 10:42:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 05:42:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 05:40:20 -0500
Content-Disposition: inline
In-Reply-To: <20130307124736.3d738c5aab39345fa9ca2930@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217658>

On Thu, Mar 07, 2013 at 12:47:36PM +0400, Konstantin Khomoutov wrote:

> On Thu, 7 Mar 2013 00:01:31 -0800 (PST)
> Aleksey Rozhkov <ekkertan@gmail.com> wrote:
>=20
> > The page http://git-scm.com/book/ru/
> > =D0=92=D0=B2=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=D0=B5-=D0=9F=D0=B5=D1=80=
=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F-=D0=BD=
=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B0-Git contains incorrect=
 link "next"
> > Now this link to the page=20
> > http://git-scm.com/book/ru/=D0=92=D0=B2=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=
=D0=B5-=D0=9A=D0=B0=D0=BA-=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=
=8C-=D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C? , but this
> > page does not exist
>=20
> I would say "?" is just interpreted as a request part of the URL.

Yes, the problem is that the page's URL actually has the "?" in it,
but it needs to be URL-encoded in links.

> > So, correct link is=20
> > http://git-scm.com/book/ru/=D0=92=D0=B2=D0=B5=D0=B4=D0=B5=D0=BD=D0=B8=
=D0=B5-=D0=9A=D0=B0=D0=BA-=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=
=8C-=D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C%3F
>=20
> Good point, thanks.  I Cc'ed the main Git list and made the message
> title a bit more clear.

Exactly. I fixed a few instances of this a while ago, but not the
prev/next pointers. This PR should fix all sites:

  https://github.com/github/gitscm-next/pull/259

> To the Pro Git book maintainer: is it possible to somehow fix the HTM=
L
> generation script to URL-encode any special characters if they're to
> appear in an URL?

I don't think Scott reads the list too closely these days. In general,
the best place to report git-scm.com problems is as an issue in the rep=
o
linked above.

-Peff
