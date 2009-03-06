From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] '%S' option for pretty printing to support --source
Date: Fri, 6 Mar 2009 00:25:59 -0500
Message-ID: <20090306052558.GC3426@sigill.intra.peff.net>
References: <200903050918.29051.petri.hodju@yumesystems.com> <20090305091758.GC30445@coredump.intra.peff.net> <86d4c5e00903051141u61a131beg26b3df95bafd65d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petri Hodju <petri.hodju@yumesystems.com>, git@vger.kernel.org,
	gitster@pobox.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Fri Mar 06 06:28:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfSbQ-00064F-Oa
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 06:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZCFF0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 00:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbZCFF0E
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 00:26:04 -0500
Received: from peff.net ([208.65.91.99]:60292 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481AbZCFF0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 00:26:03 -0500
Received: (qmail 5714 invoked by uid 107); 6 Mar 2009 05:26:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 06 Mar 2009 00:26:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2009 00:25:59 -0500
Content-Disposition: inline
In-Reply-To: <86d4c5e00903051141u61a131beg26b3df95bafd65d3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112387>

On Thu, Mar 05, 2009 at 02:41:44PM -0500, Deskin Miller wrote:

> > =C2=A0- gracefully block concurrent use of conflicting features
>=20
> I agree that any blocking should be graceful, but ultimately I find
> the idea of disallowing features because they happen to use the same
> underlying implementation distasteful.  With a little work we should
> be able to allow both with no problem.

Yes, I would prefer to avoid blocking if at all possible. But I include=
d
it as a last resort until things can be fixed correctly. IOW, by
"graceful" I just meant "die with an error instead of segfaulting".
Which would still arguably be a bug, but at least would clue the user i=
n
to what is happening.

Anyway, happy moving and I'll look forward to seeing your patch when it
is ready. :)

-Peff
