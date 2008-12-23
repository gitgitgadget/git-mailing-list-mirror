From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2008, #03; Sun, 21)
Date: Tue, 23 Dec 2008 11:38:13 -0500
Message-ID: <20081223163811.GA25658@coredump.intra.peff.net>
References: <7vr641pvid.fsf@gitster.siamese.dyndns.org> <20081223120534.GA21633@coredump.intra.peff.net> <alpine.DEB.1.00.0812231725270.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 17:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFAIC-00042d-Ta
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 17:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbYLWQiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbYLWQiS
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 11:38:18 -0500
Received: from peff.net ([208.65.91.99]:2675 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbYLWQiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 11:38:17 -0500
Received: (qmail 3060 invoked by uid 111); 23 Dec 2008 16:38:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 23 Dec 2008 11:38:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2008 11:38:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812231725270.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103832>

On Tue, Dec 23, 2008 at 05:26:01PM +0100, Johannes Schindelin wrote:

> > I haven't had much time to really look at this closely, and I probably 
> > won't for another week or so due to the holidays. But from my cursory 
> > examination, I think I want to propose something that is a bit 
> > different.
> 
> Could you be a bit more, like, specific, please?

The way that GIT_NOTES_REF and core.notesref work aren't what I had in
mind. I imagined something more amenable to having lots of different
metadata notes.  Refer to the other messages I have written on "naming".

I don't want to hold up progress, so if people want those patches in
"next", then go for it. What I really meant by my email was that I think
my suggested changes might be simpler to see as a re-roll rather than
patches on top, but since I can't work on them for a while, I didn't
want Junio to take silence as "OK, nobody has complained, so it's time
for this to graduate to next." But again, if people are ready to start
playing with this and building on top of it, then I don't want to stand
in the way.

-Peff
