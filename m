From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Sun, 6 Sep 2009 03:23:22 -0400
Message-ID: <20090906072322.GA29949@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 09:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkC65-0003SM-4H
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 09:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbZIFHX0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Sep 2009 03:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbZIFHXZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 03:23:25 -0400
Received: from peff.net ([208.65.91.99]:37023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbZIFHXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 03:23:24 -0400
Received: (qmail 9637 invoked by uid 107); 6 Sep 2009 07:23:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Sep 2009 03:23:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Sep 2009 03:23:22 -0400
Content-Disposition: inline
In-Reply-To: <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127841>

On Sun, Sep 06, 2009 at 12:09:07AM -0700, Junio C Hamano wrote:

> I hate to start off with a digression, but one expression from Japane=
se I
> have long been frustrated with, because I cannot find a good counterp=
art
> in English, is "=E5=A4=A7=E3=81=8D=E3=81=AA=E3=81=8A=E4=B8=96=E8=A9=B1=
".
>=20
> J-E dictionaries often translate this phrase as "none of your busines=
s",
> and it indeed is meant to be thrown at somebody who gives an unsolici=
ted
> and an unwanted advice to you, but at the same time it strongly impli=
es
> that the reason why such an advice is unwanted is because you very we=
ll
> knows the issue and does not _need_ (not want) the help on the topic =
at
> all.  It is not about _who_ gives the unwanted advice (which I think =
the
> expression "none of YOUR business" talks about---if the same advice c=
ame
> from somebody else, it might be appreciated), but it is all about on =
what
> topic the advice is about, and you feel that you know about the topic=
 very
> well yourself and do not need any advice from anybody.

The best related English phrase I can think of is that the person is a
"back seat driver". The phrase "armchair $X" also comes to mind (e.g.,
"armchair critic"), though that is usually to indicate that the armchai=
r
critic is giving _bad_ advice, not being well-versed in the field they
are advising about. And I think you are not so much saying the advice i=
s
wrong as much as it is unwanted because you already know it.

I can't think of a noun that describes the advice itself, though
(nagging? ;) ).

> I have always felt that many of the messages we have added since the
> "newbie friendliness" drive around 1.3.0 deserve to be labeled with t=
he
> expression =E5=A4=A7=E3=81=8D=E3=81=AA=E3=81=8A=E4=B8=96=E8=A9=B1.
>=20
> Of course, "unsolicited-unneeded-advice.*" is too long as a variable =
name,
> but I personally would very much welcome changes along this line and =
I
> think "advice.*" is a good name for the category.

Git config files are utf8, right? You can always internationalize this
feature. :)

Thinking on it more, I think "advice" is the right word. It is not abou=
t
arbitrary messages; it is about particular messages which try to advise=
=2E
You would never want this feature to cover messages that are
informational about a particular state or action that has occurred. Onl=
y
"maybe you should try this" messages.

I'll re-roll 3 and 4 based on that, but I will wait a bit to see any
more comments. Probably you should consider patches 1 and 2 as a
potential series for 'maint', and 3 and 4 should be spun off into their
own series (they really only rely textually on the first two).

-Peff
