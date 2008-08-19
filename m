From: Petr Baudis <pasky@suse.cz>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 22:33:53 +0200
Message-ID: <20080819203353.GG10544@machine.or.cz>
References: <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org> <20080819175220.GA10142@coredump.intra.peff.net> <alpine.LNX.1.00.0808191407160.19665@iabervon.org> <20080819184525.GA17691@coredump.intra.peff.net> <alpine.LNX.1.00.0808191448530.19665@iabervon.org> <20080819190159.GB17943@coredump.intra.peff.net> <alpine.LNX.1.00.0808191523050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 22:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVXvU-0004jh-3R
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 22:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbYHSUeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758038AbYHSUeF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 16:34:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35935 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbYHSUeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 16:34:04 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4999B3939B48; Tue, 19 Aug 2008 22:33:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0808191523050.19665@iabervon.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92921>

On Tue, Aug 19, 2008 at 03:42:01PM -0400, Daniel Barkalow wrote:
> On Tue, 19 Aug 2008, Jeff King wrote:
> Ah, okay. I feel like the main application for this is "I typed some git 
> diff command, started looking at it, my phone rang, I took the call, and 
> now I don't know what I'm looking at, and the pager hides the command 
> line, but quitting the pager loses my place." At least, that's the 
> situation I'm often in.

Press ctrl-z. ;-)

> > > Yeah, that's why I think that format-patch should work on content that you 
> > > haven't committed, generating something you can dump right into an email 
> > > (with the --- and diffstat that you'd get if you actually did commit and 
> > > use format-patch now).

Hmm, and why don't you actually do the commit after all? You can compose
all the details within the commit and you can do the commit on a
separate branch or git reset HEAD^ afterwards if you don't want to keep
it around.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
