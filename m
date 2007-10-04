From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 12:19:35 -0400
Message-ID: <20071004161935.GC17487@fieldses.org>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com> <20071004125641.GE15339@genesis.frugalware.org> <7vy7ej9g38.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710041534000.4174@racer.site> <vpqtzp7ndn3.fsf@bauges.imag.fr> <20071004155147.GA17487@fieldses.org> <vpq8x6ix3zm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTQe-0003HP-Jf
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759763AbXJDQTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 12:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757661AbXJDQTv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:19:51 -0400
Received: from mail.fieldses.org ([66.93.2.214]:40312 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545AbXJDQTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 12:19:50 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IdTQF-0005Nh-OS; Thu, 04 Oct 2007 12:19:35 -0400
Content-Disposition: inline
In-Reply-To: <vpq8x6ix3zm.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59978>

On Thu, Oct 04, 2007 at 06:02:21PM +0200, Matthieu Moy wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Yes, the index differs from the work tree or HEAD temporarily, 
> 
> Temporarily, yes, but the _point_ of having it is to have it differ
> from HEAD (otherwise, you can't create a new revision), and from the
> tree (otherwise, index-related commands are useless).

Getting a nearly-instantaneous "git diff" would be sufficiently
important to justify its existance on its own, so I think you're
overstating the case.

> The stat-information, and sha1sum are actually a cache, but they don't
> have to be user-visible, except for speed.

That's a big exception.--b.

> "diff --cached" has nothing to do with the stat information for the
> user.
