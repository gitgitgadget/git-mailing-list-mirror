From: David Kastrup <dak@gnu.org>
Subject: Re: WIP: asciidoc replacement
Date: Thu, 04 Oct 2007 22:58:17 +0200
Message-ID: <85tzp6oavq.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	<7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	<39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
	<85abr0y5ua.fsf@lola.goethe.zz>
	<1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com>
	<7vd4vwfou9.fsf@gitster.siamese.dyndns.org>
	<46a038f90710032355t77c38d30p781743a6f248fab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdXwO-0000Hz-KE
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759752AbXJDVI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759469AbXJDVIz
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:08:55 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45266 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449AbXJDVIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:08:53 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IdXvK-0007aW-T9; Thu, 04 Oct 2007 17:07:59 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 588121C46502; Thu,  4 Oct 2007 22:58:17 +0200 (CEST)
In-Reply-To: <46a038f90710032355t77c38d30p781743a6f248fab5@mail.gmail.com> (Martin Langhoff's message of "Thu\, 4 Oct 2007 19\:55\:46 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60002>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> With AsciiDoc we've managed to avoid the arcane format, but we are
> still laden with a horrid toolchain.

Let's put this somewhat into perspective: the toolchain is horrid with
regard to the complexity and documentation (well, AsciiDoc
documentation itself is quite thorough and reasonably organized, but
it does not buy you much without learning Docbook, and learning
Docbook is such a chore that people would rather use AsciiDoc in order
to avoid it), not horrid regarding the usability or flexibility of the
results.

If we had a few people specializing in Docbook/AsciiDoc/XSLT available
constantly on the team, we could probably get along fine.

> In that light, I actually like what Johannes is doing, even though
> it's a timesink.

The problem is not just that it is a timesink now, but that it will
remain a timesink.  There is a reason that we don't have so many
formats around with multiple high-quality backends.

> Do the other text based alternatives these days have a workable high
> quality PDF/latex output format without pulling in brittle
> dependencies like XSLT?

Texinfo produces good info and plain text, tolerable PDF and HTML and
not-quite-usable Docbook.  The output for HTML from the current git
documentation toolchain certainly looks better.  I don't see how to
generate PDF right now, but there must be a way (xmlto complains about
not seeing passivetex though I have it installed in TeXlive).

The source is uglier than AsciiDoc, but then there is no cleverly
disguised information in it: every formatting detail is quite out in
the open.  The same is true for Docbook, but Docbook really eats the
cake, platter and all concerning unreadability of the input.  On the
other hand, there are more special-purpose editors that know how to
deal with Docbook/XML than there are for Texinfo.

Texinfo gives a reasonable subset of Linus-thinkalikes the cooties,
and that pretty much rules it out: we need a format that people are
willing to write in.

There are not really many options for versatile formats, I am afraid.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
