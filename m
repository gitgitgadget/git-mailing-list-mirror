From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 04/11] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 18:15:02 -0400
Message-ID: <20120620221502.GB3302@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183133.GD30995@sigill.intra.peff.net>
 <20120620211225.GD6142@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:15:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTBB-0000L0-4w
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 00:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab2FTWPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 18:15:07 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39345
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850Ab2FTWPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 18:15:06 -0400
Received: (qmail 30940 invoked by uid 107); 20 Jun 2012 22:15:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 18:15:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 18:15:02 -0400
Content-Disposition: inline
In-Reply-To: <20120620211225.GD6142@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200369>

On Wed, Jun 20, 2012 at 04:12:25PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >                                                      These
> > flags may sometimes require extra dependencies to be added
> > (e.g., like GIT-VERSION-FILE; this is not the case for any
> > of the updated lines in this patch, but it is establishing a
> > style that will be used in later patches).
> [...] 
> > This patch explicitly does not update the static header
> > dependencies used when COMPUTED_HEADER_DEPENDENCIES is off.
> 
> I think you are asking the commit message to do more work than it
> needs to, and to answer questions that no one just trying to
> understand the patch would ask. :)

Yeah, when writing out the full discussion I was awfully tempted to go
with your simplified explanation. ;)

In fact, it's the later commits that really make use of this
explanation when they add lines.

> Wouldn't it be simpler to put the ground rules in a comment or a
> document somewhere under Documentation/ where they can be easily
> found?

I think a comment in the Makefile might make sense (especially if it
introduces the section as "and this is the place to put weird
target-specific cppflags and dependencies"). Would you mind taking a
stab at writing it? I feel like the explanation I wrote in the commit
message ended up quite dense and possibly not very informative, and a
fresh brain and fingers might turn out something a little more
reasonable.

-Peff
