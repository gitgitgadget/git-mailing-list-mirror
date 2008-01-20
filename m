From: Mike Hommey <mh@glandium.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 06:27:35 +0100
Organization: glandium.org
Message-ID: <20080120052735.GA18581@glandium.org>
References: <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com> <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org>
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
X-From: git-owner@vger.kernel.org Sun Jan 20 06:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGSjW-0007Rh-AV
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 06:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYATF1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 00:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYATF1y
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 00:27:54 -0500
Received: from vuizook.err.no ([85.19.215.103]:57495 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbYATF1x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 00:27:53 -0500
Received: from aputeaux-153-1-17-244.w82-124.abo.wanadoo.fr ([82.124.59.244] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JGSio-00031g-Ff; Sun, 20 Jan 2008 06:28:00 +0100
Received: from mh by jigen with local (Exim 4.68)
	(envelope-from <mh@jigen>)
	id 1JGSiV-0000wz-7G; Sun, 20 Jan 2008 06:27:35 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71155>

On Sat, Jan 19, 2008 at 05:04:09PM -0800, Linus Torvalds wrote:
>=20
>=20
> On Sun, 20 Jan 2008, Wincent Colaiuta wrote:
> >=20
> > For what it's worth, their choice wasn't entirely "insane" ie. it d=
id have an
> > element of rationality: that decomposed forms are a little bit simp=
ler to
> > sort.
>=20
> No they are *not*.
>=20
> In many languages, '=E4' does *not* sort like 'a' at all, and if you =
think=20
> it does, you'll sort at least Finnish and Swedish totally wrong (=E5=E4=
=F6 are=20
> real letters, and they sort at the *end* of the alphabet, they have=20
> nothing what-so-ever to do with the letters 'a' or 'o').

But there is no way to know whether '=E4' in a document is the Finnish =
'=E4'
or a '=E4' from, say, German, that sorts after 'a'.

> The fact that in *some* languages the decomposed forms sort as the ba=
se=20
> letter is immaterial. It's only true in some cases.
>=20
> So no, sort order is not it. To sort right, you need to use the a rea=
l=20
> Unicode sort (and the decomposed form is *not* going to help you one =
bit,=20
> quite the reverse).

Unicode sort is not enough, there is no language indicator in an Unicod=
e
document, which is why Unicode, while solving a bunch of problems, has
its very own, cf. the infamous CJK problem.

But that's all very OT.

Mike
