From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] api-parse-options.txt: Introduce documentation for
	parse options API
Date: Sun, 22 Jun 2008 15:45:50 +0200
Message-ID: <20080622134550.GA5279@leksak.fem-net>
References: <1214092802-8175-1-git-send-email-s-beyer@gmx.net> <200806221449.08307.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 15:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAPu5-0002pc-CE
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 15:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYFVNpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 09:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYFVNpx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 09:45:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:39590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751745AbYFVNpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 09:45:53 -0400
Received: (qmail invoked by alias); 22 Jun 2008 13:45:50 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp006) with SMTP; 22 Jun 2008 15:45:51 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/Y4jZn+hPYWupUfc44qfE3GvBfulCKeBLRQbYuha
	00mf1KPnChJSAy
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KAPt8-0002j7-5p; Sun, 22 Jun 2008 15:45:50 +0200
Content-Disposition: inline
In-Reply-To: <200806221449.08307.barra_cuda@katamail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85770>

> > +`PARSE_OPT_KEEP_DASHDASH`::
> > +=A0=A0=A0=A0=A0=A0=A0Usually long options (`\--long-opt`) are boil=
ed down to their
> > +=A0=A0=A0=A0=A0=A0=A0short option equivalent, if available.
> > +=A0=A0=A0=A0=A0=A0=A0Using this flag, long options are kept.
>=20
> No: PARSE_OPT_KEEP_DASHDASH keeps the "--" that usually separates opt=
ions
> from files, as in

Eh, right, of course!  What I wrote doesn't make any sense. ;-)

> > +`OPT__ABBREV(&int_var)`::
> > +       Add `\--abbrev [<n>]`.
>=20
> better:
> +       Add `\--abbrev[=3D<n>]`.
>=20
> since the <n> is optional.

That's right and I also expected that print_usage_with_options() would
do so, since the other variant is ambiguous, BUT:

$ ./test-parse-options -h 2>&1 | grep abbrev
    --abbrev [<n>]        use <n> digits to display SHA-1s

And I didn't want to change parse-options.c ;-)


Any other comments?

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
