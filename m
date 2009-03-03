From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 3 Mar 2009 11:19:34 -0500
Message-ID: <20090303161934.GD32079@coredump.intra.peff.net>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net> <20090303154041.GA31265@coredump.intra.peff.net> <43d8ce650903030812n6fe857atb773f5068b6f0a17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Valdemar =?utf-8?B?TcO4cmNoIChMaXN0cyk=?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXMh-0002O1-Qp
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZCCQTj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZCCQTj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:19:39 -0500
Received: from peff.net ([208.65.91.99]:34593 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbZCCQTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:19:38 -0500
Received: (qmail 17711 invoked by uid 107); 3 Mar 2009 16:19:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 11:19:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 11:19:34 -0500
Content-Disposition: inline
In-Reply-To: <43d8ce650903030812n6fe857atb773f5068b6f0a17@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112105>

On Tue, Mar 03, 2009 at 04:12:30PM +0000, John Tapsell wrote:

> > To fix it we:
> >
> > =C2=A01. use "introduce or remove an instance of" instead of
> > =C2=A0 =C2=A0 "contain"
>=20
> I would read this to mean that it doesn't include modifying a line
> containing that string.  But I also know that underneath the hood, a
> change is a remove then an addition, so I would be confused :)
>=20
> What about saying "modifies" rather than "contain" ?

I'm confused. It _doesn't_ include modifying a line containing the
string. In which case it has done its job. But your "but" after that
is what leaves me confused. You thought it would mean that, but you
don't due to some other knowledge, which is leading you down the wrong
path?

I was trying to get away with a short and sweet description. But the
behavior is basically (with a few optimizations):

  if count(a, string) !=3D count(b, string) then
    it is interesting

which is unambiguous, but it takes a second to realize the implications=
=2E

-Peff
