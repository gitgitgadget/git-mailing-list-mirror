From: Mark Rosenstand <mark@borkware.net>
Subject: Re: Shipping man pages?
Date: Thu, 18 May 2006 11:41:38 +0200
Message-ID: <1147945298.1320.35.camel@mjollnir>
References: <20060518074630.GA2994@code-monkey.de>
	 <7vac9f69la.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 18 11:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgezt-0003Bi-A3
	for gcvg-git@gmane.org; Thu, 18 May 2006 11:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWERJkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 05:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWERJkm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 05:40:42 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:24636 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S1751321AbWERJkm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 05:40:42 -0400
Received: from hammer (unknown [10.0.0.5])
	by hunin.borkware.net (Postfix) with ESMTP id EBAB1146B1
	for <git@vger.kernel.org>; Thu, 18 May 2006 11:40:40 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <7vac9f69la.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20278>

On Thu, 2006-05-18 at 01:06 -0700, Junio C Hamano wrote:
> Tilman Sauerbeck <tilman@code-monkey.de> writes:
> 
> > atm, the git release tarballs don't contain man pages.
> 
> I ship *source* tarball.

Which is great for generating binaries and other things that are likely
to be incompatible across systems.

> I also happen to do RPM for people who do not want to build from
> the source (btw, I do that from pure inertia). In addition,
> preformatted manual pages and html docs are available from man
> and html branches of the git.git repository.
> 
> If you are building from the source, please build from the
> source.  Everything you need is right there.

But asciidoc is a royal PITA to package or install - it doesn't even
provide a Makefile: http://www.methods.co.nz/asciidoc/userguide.html#X38

Additionally it carries the whole docbook dependency chain with it.

> If you don't build from the source, please use whatever binary
> distribution available out there.  RPM happens to be available
> from kernel.org.  If you are on Debian/Ubuntu/Gentoo/others,
> please ask your distribution packager to include the manpages
> and html docs, if they don't already.

Even the packagers are likely to hate the unneccessary asciidoc
dependency. As a result some of the small distributions that don't have
the manpower to support 1000+ packages choose to ship git without the
man pages, which is a shame, IMO.

> Why does this have to come up so often, and everybody who asks
> for them never supplies the patch to do so?

Because it seems like a political decision rather than a technical one
(it's trivial to add the docs as a prerequisite for the dist target.)

> > Or maybe offer them in a separate tarball?
> 
> Things that are buildable from the source do not belong in the
> source tarball.  If somebody wants to do this as a patch, I can
> be talked into accepting it, but the build procedure should
> build a separate tarball (or two; one for man and another for
> woman^Whtml).

That would be great! I'd love to submit a patch, but I wouldn't be able
to test it, because I'd need asciidoc.
