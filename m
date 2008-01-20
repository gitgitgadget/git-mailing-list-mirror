From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 01:11:57 +0100
Message-ID: <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com>
References: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>, Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 01:13:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGNo4-0002qx-0A
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 01:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYATAMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 19:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbYATAMT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 19:12:19 -0500
Received: from wincent.com ([72.3.236.74]:42744 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbYATAMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 19:12:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0K0C0F4030484;
	Sat, 19 Jan 2008 18:12:01 -0600
In-Reply-To: <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71145>

El 19/1/2008, a las 19:58, Linus Torvalds escribi=F3:

> I suspect that if we were to just do the "turn into NFC on readdir() =
=20
> on OS
> X", that might actually be good enough to hide most of the problems. =
=20
> The
> issue isn't just that OS X mangles the filenames, it's that it picks =
a
> particularly *stupid* way to mangle them (the decomposed forms), whic=
h
> means that OS X will actually not just corrupt "odd cases" of =20
> Unicode, but
> will corrupt the obvious and *common* Latin1 translations of Unicode.


=46or what it's worth, their choice wasn't entirely "insane" ie. it did=
 =20
have an element of rationality: that decomposed forms are a little bit =
=20
simpler to sort.

Of course, this doesn't excuse them for creating a file system that =20
interacts so horridly with basically everything else out there.

Cheers,
Wincent
