From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 12:32:42 +0300
Message-ID: <20080123093242.GQ14871@dpotapov.dyndns.org>
References: <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123084345.GN14871@dpotapov.dyndns.org> <57518fd10801230102n4f430219p2701c7561f184569@mail.gmail.com> <20080123091240.GO14871@dpotapov.dyndns.org> <20080123091958.GA6969@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHbzB-0001Nu-Sx
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 10:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYAWJct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 04:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYAWJct
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 04:32:49 -0500
Received: from smtp05.mtu.ru ([62.5.255.52]:53733 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbYAWJcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 04:32:48 -0500
Received: from smtp05.mtu.ru (localhost [127.0.0.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id BF260A2C627;
	Wed, 23 Jan 2008 12:32:44 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-241.pppoe.mtu-net.ru [85.141.188.241])
	by smtp05.mtu.ru (Postfix) with ESMTP id A06F2A2C06C;
	Wed, 23 Jan 2008 12:32:42 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JHbyM-0007Dt-DR; Wed, 23 Jan 2008 12:32:42 +0300
Content-Disposition: inline
In-Reply-To: <20080123091958.GA6969@glandium.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp05.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71528>

On Wed, Jan 23, 2008 at 10:19:59AM +0100, Mike Hommey wrote:
> On Wed, Jan 23, 2008 at 12:12:40PM +0300, Dmitry Potapov <dpotapov@gm=
ail.com> wrote:
> > On Wed, Jan 23, 2008 at 09:02:43AM +0000, Jonathan del Strother wro=
te:
> > > On Jan 23, 2008 8:43 AM, Dmitry Potapov <dpotapov@gmail.com> wrot=
e:
> > > > On Wed, Jan 23, 2008 at 03:15:02AM -0500, Kevin Ballard wrote:
> > > > >
> > > > > Entirely possible, though renormalizing file contents seems a=
 bit less
> > > > > likely. I will point out that the text input system in OS X s=
eems to
> > > > > default to producing NFC (at least, typing `echo 'M=E4rchen' =
| xxd` in
> > > > > the Terminal shows that the input string there is NFC).
> > > >
> > > > I wonder what happens if you do this:
> > > >
> > > > touch 'M=E4rchen'
> > > > echo M*rchen | xxd -g1
> > > >
> > > > Will that produce NFC or NFD?
> > > >
> > >=20
> > > 0000000: 4d 61 cc 88 72 63 68 65 6e 0a                    Ma..rch=
en.
> >=20
> > This is NFC! Did you do that on HFS+?
>=20
> NFD, you mean ?

Oops, you are right.

Dmitry
