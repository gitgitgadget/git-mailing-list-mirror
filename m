From: Mike Hommey <mh@glandium.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 08:00:18 +0100
Organization: glandium.org
Message-ID: <20080120070018.GA11015@glandium.org>
References: <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com> <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org> <20080120052735.GA18581@glandium.org> <alpine.LFD.1.00.0801192130180.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 08:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGUAs-0004lK-Fd
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 08:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYATHAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 02:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbYATHAZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 02:00:25 -0500
Received: from vuizook.err.no ([85.19.215.103]:51509 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbYATHAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 02:00:24 -0500
Received: from aputeaux-153-1-17-244.w82-124.abo.wanadoo.fr ([82.124.59.244] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JGUAL-0006fM-Pt; Sun, 20 Jan 2008 08:00:32 +0100
Received: from mh by jigen with local (Exim 4.68)
	(envelope-from <mh@jigen>)
	id 1JGUAE-0003iV-DW; Sun, 20 Jan 2008 08:00:18 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801192130180.2957@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71160>

On Sat, Jan 19, 2008 at 09:45:40PM -0800, Linus Torvalds wrote:
>=20
>=20
> On Sun, 20 Jan 2008, Mike Hommey wrote:
> >=20
> > But there is no way to know whether '=E4' in a document is the Finn=
ish '=E4'
> > or a '=E4' from, say, German, that sorts after 'a'.
>=20
> ... without knowing the locale. Correct.
>=20
> That's why sorting is locale-dependent, even in Unicode. And why you=20
> should always sort using the *combined* character, not think that you=
 can=20
> sort by decompsed sequence.

That said, the locale doesn't necessarily express the language in which
the document is written. It's easy enough to read documents that are no=
t
written in your native language on the net. That's already what we are =
both
doing right now. Fortunately, HTTP and HTML have ways to indicate the
language in which a document is written in, but that leaves out plain
mail, for instance.=20

That said, the "decomposed" version of UTF-8 has nice side effects on
OSX, with UTF-8 encoded RockRidge ISO-9660 volumes (with or without
Joliet ; OSX will use RockRidge by default when it's there), for instan=
ce.

Mike
