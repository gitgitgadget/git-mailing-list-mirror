From: Mike Hommey <mh@glandium.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 10:19:59 +0100
Organization: glandium.org
Message-ID: <20080123091958.GA6969@glandium.org>
References: <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123084345.GN14871@dpotapov.dyndns.org> <57518fd10801230102n4f430219p2701c7561f184569@mail.gmail.com> <20080123091240.GO14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHbmg-0005uQ-IU
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 10:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYAWJUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 04:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbYAWJUE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 04:20:04 -0500
Received: from smtp2b.orange.fr ([80.12.242.145]:55390 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbYAWJUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 04:20:03 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b13.orange.fr (SMTP Server) with ESMTP id AD7BA70001AE
	for <git@vger.kernel.org>; Wed, 23 Jan 2008 10:20:00 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-83-190.w86-205.abo.wanadoo.fr [86.205.41.190])
	by mwinf2b13.orange.fr (SMTP Server) with ESMTP id 7B3E4700015C;
	Wed, 23 Jan 2008 10:20:00 +0100 (CET)
X-ME-UUID: 20080123092000504.7B3E4700015C@mwinf2b13.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JHbm3-0001ox-Q2; Wed, 23 Jan 2008 10:19:59 +0100
Content-Disposition: inline
In-Reply-To: <20080123091240.GO14871@dpotapov.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71527>

On Wed, Jan 23, 2008 at 12:12:40PM +0300, Dmitry Potapov <dpotapov@gmai=
l.com> wrote:
> On Wed, Jan 23, 2008 at 09:02:43AM +0000, Jonathan del Strother wrote=
:
> > On Jan 23, 2008 8:43 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > > On Wed, Jan 23, 2008 at 03:15:02AM -0500, Kevin Ballard wrote:
> > > >
> > > > Entirely possible, though renormalizing file contents seems a b=
it less
> > > > likely. I will point out that the text input system in OS X see=
ms to
> > > > default to producing NFC (at least, typing `echo 'M=E4rchen' | =
xxd` in
> > > > the Terminal shows that the input string there is NFC).
> > >
> > > I wonder what happens if you do this:
> > >
> > > touch 'M=E4rchen'
> > > echo M*rchen | xxd -g1
> > >
> > > Will that produce NFC or NFD?
> > >
> >=20
> > 0000000: 4d 61 cc 88 72 63 68 65 6e 0a                    Ma..rchen=
=2E
>=20
> This is NFC! Did you do that on HFS+?

NFD, you mean ?

Mike
