From: Jeff King <peff@peff.net>
Subject: Re: rerere: how to remove an erroneous resolution?
Date: Mon, 26 Jan 2009 16:11:40 -0500
Message-ID: <20090126211140.GA28354@coredump.intra.peff.net>
References: <20090126144239.GA494@neumann> <20090126151326.GA2618@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYlX-00074l-Q3
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbZAZVLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2009 16:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZAZVLm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:11:42 -0500
Received: from peff.net ([208.65.91.99]:56287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbZAZVLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:11:42 -0500
Received: (qmail 6659 invoked by uid 107); 26 Jan 2009 21:11:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 16:11:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 16:11:40 -0500
Content-Disposition: inline
In-Reply-To: <20090126151326.GA2618@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107278>

On Mon, Jan 26, 2009 at 04:13:26PM +0100, SZEDER G=C3=A1bor wrote:

> On Mon, Jan 26, 2009 at 03:42:39PM +0100, SZEDER G=C3=A1bor wrote:
> > some time ago I mistakenly resolved a merge conflict incorrectly.  =
Of
> > course, rerere noted the erroneous conflict resolution, and wheneve=
r
> > the same merge conflict occurs rerere offers me that erroneous
> > conflict resolution, even though I correct it each time.
> >=20
> > So, the question is how could I make rerere forget that particular
> > merge conflict resolution?  Is it at all possible?
>=20
> Ok, I should have investigated a little longer before sending that
> email.

Hmm. I have never actually used rerere in a real setting, so I am
somewhat clueless. But from your description, it sounds like it would
make sense for it to update the resolution to the latest one used. If
you changed it, it was probably to correct it; you would have no need t=
o
make a change to break an already-working resolution.

Then you would not have had to go mucking about in .git.

-Peff
