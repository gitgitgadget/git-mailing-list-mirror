From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Understanding and improving --word-diff
Date: Wed, 10 Nov 2010 01:05:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1011100102540.2226@bonsai2>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl> <20101109220136.GA5617@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 01:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFyCT-0003WS-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 01:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab0KJAGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 19:06:00 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:57532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751379Ab0KJAF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 19:05:59 -0500
Received: (qmail invoked by alias); 10 Nov 2010 00:05:57 -0000
Received: from pD9EB2298.dip0.t-ipconnect.de (EHLO noname) [217.235.34.152]
  by mail.gmx.net (mp068) with SMTP; 10 Nov 2010 01:05:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GH3B7yArGy8Sdf2xFruuK5xsCsEOYyPN/gTzO1l
	nYNq+eCCkH+sxx
X-X-Sender: gene099@bonsai2
In-Reply-To: <20101109220136.GA5617@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161109>

Hi,

On Tue, 9 Nov 2010, Jeff King wrote:

> On Mon, Nov 08, 2010 at 04:16:01PM +0100, Matthijs Kooijman wrote:
> 
> > E.g., I would like to see:
> > 
> > -a <r>b</r> c
> > +a <g>x</g> c
> > 
> > Unfortunately, all --word-diff types currently departs from line-based 
> > - and + lines and show the new version of the file with the changed 
> > words (both old and new versions) shown inline, marked with coloring 
> > or {- ...  -} kind of syntax. E.g., with --word-diff=color, the above 
> > would look like:
> > 
> > a <r>b</r><g>x</g> c
> > 
> > Personally, I think that the first example above is easier to read 
> > than the second one (at least for diffs of code).
> 
> Yeah, as you figured out, word diff is really about formats that aren't 
> line oriented.

Not really correct. While the _current_ way to show word diffs is 
imitating GNU wdiff, the internal data structure does allow for more 
sophisticated output.

Ciao,
Dscho

P.S.: Peff, I hope you're fine with me responding to the first sentence 
only. After all, you know that my attention span is 7.2 seconds.

Some people taught me to put a smiley after such a statement, so: ;-)
