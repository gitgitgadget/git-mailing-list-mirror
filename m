From: Jeff King <peff@peff.net>
Subject: Re: git branch: multiple --merged and --no-merged options?
Date: Sat, 23 Mar 2013 04:13:33 -0400
Message-ID: <20130323081333.GC29768@sigill.intra.peff.net>
References: <87fvzwmp23.fsf@59A2.org>
 <20130322175034.GB29011@sigill.intra.peff.net>
 <8738vmu92l.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Sat Mar 23 09:14:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJJaq-0008KB-EY
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 09:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab3CWINp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 04:13:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36651 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab3CWINm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 04:13:42 -0400
Received: (qmail 8771 invoked by uid 107); 23 Mar 2013 08:15:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Mar 2013 04:15:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Mar 2013 04:13:33 -0400
Content-Disposition: inline
In-Reply-To: <8738vmu92l.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218898>

On Fri, Mar 22, 2013 at 09:46:42PM -0500, Jed Brown wrote:

> > On Fri, Mar 15, 2013 at 02:38:12PM -0500, Jed Brown wrote:
> >>   $ git branch --no-merged master --merged next
> >
> > Yeah, sadly that does not work, as we use the same slot for the flag and
> > store only one of the two (and we also allow only one "--merged" head,
> > even though you could in theory want to know "merged to X, or merged to
> > Y").
> 
> Hmm, I would have said conjunction (AND) was more natural than
> disjunction (OR). If we add support for multiple '--merged' and
> '--no-merged', do we expect to eventually have a full query grammar?

Yeah, you might want either. I was just thinking along the lines of the
existing --contains and --points-at (which only tag, not branch, knows
about), both of which OR multiple items. I think you'd want to flesh out
some use cases before deciding.

-Peff
