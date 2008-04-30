From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
	from the parent
Date: Wed, 30 Apr 2008 15:26:39 -0400
Message-ID: <20080430192639.GC30344@sigill.intra.peff.net>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com> <1209545236-4266-4-git-send-email-sbejar@gmail.com> <20080430145017.GA922@sigill.intra.peff.net> <20080430163701.GA6544@sigill.intra.peff.net> <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:27:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrHxm-0000Nw-DE
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 21:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763472AbYD3T0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 15:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763454AbYD3T0l
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 15:26:41 -0400
Received: from peff.net ([208.65.91.99]:2127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762067AbYD3T0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 15:26:40 -0400
Received: (qmail 3442 invoked by uid 111); 30 Apr 2008 19:26:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 15:26:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 15:26:39 -0400
Content-Disposition: inline
In-Reply-To: <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80865>

On Wed, Apr 30, 2008 at 09:23:43PM +0200, Santi B=C3=A9jar wrote:

> >  I like the idea in general, but the implementation could be refine=
d.
> >  Maybe consider looking at user.name (whether the repo has an ident
> >  set)? This is usually done conciously, and the user wont need this
> >  reminder.
>=20
> Maybe only show the committer ident when both happens:
>=20
> 1) the committer ident is different from the parent
> 2) the committer ident is set automatically

Honestly, I think just "2)" is probably fine (where automatically
presumably means "from GECOS"). I see what you are trying to accomplish
with "1)", but it's so workflow specific as to be useless.

> P.D.: Jeff, thanks for the amending patch.

No problem.

-Peff
