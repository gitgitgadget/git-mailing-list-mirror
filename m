From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Mon, 6 Sep 2010 18:09:35 +0200
Message-ID: <20100906180935.4881dbb8@jk.gs>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
	<4c8197ab.1707e30a.3f10.714a@mx.google.com>
	<201009061741.27840.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 06 18:09:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OseGa-0004PX-OL
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 18:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0IFQJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 12:09:43 -0400
Received: from zoidberg.org ([88.198.6.61]:34493 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0IFQJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 12:09:41 -0400
Received: from jk.gs (xdsl-89-0-22-20.netcologne.de [::ffff:89.0.22.20])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 06 Sep 2010 18:09:38 +0200
  id 0040023A.4C851242.000064CF
In-Reply-To: <201009061741.27840.trast@student.ethz.ch>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155580>

Hi Thomas,

thanks for your comments so far. I pretty much agree with all of your
thoughts, so below I'm going to focus on those where I have something
to say in addition to that.

> > +#, c-format
> > +msgid "nothing added to commit but untracked files present%s\n"
> > +msgstr "keine =C3=84nderungen f=C3=BCr den Commit vorgemerkt, aber
> > unber=C3=BCcksichtigte Dateien vorhanden\n"
>=20
> Loses the %s (which is used for advice).

That's me being careless. I will add an additional check to my workflow
to prevent format string bugs from happening again.

> [way earlier, and same goes for "by us" -> "hier" [lit. "here"]]
> > +msgid "deleted by them:"
> > +msgstr "dort gel=C3=B6scht:"
> [lit. "deleted there"]
> > +
> [...]
> > +#, c-format
> > +msgid "behind %d] "
> > +msgstr "nur dort %d] "
> [lit. "only there"]
>=20
> This had me pause for a moment.  The concepts of "[merge side] theirs=
"
> and "behind" are quite different; is it a good idea to translate thes=
e
> to the same?
>=20
> Especially so since later on you translate
>=20
> > +#, c-format
> > +msgid "path '%s' does not have our version"
> > +msgstr "Pfad '%s' hat keine Version 'von uns' im Index"
> [lit. "... 'of us' ..."]
>=20
> I do agree that the best I can come up with, "von den anderen
> gel=C3=B6scht", would be quite awkward.

This was one of the more difficult things to decide on while
translating. Both are difficult to translate into something that
"flows", and individually I think both work okay the way I decided to
translate them (but see the next paragraph), but of course it would be
preferrable to distinguish the two different concepts better. I'll be
grateful for any suggestions.

The real problem, I think, is that "ours" and "theirs" are misnomers in
the original terminology. A good translation, I think, will not try
to translate them literally... that would get us from misnomers to
misnomers that also don't lend themselves well to the target
language. :) The question, then, is how to rephrase the messages
elegantly without removing them all too far from the original idea.

This would be easier if "ours" and "theirs" always referred to the same
concept... but they mean different things for merge vs. rebase, for
instance.

> [probably out of order, I found it while compiling the glossary]
> > +msgid "detached HEAD"
> > +msgstr "von HEAD abgetrennt"
>=20
> That's not strictly speaking true; HEAD always points to a commit
> except in an unborn branch, and in any case (this is from commit.c)
> points to a commit after this message is output.  You could try
> "abgetrennter HEAD", "entkoppelter HEAD" or so...

Good catch. I think I might go with something a bit more verbose.
Perhaps something along the lines of "nicht Teil eines definierten
Branches", though obviously that exact phrase is a bit clunky...

-Jan
