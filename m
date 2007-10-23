From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Let git-add--interactive read "git colors" from
	git-config
Date: Tue, 23 Oct 2007 00:29:57 -0400
Message-ID: <20071023042956.GC28312@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022163244.4af72973@danzwell.com> <20071022211958.045895ac@danzwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:30:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBP9-0000Ob-Rs
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbXJWEaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbXJWEaA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:30:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2020 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbXJWEaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:30:00 -0400
Received: (qmail 31448 invoked by uid 111); 23 Oct 2007 04:29:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 23 Oct 2007 00:29:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2007 00:29:57 -0400
Content-Disposition: inline
In-Reply-To: <20071022211958.045895ac@danzwell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62083>

On Mon, Oct 22, 2007 at 09:19:58PM -0500, Dan Zwell wrote:

> This patch is againts Shawn Pearce's "pu" branch.

Don't do that. The code in 'pu' is a mess of half-working features. If
your patch is accepted, then it has to be picked apart from those
half-working features that aren't being accepted (which hopefully isn't
hard if nobody has been working in the same area, but can be quite
ugly).  Base your work on 'master' if possible, or 'next' if it relies
on features only in next. If it relies on some topic branch that is
_only_ in pu, then mention explicitly which topic.

-Peff
