From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Broken umlaut in my name, again
Date: Mon, 6 Apr 2009 15:17:47 +0200
Message-ID: <20090406131747.GH20356@atjola.homenet>
References: <20090331153039.GA1520@atjola.homenet> <20090406114618.GF20356@atjola.homenet> <adf1fd3d0904060546j6c2fbba9r75829f2bd383458b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqojW-0003Ye-8W
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527AbZDFNRz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 09:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756263AbZDFNRy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:17:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:56534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755878AbZDFNRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:17:53 -0400
Received: (qmail invoked by alias); 06 Apr 2009 13:17:49 -0000
Received: from i59F56377.versanet.de (EHLO atjola.local) [89.245.99.119]
  by mail.gmx.net (mp035) with SMTP; 06 Apr 2009 15:17:49 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19p4tNswKZp8pmZV1AhhW+KH6PtYxn2ik42QeG1i/
	2r7Qejr4YzR4or
Content-Disposition: inline
In-Reply-To: <adf1fd3d0904060546j6c2fbba9r75829f2bd383458b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115821>

On 2009.04.06 14:46:43 +0200, Santi B=E9jar wrote:
> 2009/4/6 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > On 2009.03.31 17:30:39 +0200, Bj=F6rn Steinbrink wrote:
> >> While it makes no sense to map some email address to an empty one,=
 doing
> >> things the other way around can be useful. For example when using
> >> filter-branch with an env-filter that employs a mailmap to fix up =
an
> >> import that created such broken commits with empty email addresses=
=2E
> >>
> >> Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
> >
> > The umlaut (=F6) in my name is broken in the commit that made it in=
to
> > git.git --> 5288dd58356e53d61e2b3804fc7d8d23c3a46ab3
> >
> > Last time this happened when I used format-patch -s instead of comm=
it -s
> > IIRC. But since then, I pay attention to do the sign-off via commit=
 -s,
> > yet my name is broken again. What did I do wrong this time?
>=20
> I don't see nothing wrong in your mails. It appears to be a double
> conversion to UTF-8 between the mail and the commit.
>=20
> But I always use format-patch -s without problems, what was your
> problem with format-patch?

I don't recall the exact problem, and I can't find the mails anymore,
the IIRC it was something about Content-type being generated from the
original commit message, and only afterwards the sign-off line got
added, or something like that. That causes the Content-type to say
ascii, although the sign-off had UTF-8 in it. Or something like that.
Might very well have been fixed since then (it was almost 2 years ago
that I hit that bug IIRC), but it made me stick to commit -s ;-)

Bj=F6rn
