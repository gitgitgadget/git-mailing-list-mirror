From: Jeff King <peff@peff.net>
Subject: Re: Bugreport: Git responds with stderr instead of stdout
Date: Sun, 25 Apr 2010 15:32:58 -0400
Message-ID: <20100425193258.GA16171@coredump.intra.peff.net>
References: <20100425130607.2c92740f@pennie-farthing>
 <v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
 <y2g51dd1af81004251124zc4da759dka2ceebe1d9735fd7@mail.gmail.com>
 <20100425192207.GA14736@coredump.intra.peff.net>
 <m2h51dd1af81004251232ue621ca42r7168429f45d20461@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Jack Desert <jackdesert556@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 21:33:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O67Zi-0005Ar-7z
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 21:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab0DYTdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 15:33:00 -0400
Received: from peff.net ([208.65.91.99]:42009 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab0DYTc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 15:32:59 -0400
Received: (qmail 30879 invoked by uid 107); 25 Apr 2010 19:33:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Apr 2010 15:33:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Apr 2010 15:32:58 -0400
Content-Disposition: inline
In-Reply-To: <m2h51dd1af81004251232ue621ca42r7168429f45d20461@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145762>

On Sun, Apr 25, 2010 at 07:32:00PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> >> I've had some issues scripting `git fetch` because on error it'll
> >> print to stdout and not stderr.
> >
> > Errors should go to stderr, so I imagine patches would be welcome. =
Which
> > messages went to stdout?
>=20
> I can't recall exactly now. Looking at fetch.c I can't see anything
> obvious, I'll report anything if I spot it in the future.

Thanks. As I mentioned, we've been fixing little things like this as
time goes on, so it may well have been fixed already.

-Peff
