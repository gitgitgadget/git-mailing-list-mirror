From: Jeff King <peff@peff.net>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 14:45:25 -0400
Message-ID: <20080819184525.GA17691@coredump.intra.peff.net>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org> <20080819175220.GA10142@coredump.intra.peff.net> <alpine.LNX.1.00.0808191407160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWEe-0003oV-7T
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbYHSSp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbYHSSp2
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:45:28 -0400
Received: from peff.net ([208.65.91.99]:1802 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbYHSSp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:45:28 -0400
Received: (qmail 3944 invoked by uid 111); 19 Aug 2008 18:45:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 14:45:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 14:45:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0808191407160.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92897>

On Tue, Aug 19, 2008 at 02:39:22PM -0400, Daniel Barkalow wrote:

> Hmm... everybody who doesn't like it is concerned about scripts and 
> sending it places, while the people who like it seem to be interested in 
> looking at the output. Maybe there should be an option that controls it, 
> with the default being to use -a+b for pipelines and informational stuff 
> for pager?

To clarify my statement: no, I'm concerned about looking at it. That is,
I don't think it will break scripts, but I think the output is
potentially confusing to humans.

But like I said before, it's just my intuition; I don't have real facts
to back it up, so feel free to ignore.

> (For that matter, maybe format-patch should be able to handle uncommitted 
> changes, and should hide what it did? What's with all these people faking 
> format-patch output with other commands, rather than having format-patch 
> actually generate suitable output in their situations?)

I do it because I haven't actually committed the content.  I dump the
diff right into an email I'm already writing.

-Peff
