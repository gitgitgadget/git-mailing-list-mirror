From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 12:45:22 -0400
Message-ID: <20100512164522.GA14710@coredump.intra.peff.net>
References: <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
 <20100508053025.GG14998@coredump.intra.peff.net>
 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
 <19429.3589.823244.270582@winooski.ccs.neu.edu>
 <20100512113855.GB23847@coredump.intra.peff.net>
 <19434.39095.448649.313537@winooski.ccs.neu.edu>
 <20100512124948.GA11761@coredump.intra.peff.net>
 <19434.48308.815673.263230@winooski.ccs.neu.edu>
 <AANLkTilje2dBHjd2aykMnAjWdf8k1vayJ_ez4IfMrl7_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Barzilay <eli@barzilay.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 18:45:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCF3s-00070g-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 18:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab0ELQp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 12:45:26 -0400
Received: from peff.net ([208.65.91.99]:44141 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756528Ab0ELQpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 12:45:25 -0400
Received: (qmail 6900 invoked by uid 107); 12 May 2010 16:45:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 12:45:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 12:45:22 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilje2dBHjd2aykMnAjWdf8k1vayJ_ez4IfMrl7_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146955>

On Thu, May 13, 2010 at 12:07:24AM +0800, Bo Yang wrote:

> > But with `-p' it was doing something confusing: I used two files th=
at
> > were recently renamed, and the result was the correct log history, =
but
> > the first patch that was shown (the rename) showed the two files as
> > added. =C2=A0(That's even when I added `-C' and `-M'.) =C2=A0This h=
appens even
> > with a single path. =C2=A0OTOH, using `--follow' with `-p' and a si=
ngle
> > path without your patch produces the expected result where the firs=
t
> > patch is a rename (even without `-C'/`-M').
>=20
> Try this one, it only change a little on Jeff's patch, my simple test=
s
> show it works. Apply it on 'next' branch.

This is badly whitespace damaged. I fixed up some wrapping, but it seem=
s
that there was some tab/space interchanges, too. Can you repost?

-Peff
