From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 03:08:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710310304180.4362@racer.site>
References: <Pine.LNX.4.64.0710280000240.4362@racer.site>
 <20071029174000.GA4449@efreet.light.src> <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com>
 <20071031014347.GB23274@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 04:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3xy-0008EG-Ip
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 04:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbXJaDJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 23:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbXJaDJs
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 23:09:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:34192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750875AbXJaDJr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 23:09:47 -0400
Received: (qmail invoked by alias); 31 Oct 2007 03:09:45 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 31 Oct 2007 04:09:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KgiF17BiK8rKj/cKQb1Jlkb4O23xdOrwxGY2AOF
	jSJkLKlhsmAv2A
X-X-Sender: gene099@racer.site
In-Reply-To: <20071031014347.GB23274@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62787>

Hi,

On Tue, 30 Oct 2007, Jeff King wrote:

> Anyway, to recap (my impression of) the discussion leading up to this:
>   - the cogito feature is useful
>   - the cogito syntax does not allow for multiple branches to be
>     specified

Here somebody else than me (IIRC Junio) proposed this syntax:

	git clone --track <name> [--track <name2>] <url>

Nobody was interested enough to implement it.

I then proposed delimiting with spaces, since they were _not part of a 
URL_:

	git clone "<url> <name> <name2>"

but some people insisted on "#", which I pointed out (several times!) is a 
no go, and I actually provided reasons for that.

>   - one such syntax proposed was git://foo.tld/bar.git#blue,red
>   - one problem with that syntax is that comma is a valid character
>     in the branch name, and '#' is a valid character in the repo name
>   - one proposed solution was that '#' and ',' when used as data should
>     be URL-encoded
>   - flamefest begin
> 
> So I think nobody disagrees that such a feature is useful; there is
> disagreement about the syntax.

Probably there is not enough need, too, and the discussion will peter out 
again, without anybody letting some code talk, and I will not make the 
mistake again of reviving this discussion.  Promise.

Ciao,
Dscho
