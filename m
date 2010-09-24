From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] mergetool-lib: add a three-way diff view for
 vim/gvim
Date: Fri, 24 Sep 2010 17:31:17 -0400
Message-ID: <20100924213116.GA19676@sigill.intra.peff.net>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
 <1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
 <20100918073428.GA9850@gmail.com>
 <AANLkTim_hwduHk-ENM73dwHUj9XbwfihZPRfsHX+M3DE@mail.gmail.com>
 <AANLkTin-BSAFwvuTyJ96BW6MqrKVEni+Af2M0u7WE_yZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 23:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzFrZ-0008G2-5l
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 23:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807Ab0IXVbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 17:31:20 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33333 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273Ab0IXVbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 17:31:19 -0400
Received: (qmail 21599 invoked by uid 111); 24 Sep 2010 21:31:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 24 Sep 2010 21:31:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Sep 2010 17:31:17 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin-BSAFwvuTyJ96BW6MqrKVEni+Af2M0u7WE_yZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157062>

On Fri, Sep 24, 2010 at 02:01:01PM -0500, Dan McGee wrote:

> On Sun, Sep 19, 2010 at 4:48 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Sat, Sep 18, 2010 at 10:34 AM, David Aguilar <davvid@gmail.com> =
wrote:
> >> On Tue, Sep 14, 2010 at 09:21:43PM -0500, Dan McGee wrote:
> >>> When the base version is available, use a three-way, four panel v=
iew by
> >>> default. This shows the (local, base, remote) revisions up top an=
d the
> >>> merged result by itself in the lower pane. All revisions will sti=
ll scroll
> >>> together by default, and the cursor still defaults to the merged =
result edit
> >>> pane.
> >>>
> >>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> >>> ---
> >>>
> >>> Vim was one of the few diff commands to not support a three-way m=
erge showing
> >>> the base revision, so this is a stab at resolving that shortfall.=
 The biggest
> >>> objection I can see to this is making the interface a bit more cu=
mbersome and
> >>> bloated.
> >>>
> >>> An example screenshot of what this produces:
> >>> http://www.toofishes.net/media/extra/vim_three_way.png
> >>>
> >>> -Dan
> >>
> >>
> >> Patch 1/2 of this series looks good to me.
> >>
> >> Is it worth keeping the old behavior and calling this new
> >> mode "vimdiff3" or something along those lines?
> >>
> >> I'm not a vimdiff user so I'm not be the best person to
> >> judge the merits of this change. =C2=A0I like what it's trying
> >> to accomplish, though. =C2=A0Are there any vimdiff users
> >> with strong feelings either way?
> >
> > I think this is a definite improvement; the old mode wasn't really
> > useful for me.
>=20
> Not as much feedback as I had hoped, but thanks to those that did
> speak up. I was thinking of adding a separate mode, but I think it
> would then get under-used and as I said, every other merge tool was
> already doing this anyway.

A little more feedback:

I use vim but don't use vimdiff, because the original mode seemed
useless to me. Your change makes it much better. I haven't actually had
to do any merging lately, though, so I can't comment in practice.

Given that nobody has objected, you have a few comments in support, and
the fact that it makes it similar to every other mergetool driver, I
think it should probably be the default. If somebody really finds it
objectionable, it is not hard for them to configure the old behavior.

-Peff
