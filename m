From: Jeff King <peff@peff.net>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 13:05:33 -0500
Message-ID: <20110308180533.GB1823@sigill.intra.peff.net>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
 <4D75ED72.8030203@drmicha.warpmail.net>
 <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
 <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
 <4D75FB7B.70403@drmicha.warpmail.net>
 <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
 <20110308171251.GA1823@sigill.intra.peff.net>
 <AANLkTimE52XWMtpuyaU7MbnyYVszKqNbTPSV=QxLyij3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 19:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px1Hz-0007YZ-Jm
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 19:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab1CHSFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 13:05:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52107
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab1CHSFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 13:05:36 -0500
Received: (qmail 1179 invoked by uid 107); 8 Mar 2011 18:06:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Mar 2011 13:06:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2011 13:05:33 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimE52XWMtpuyaU7MbnyYVszKqNbTPSV=QxLyij3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168669>

On Tue, Mar 08, 2011 at 12:39:10PM -0500, Jay Soffian wrote:

> >> Going back to my original picture, I mean commit m:
> >>
> >> =C2=A0 o---o---x---o---... =C2=A0 =C2=A0foo
> >> =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 \
> >> =C2=A0 =C2=A0 o---o---m---o---... =C2=A0bar
> >>
> >> merge-base foo bar gives me x; to get m I then need to grep the ou=
tput
> >> of rev-list --parents for x.
> >
> > Isn't the merge the first commit in bar that is not in foo? IOW:
>=20
> No, because bar is never merged to foo. Let me relabel the picture:

Oh, of course. Sorry for the misdirection. Too little sleep. :)

> I guess this is not at all a common thing, since it seems to be
> confounding the list. :-)

Yeah, I think in many cases when "foo" and "bar" are merged, they both
end up getting the merge commit, and "foo..bar" and "foo...bar" becomes
a lot more useful.

Yours is more of a long-running maintenance branch scenario. Which is
not all that uncommon, of course, but I can't remember a time when I
wanted to ask for what you're looking for.

-Peff
