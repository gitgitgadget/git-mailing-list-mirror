From: Jeff King <peff@github.com>
Subject: Re: [PATCH] stash: fix false positive in the invalid ref test.
Date: Wed, 6 Apr 2011 19:04:59 -0400
Message-ID: <20110406230459.GC20904@sigill.intra.peff.net>
References: <1302045673-59982-1-git-send-email-jon.seymour@gmail.com>
 <20110406182726.GC8205@sigill.intra.peff.net>
 <BANLkTimqG4XSTRGH-+EMi6vYL7N8JU1Mtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 01:05:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7bmg-0003sN-TM
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 01:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761Ab1DFXFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 19:05:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33003
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756708Ab1DFXFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 19:05:03 -0400
Received: (qmail 10626 invoked by uid 107); 6 Apr 2011 23:05:49 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 19:05:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 19:04:59 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimqG4XSTRGH-+EMi6vYL7N8JU1Mtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171026>

On Thu, Apr 07, 2011 at 08:47:07AM +1000, Jon Seymour wrote:

> On Thu, Apr 7, 2011 at 4:27 AM, Jeff King <peff@github.com> wrote:
> > On Wed, Apr 06, 2011 at 09:21:13AM +1000, Jon Seymour wrote:
> =C2=A0 =C2=A0 git stash drop
> >
> > Probably we should just squash your fix in with my first patch, and=
 drop
> > my test. =C2=A0Your fixed version is a superset of what mine tests.
> >
>=20
> I was wondering if it might be better to break up the original test,
> so that each sub-function has its own invalid ref test? If there is
> agreement, I can do this on top of 9355fc which is the tip of the
> branch containing these fixes that has been merged into pu.

I don't think it's that big a deal. You could do a more thorough test
for each, I guess (to make sure they not just failed but also show that
they didn't have any effects), but that would not be checking an actual
regression we have seen. IOW, I'm sure you have something more
productive to do with your time. :)

-Peff
