From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
	from the parent
Date: Thu, 1 May 2008 09:51:09 -0400
Message-ID: <20080501135109.GA10135@sigill.intra.peff.net>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com> <1209545236-4266-4-git-send-email-sbejar@gmail.com> <20080430145017.GA922@sigill.intra.peff.net> <20080430163701.GA6544@sigill.intra.peff.net> <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com> <20080430192639.GC30344@sigill.intra.peff.net> <8aa486160805010134l4746f9afhec546a9d49fd7a6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 15:52:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrZCZ-0000Mo-FD
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 15:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYEANvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 09:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbYEANvL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 09:51:11 -0400
Received: from peff.net ([208.65.91.99]:1052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347AbYEANvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 09:51:10 -0400
Received: (qmail 7840 invoked by uid 111); 1 May 2008 13:51:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 09:51:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 09:51:09 -0400
Content-Disposition: inline
In-Reply-To: <8aa486160805010134l4746f9afhec546a9d49fd7a6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80910>

On Thu, May 01, 2008 at 10:34:44AM +0200, Santi B=C3=A9jar wrote:

> >  > 1) the committer ident is different from the parent
> >  > 2) the committer ident is set automatically
> >
> >  Honestly, I think just "2)" is probably fine (where automatically
> >  presumably means "from GECOS"). I see what you are trying to accom=
plish
> >  with "1)", but it's so workflow specific as to be useless.
>=20
> I don't see "1) as workflow specific, it is there to minimize the
> number of time it is shown, ie somebody might prefer the automatic
> ident, so as long as it does not change it is not shown.

Yes, but whether it actually succeeds in minimizing is dependent on the
workflow of the user. I.e., it works great if I tend to build on small,
personal repositories (or topic branches), or if I tend to receive othe=
r
people's work by patches that I commit myself. But if I am pulling from
somebody else's repo (as many of us do from git.git), or if I use a
shared repo with the other committers, then I am very likely to be
building on a parent that was committed by somebody else (and
consequently will see the committer mentioned way more often than was
intended).

-Peff
