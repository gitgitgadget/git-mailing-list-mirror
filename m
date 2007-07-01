From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git-stash
Date: Sun, 1 Jul 2007 05:19:05 -0400
Message-ID: <20070701091905.GA13559@coredump.intra.peff.net>
References: <20070701080757.GA6093@coredump.intra.peff.net> <200707010910.l619A23c027837@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 11:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4vaT-0000SZ-8l
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 11:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbXGAJTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 1 Jul 2007 05:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbXGAJTI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 05:19:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3149 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbXGAJTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 05:19:07 -0400
Received: (qmail 32569 invoked from network); 1 Jul 2007 09:19:28 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 1 Jul 2007 09:19:28 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jul 2007 05:19:05 -0400
Content-Disposition: inline
In-Reply-To: <200707010910.l619A23c027837@mi0.bluebottle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51287>

On Sun, Jul 01, 2007 at 06:06:29PM +0900, =E3=81=97=E3=82=89=E3=81=84=E3=
=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:

> I don't understand myself anymore, either (^_^;) I just tried to foll=
ow
> Jnio's earlier suggestion in his message.  He said this.

OK, we will wait for Junio to clarify tomorrow. :)

> >> +	Removes all the stashed states.
> >
> > Maybe a note to indicate that this can lose data? Something like:
> >
> >   ...stashed states. Note that those states will then be subject to
> >   pruning, and may be difficult or impossible to recover.
>=20
> I see.  When I wrote it, I thought that saying "removes" was enough. =
 It
> seemed obvious to me that you would lose it when you remove it.

It is "enough" in the sense that the meaning is clear, but in general i=
t
is very hard to convince git to forget things, and I think that is a
feature. There are so few commands in git where you can "lose" data tha=
t
I think it is worth marking them with a big X.

Really, I don't see the need to use 'clear' in general. The reflog work=
s
as a stack, so old stashes will get out of the "top 10" eventually
anyway. In the long run, they will be cleaned up by "git reflog expire"
(or indirectly by "git gc").

> Thanks for fixing my language.  I am not very good at writing English=
,
> but you probably have already found it out (^_^;).

Quite the contrary. If it had been very badly written, it would have
just been easier to rewrite it than to point out the few mistakes. :)

-Peff
