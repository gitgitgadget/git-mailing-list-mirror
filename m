From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [REGRESSION] git-gui
Date: Mon, 7 Apr 2008 22:18:07 -0400
Message-ID: <20080408021807.GX10274@spearce.org>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com> <200804032304.17054.barra_cuda@katamail.com> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com> <871w5it8r7.fsf@lysator.liu.se> <20080407081052.GA5413@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, maillist@steelskies.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 08 04:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jj3QJ-0002TJ-PK
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 04:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYDHCSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2008 22:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYDHCSP
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 22:18:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43484 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYDHCSO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 22:18:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jj3PJ-00054x-99; Mon, 07 Apr 2008 22:17:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0DC6620FBAE; Mon,  7 Apr 2008 22:18:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080407081052.GA5413@mithlond.arda.local>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78993>

Teemu Likonen <tlikonen@iki.fi> wrote:
> David K=C3=A5gedal kirjoitti (7.4.2008 klo 9.38):
> > "Jonathan del Strother" <maillist@steelskies.com> writes:
> >=20
> > > Anyone else got any opinions on an appropriate shortcut?  How abo=
ut
> > > '=3D' and '-' (+ and - without the shift), or are those not
> > > necessarily together either?  (Are there really layouts where '['
> > > and ']' aren't next to each other?)
> >=20
> > A Swedish keyboard has [] on alt-gr (Modeshift) 8 and 9.  Plus and
> > minus are unshifted and =3D is on shift-0.
> >=20
> > So with a Swedish layout, it is annoying when zoom in is on =3D rat=
her
> > than +, just because someone assumed that it would be harder to pre=
ss
> > the more logical plus key.
>=20
> The above also applies to Finnish and Norwegian keyboards, probably t=
o
> many more. The key pair '=3D' and '-' would be a poor UI decision. In
> principle one should never assume that a key is in certain place in t=
he
> keyboard; it's much better idea to be logical with _characters_. So i=
f
> a key pair much be defined for different aspects of the same
> functionality, let's choose logical pairs from common characters: +- =
[]
> {} () <> zZ aA bB ... (To me all these are OK.)

Well, Ctrl-+ and Ctrl-=3D are bound to the same action (increase
context), and Ctrl-- is bound to the opposite action (decrease
context).  So Swedish folks should be able to use Ctrl-+ and
be happy.

Except it doesn't show in the menubar as being a possible keyboard
driven action.  That was in the original patch, but I took it out
to enable the accelator to draw on Mac OS X.

--=20
Shawn.
