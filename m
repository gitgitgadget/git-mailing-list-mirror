From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-push.txt: describe how to default to pushing only
	current branch
Date: Sat, 14 Mar 2009 17:46:03 -0400
Message-ID: <20090314214603.GA20418@sigill.intra.peff.net>
References: <20090313164941.GA16504@sigill.intra.peff.net> <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com> <7vd4cjc3da.fsf@gitster.siamese.dyndns.org> <20090313164941.GA16504@sigill.intra.peff.net> <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com> <20090314203434.GA15444@coredump.intra.peff.net> <7veiwzajbc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 22:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Libii-00086W-MB
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 22:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759937AbZCNVqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 17:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759926AbZCNVqG
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 17:46:06 -0400
Received: from peff.net ([208.65.91.99]:45452 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759906AbZCNVqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 17:46:04 -0400
Received: (qmail 15358 invoked by uid 107); 14 Mar 2009 21:46:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 14 Mar 2009 17:46:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Mar 2009 17:46:03 -0400
Content-Disposition: inline
In-Reply-To: <7veiwzajbc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113269>

On Sat, Mar 14, 2009 at 02:25:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Actually, looking closer, the information seems to be lost entirely.
> > Asciidoc renders this to <literal> in the XML, but docbook seems to
> > throw it away when converting to a manpage. In theory it's possible to
> > apply our own xsl style to turn this into something else, and I think
> > that is a better solution than just trying to fix this one spot.
> 
> When I check the asciidoc output for manpages (which I rarely do), I often
> render it to Postscript to see the typesetting.  I guess not many people
> consider manpages are for printing anymore but are solely for monospaced
> terminal consumption these days.

How do you render it? From the XML, or from the roff? Because if I am
reading it right (which it is entirely possible that I am not), the
information is lost in the roff version. And that is the version I would
expect people to be looking at (via man -Tps, or just plain man).

-Peff
