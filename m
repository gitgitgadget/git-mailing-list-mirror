From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status
	-u|--untracked-files option
Date: Tue, 3 Jun 2008 18:53:03 -0400
Message-ID: <20080603225303.GA20877@sigill.intra.peff.net>
References: <4845B4E8.1040402@trolltech.com> <7viqwvk04y.fsf@gitster.siamese.dyndns.org> <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com> <20080603201421.GB17260@sigill.intra.peff.net> <4845B4E8.1040402@trolltech.com> <200806032227.m53MRLeD005668@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:54:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3fOF-00073t-It
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYFCWxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbYFCWxI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:53:08 -0400
Received: from peff.net ([208.65.91.99]:3012 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547AbYFCWxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:53:06 -0400
Received: (qmail 3268 invoked by uid 111); 3 Jun 2008 22:53:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 03 Jun 2008 18:53:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2008 18:53:03 -0400
Content-Disposition: inline
In-Reply-To: <200806032227.m53MRLeD005668@mi0.bluebottle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83724>

On Wed, Jun 04, 2008 at 07:26:48AM +0900, =E3=81=97=E3=82=89=E3=81=84=E3=
=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:

> > I guess it would be possible to reparse the options without the -u,=
 if
> > the argument is not one of the three (none,normal,all), but I'm not
> > sure it's _that_ critical. Opinions?
>=20
> Isn't the second bullet point in the description in:
>=20
>     http://www.kernel.org/pub/software/scm/git/docs/gitcli.html
>=20
> good enough?

Ah, that is a fair point. I failed to realize we were telling people
that.

-Peff
