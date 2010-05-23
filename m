From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Sun, 23 May 2010 05:23:48 -0400
Message-ID: <20100523092348.GA16811@coredump.intra.peff.net>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com>
 <20100505050640.GC8779@coredump.intra.peff.net>
 <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com>
 <20100512133537.GA28956@coredump.intra.peff.net>
 <AANLkTilkFHK1UIvSLEstXFIOJTsit02EZe1Wsoj_zRRX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:24:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7Pd-0006qB-0O
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab0EWJX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 May 2010 05:23:56 -0400
Received: from peff.net ([208.65.91.99]:52793 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab0EWJXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:23:54 -0400
Received: (qmail 21219 invoked by uid 107); 23 May 2010 09:23:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 05:23:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 05:23:48 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilkFHK1UIvSLEstXFIOJTsit02EZe1Wsoj_zRRX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147564>

On Fri, May 14, 2010 at 08:54:07AM +0200, Knittl wrote:

> > That being said, I still get "Initial commit on master". I think th=
at
> > stat_tracking_branch just gives up if the branch doesn't exist (whi=
ch
> > does make some sense). So in practice, I think your original and th=
is
> > one actually behave the same (sorry, I know that changing it was my
> > suggestion).
>=20
> yep, that's what i discovered too=E2=80=94but i don't care if this co=
ndition
> is 3 lines up or down. if stat_tracking_branch decides it will work
> for initial commits, then this code will do the expected thing

Agreed.

> should be no problem. the second patch changed quite a bit, so i
> thought it is easier to review when i send it as a separate patch. th=
e
> final patch can be squashed of course

OK.  Nobody else seems to be commenting, so I would go ahead and put
together your final patch, cc-ing the maintainer.

> > =C2=A02. Your patch has wrapped lines which make it impossible to a=
pply
> > =C2=A0 =C2=A0 without fixing up manually. This is a common gmail pr=
oblem. =C2=A0See
> > =C2=A0 =C2=A0 the "gmail" section of SubmittingPatches.
>=20
> ok, browsed through that. i think i will just put my branch into a
> pasteservice or on a fileserver, unless the email way is *really*
> preferred=E2=80=94what about email attachments?

Inline email is best, but I think an email attachment would be preferre=
d
to putting it on some out-of-band service (it's nice for the mailing
list archive to have a record of everything).

-Peff
