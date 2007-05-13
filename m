From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document patch syntax.
Date: Sun, 13 May 2007 04:27:10 -0400
Message-ID: <20070513082710.GA12712@coredump.intra.peff.net>
References: <20070512120704.22970.45140.stgit@gandelf.nowhere.earth> <20070512135644.GA28039@diana.vm.bytemark.co.uk> <20070512143827.GE16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun May 13 10:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn9QF-0006w1-BJ
	for gcvg-git@gmane.org; Sun, 13 May 2007 10:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414AbXEMI1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756851AbXEMI1N
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 04:27:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4019 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756414AbXEMI1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 04:27:13 -0400
Received: (qmail 19927 invoked from network); 13 May 2007 08:27:11 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 13 May 2007 08:27:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 May 2007 04:27:10 -0400
Content-Disposition: inline
In-Reply-To: <20070512143827.GE16903@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47130>

On Sat, May 12, 2007 at 04:38:27PM +0200, Yann Dirson wrote:

> > > +Patches in the stack are identified with a short name, which must be
> > > +unique in the stack.
> > s/a short name/short names/, maybe.
> Hm, not sure how that would play with the end of the sentence - any
> native english speaker with an opinion ?

Karl's version is more correct (but your version might be used by many
native speakers). The second half of the sentence is correct because
'must' conjugates the same for singular and plural use; however, it
might be more clear to say "...short name, each of which must be unique
in the stack."

> No strong opinion here.  However, that makes me think we should
> probably use guideline for the docs - here comes the question of which
> convention to use when refering to the user.  Do we address her
> directly ("you"), indirectly ("the user", "her" - don't remember where
> the "female user" use comes from, but we could maybe follow this),
> even more indirectly ("one"), or any other way ?

Most of the git docs already use direct address (just grep for 'you' in
Documentation). It's less formal, but it tends to read much more easily.

-Peff
