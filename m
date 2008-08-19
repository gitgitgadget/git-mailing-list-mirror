From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 14:39:22 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808191407160.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org> <20080819175220.GA10142@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVW9D-0001fm-3t
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbYHSSjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756966AbYHSSjZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:39:25 -0400
Received: from iabervon.org ([66.92.72.58]:38025 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756935AbYHSSjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:39:23 -0400
Received: (qmail 981 invoked by uid 1000); 19 Aug 2008 18:39:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2008 18:39:22 -0000
In-Reply-To: <20080819175220.GA10142@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92896>

On Tue, 19 Aug 2008, Jeff King wrote:

> On Mon, Aug 18, 2008 at 08:22:19PM -0700, Junio C Hamano wrote:
> 
> > I do not know if I like the end result, but here is a patch to make the
> > traditional a/ and b/ prefix more mnemonic.
> 
> Hmm. Something deep in my gut doesn't like this, just because I like the
> fact that no matter how I prepare a diff (and I do tend to do it
> different ways and post to the mailing list) it always ends up the same.
> For example, I sometimes "hand-generate" patch messages meant to be
> applied by git-am by doing a diff between the working tree and index and
> pasting the result into an email. It just feels a bit wrong for it not
> to be the exact output I would get from commiting and running
> format-patch.

Hmm... everybody who doesn't like it is concerned about scripts and 
sending it places, while the people who like it seem to be interested in 
looking at the output. Maybe there should be an option that controls it, 
with the default being to use -a+b for pipelines and informational stuff 
for pager?

It seems to me like, in output for user consumption, the information is 
useful, while in output for non-user consumption, the information is 
overly personal. But that's easy enough to detect...

(For that matter, maybe format-patch should be able to handle uncommitted 
changes, and should hide what it did? What's with all these people faking 
format-patch output with other commands, rather than having format-patch 
actually generate suitable output in their situations?)

	-Daniel
*This .sig left intentionally blank*
