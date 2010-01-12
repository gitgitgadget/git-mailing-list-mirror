From: Jeff King <peff@peff.net>
Subject: Re: "What's cooking" incremental edition
Date: Tue, 12 Jan 2010 11:27:36 -0500
Message-ID: <20100112162736.GC25092@coredump.intra.peff.net>
References: <7vmy0lpwes.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001101221i389c05a8v7ff241859d5e8dae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUjbd-0006EB-QQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab0ALQ2P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 11:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379Ab0ALQ2N
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:28:13 -0500
Received: from peff.net ([208.65.91.99]:60597 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477Ab0ALQ1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:27:45 -0500
Received: (qmail 8378 invoked by uid 107); 12 Jan 2010 16:32:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 11:32:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 11:27:36 -0500
Content-Disposition: inline
In-Reply-To: <fabb9a1e1001101221i389c05a8v7ff241859d5e8dae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136737>

On Sun, Jan 10, 2010 at 03:21:20PM -0500, Sverre Rabbelier wrote:

> On Sun, Jan 10, 2010 at 14:55, Junio C Hamano <gitster@pobox.com> wro=
te:
> > =C2=A0* jn/makefile (2010-01-06) 4 commits
> > - - Makefile: consolidate .FORCE-* targets
> > - - Makefile: learn to generate listings for targets requiring spec=
ial flags
> > - - Makefile: use target-specific variable to pass flags to cc
> > - - Makefile: regenerate assembler listings when asked
> > + =C2=A0(merged to 'next' on 2010-01-10 at f5a5d42)
> > + + Makefile: consolidate .FORCE-* targets
> > + + Makefile: learn to generate listings for targets requiring spec=
ial flags
> > + + Makefile: use target-specific variable to pass flags to cc
> > + + Makefile: regenerate assembler listings when asked
>=20
> Fwiw, I find it harder to read due to the now ambiguous meaning of th=
e
> + and - (it could either mean something is in pu/next, or that the
> topic changed). Of course this is partly caused by the fact that I
> don't read emails in fixed font (by default), but perhaps it's worth
> considering using different symbols for pu/next-ness?

I agree. Plus line-by-line is not necessarily the most efficient way to
convey the information that a single character changed. If the subject
of the commit didn't change, it would be easier to see soemething like:

  ->+ Makefile: consolidate .FORCE-* targets
  ->+ Makefile: learn to generate listings for targets requiring specia=
l flags

etc (where ">" is supposed to indicate transition, but it's actually
quite ugly itself).

That being said, I don't personally see the incremental format as all
that useful. If I want to see increments of what's happening, I use git
itself.  The "What's Cooking" message to me is about seeing a survey of
all topics, even those that haven't changed, with Junio's comments. So
you may take my suggestions with a large grain of salt. :)

-Peff
