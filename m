From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 14:57:04 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808191448530.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org> <20080819175220.GA10142@coredump.intra.peff.net> <alpine.LNX.1.00.0808191407160.19665@iabervon.org> <20080819184525.GA17691@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWPF-00086P-Qc
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYHSS5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbYHSS5H
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:57:07 -0400
Received: from iabervon.org ([66.92.72.58]:38325 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbYHSS5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:57:05 -0400
Received: (qmail 2342 invoked by uid 1000); 19 Aug 2008 18:57:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2008 18:57:04 -0000
In-Reply-To: <20080819184525.GA17691@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92902>

On Tue, 19 Aug 2008, Jeff King wrote:

> On Tue, Aug 19, 2008 at 02:39:22PM -0400, Daniel Barkalow wrote:
> 
> > Hmm... everybody who doesn't like it is concerned about scripts and 
> > sending it places, while the people who like it seem to be interested in 
> > looking at the output. Maybe there should be an option that controls it, 
> > with the default being to use -a+b for pipelines and informational stuff 
> > for pager?
> 
> To clarify my statement: no, I'm concerned about looking at it. That is,
> I don't think it will break scripts, but I think the output is
> potentially confusing to humans.

Humans being recipients of emails, or humans being the users who typed the 
command? Unless you're cut-and-pasting out of a pager (which never works 
well for me if it's long enough to include diff headers, context, and some 
change), recipients of emails would get what scripts get. (I personnaly do 
that as "git diff > temp.patch" and read temp.patch into my mailer; this 
doesn't trigger starting a pager, and wouldn't trigger the default to be 
informative prefixes.)

> But like I said before, it's just my intuition; I don't have real facts
> to back it up, so feel free to ignore.
> 
> > (For that matter, maybe format-patch should be able to handle uncommitted 
> > changes, and should hide what it did? What's with all these people faking 
> > format-patch output with other commands, rather than having format-patch 
> > actually generate suitable output in their situations?)
> 
> I do it because I haven't actually committed the content.  I dump the
> diff right into an email I'm already writing.

Yeah, that's why I think that format-patch should work on content that you 
haven't committed, generating something you can dump right into an email 
(with the --- and diffstat that you'd get if you actually did commit and 
use format-patch now).

	-Daniel
*This .sig left intentionally blank*
