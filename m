From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git status: display current branch name in color
Date: Sun, 17 Jan 2010 21:32:55 -0500
Message-ID: <20100118023255.GC6831@coredump.intra.peff.net>
References: <d2e97e801001141823i7519864dy264488d36fca465c@mail.gmail.com>
 <d2e97e801001162031n1dab2301k5a839846b3cc5d9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 03:33:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWhQP-00040J-RC
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 03:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab0ARCc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jan 2010 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257Ab0ARCc7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 21:32:59 -0500
Received: from peff.net ([208.65.91.99]:41687 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab0ARCc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 21:32:58 -0500
Received: (qmail 696 invoked by uid 107); 18 Jan 2010 02:37:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 17 Jan 2010 21:37:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 21:32:55 -0500
Content-Disposition: inline
In-Reply-To: <d2e97e801001162031n1dab2301k5a839846b3cc5d9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137360>

On Sun, Jan 17, 2010 at 03:31:07PM +1100, Michael Wookey wrote:

> > There is an existing highlight when the user is not on any branch.
> > Enhance this functionality to always provide the name of the curren=
t
> > branch in color.
> >
> > Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
> > ---
> > =C2=A0wt-status.c | =C2=A0 10 ++++++----
> > =C2=A0wt-status.h | =C2=A0 =C2=A03 ++-
> > =C2=A02 files changed, 8 insertions(+), 5 deletions(-)
>=20
> Any thoughts on this?

I don't have an objection to the concept, but for it to be acceptable
for inclusion in mainstream git, the color selection needs to be
configurable (see builtin-commit.c:parse_status_slot) and documented
(see Documentation/config.txt, color.status.<slot>).

And then we can decide what the _default_ color should be. Personally, =
I
find it a bit distracting to change the color for something so mundane,
and would be in favor of leaving it the same as the header color. But I
will not argue too hard either way; I have no problem with setting my
own config to make it invisible if others disagree. :)

-Peff
