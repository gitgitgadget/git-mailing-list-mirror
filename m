From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Buffer overflows
Date: Sun, 02 Sep 2007 19:17:45 +0200
Message-ID: <46DAF039.2000208@lsrfire.ath.cx>
References: <1188502009.29782.874.camel@hurina> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com> <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org> <200709021542.31100.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Timo Sirainen <tss@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Sep 02 19:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRt5H-0005YL-9E
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 19:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbXIBRR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbXIBRR4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 13:17:56 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:45176
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754733AbXIBRR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 13:17:56 -0400
Received: from [10.0.1.201] (p508EF176.dip.t-dialin.net [80.142.241.118])
	by neapel230.server4you.de (Postfix) with ESMTP id 7A128873B6;
	Sun,  2 Sep 2007 19:17:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200709021542.31100.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57369>

Johan Herland schrieb:
> So why does the discussion end there? Lukas proposed an interesting=20
> alternative in "The Better String Library" (=20
> http://bstring.sourceforge.net/ ). Why has there been lots of bashing=
 on=20
> Timo's efforts, but no critique of bstring? I'd be very keen to know =
what=20
> the git developers think of it. AFAICS, it seems to fulfill at least =
_some_=20
> of the problems people find in Timo's patches. Specifically, it claim=
s:
>=20
> - High performance (better than the C string library)
> - Simple usage
>=20
> I'd also say it's probably more widely used than Timo's patches.
>=20
>=20
> If the only response to Timo's highlighting of string manipulation pr=
oblems=20
> in git, is for us to flame his patches and leave it at that, then I h=
ave no=20
> choice but to agree with him in that security does not seem to matter=
 to=20
> us.

Well, a patch (8dabdfcc) from Alex Riesen has made it into 1.5.3 which
fixes some of the problems.  That's a start.

And don't forget that we have our very own string library, viz.
strbuf.c, which could see more use.

That said, I agree that bstring looks well thought out.  It's also quit=
e
large (lots of functions, lots of code where a bug might lurk).  Hmm.

Now if only someone could demonstrate the advantages of using bstring i=
n
git by posting a nice patch.. :-P

Ren=E9
