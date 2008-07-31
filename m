From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Thu, 31 Jul 2008 22:57:03 +0200
Message-ID: <20080731225703.7be6f76e@neuron>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
	<20080729170955.GK32184@machine.or.cz>
	<d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
	<7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
	<alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vy73j418t.fsf@gitster.siamese.dyndns.org>
	<4891A0D0.6060503@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfIu-0002V2-If
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbYGaVCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYGaVCT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:02:19 -0400
Received: from zoidberg.org ([213.133.99.5]:43542 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbYGaVCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:02:18 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jul 2008 17:02:18 EDT
Received: from neuron (xdsl-87-78-233-158.netcologne.de [::ffff:87.78.233.158])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 31 Jul 2008 22:57:04 +0200
  id 00185BEC.48922721.00000B98
In-Reply-To: <4891A0D0.6060503@lyx.org>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90990>

Hi,

> Disclaimer: I am involved in LyX development, so anything I said will
> be biased :-)

I think that's fine since I consider LaTeX (and therefore LyX as the
best graphical editor for it that I know) a choice always worth
considering when it comes to projects that have the size of a book.

> Now, about my shameless plug: LyX is ideally suited for structured 
> documentation writing :-)

That may well be, but it gets really complicated once you want to
get your document into other markup-based formats while preserving all
the important aspects of formatting. I know this because I started
using LaTeX for a project that was supposed to be available in HTML
form along with, say, PDF. I've found that the only converter that
comes close to being useful for somewhat more ambitious sources
(including, perhaps, custom environments and stuff like that) without
spending a ridiculous amount of time trying to understand it is hevea.
Of course, hevea only translates to HTML, so, for example, generating
manpages or plain text is an entirely different matter of considerable
difficulty.

In addition to that, I suspect that LyX files might be difficult to
deal with in forky Git situations. For example, what if two
separately contributed patches need merging into a LyX source file?
This will only work automatically if the LyX source, treated as plain
text, has a really low chance of randomly changing in other places than
what the patch is supposed to touch. Also, if a merge does cause a
conflict, I imagine it would be difficult to resolve that.

Finally, it's pretty much a given that Git's manpages continue to use
AsciiDoc because there are few other things that can generate actual
manpages. I'm not sure it would be a good idea to keep half of Git's
documentation in one format and the rest in another. And AsciiDoc is --
by far! -- not the worst choice. I'm tempted to say it's the best that
I know.

-Jan
