From: Jeff King <peff@peff.net>
Subject: Re: `Git Status`-like output for two local branches
Date: Sat, 5 Sep 2009 04:17:26 -0400
Message-ID: <20090905081726.GA7109@coredump.intra.peff.net>
References: <c115fd3c0908311320q46d585d2v457ccd0f411a6404@mail.gmail.com>
 <20090902075713.GA1832@coredump.intra.peff.net>
 <fabb9a1e0909020118m2fe2e6e1g79cc83ce941ac000@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqUa-0003v8-6u
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbZIEIR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2009 04:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757158AbZIEIR3
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:17:29 -0400
Received: from peff.net ([208.65.91.99]:60861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZIEIR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:17:28 -0400
Received: (qmail 25746 invoked by uid 107); 5 Sep 2009 08:17:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:17:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:17:26 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0909020118m2fe2e6e1g79cc83ce941ac000@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127792>

On Wed, Sep 02, 2009 at 10:18:54AM +0200, Sverre Rabbelier wrote:

> On Wed, Sep 2, 2009 at 09:57, Jeff King<peff@peff.net> wrote:
> > =C2=A02. Count the commits on each side that are not in the other.
>=20
> [...]
>=20
> >      You can also do that by parsing the output of:
> > =C2=A0 =C2=A0 =C2=A0 git rev-list --left-right $a...$b --
>=20
> Perhaps it is useful to introduce a --left-right-count or such?

I'm not opposed to that if it is something a lot of people found useful=
,
but I am not sure we have established that as the case (I am curious to
hear from Tim what his actual use case is).

-Peff
