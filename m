From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow testing of _relative family of time formatting
 and parsing functions
Date: Sun, 30 Aug 2009 03:51:40 -0400
Message-ID: <20090830075140.GB14217@coredump.intra.peff.net>
References: <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828190319.GA9233@blimp.localdomain>
 <20090828191521.GA12292@coredump.intra.peff.net>
 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
 <20090828193302.GB9233@blimp.localdomain>
 <20090828205232.GD9233@blimp.localdomain>
 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
 <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 09:51:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhfCc-0007YK-2U
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 09:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbZH3Hvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 03:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666AbZH3Hvm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 03:51:42 -0400
Received: from peff.net ([208.65.91.99]:40704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbZH3Hvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 03:51:41 -0400
Received: (qmail 16343 invoked by uid 107); 30 Aug 2009 07:51:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 03:51:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 03:51:40 -0400
Content-Disposition: inline
In-Reply-To: <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127398>

On Sun, Aug 30, 2009 at 09:25:11AM +0200, Alex Riesen wrote:

> >=C2=A0Is this intended as a serious submission for inclusion?
>=20
> Not yet. AFAICS, test-date is never used in our test suite.

No, it isn't, but I think the point of this is to change that.
So it is useless without an extra patch to the test suite. I'll try to
put something together.

> Right, that's because I'm not sure myself. Frankly, I'm not
> convinced we have to test every single thing. In my experience,
> the bigger a test suite, the less are people inclined to use it
> (including setting up automatic test runs).
>=20
> Jeff, Nicolas? Is this test enough? Are there any other code
> paths you want to include in the test?

I think this is a useful addition to the test suite. The bug David fixe=
d
was obvious, but it sat for a year because of poor test coverage. Linus
fixed several approxidate bugs recently. The approxidate code is
notoriously temperamental, so it is a good thing to be checking for
regressions.

And I don't think our test suite is nearly big enough to start worrying
about getting people not to use it. Without CVS and SVN tests, I can ru=
n
it on 3-year-old hardware in less than a minute. Either you bother to
run it or not, but I doubt that adding one new test script is going to
break the bank.

-Peff
