From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 15:04:12 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808261455010.19665@iabervon.org>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <20080826172410.GJ26523@spearce.org> <7v1w0bab1c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	andi@firstfloor.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3rs-0003SX-NO
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760405AbYHZTEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760140AbYHZTEP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:04:15 -0400
Received: from iabervon.org ([66.92.72.58]:50289 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759768AbYHZTEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:04:14 -0400
Received: (qmail 5822 invoked by uid 1000); 26 Aug 2008 19:04:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2008 19:04:12 -0000
In-Reply-To: <7v1w0bab1c.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93799>

On Tue, 26 Aug 2008, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Petr Baudis <pasky@suse.cz> wrote:
> >> git <tab><tab> still shows way too many commands, some of them
> >> are clearly plumbing. This patch hides the plumbing commands
> >> liberally (that is, in special cases, users still might want to
> >> call one of the hidden commands, a *normal* workflow should never
> >> involve these, though - and if it does, we have a UI problem anyway).
> >> 
> >> Signed-off-by: Petr Baudis <pasky@suse.cz>
> >
> > Acked-by: Shawn O. Pearce <spearce@spearce.org>
> >
> > Though I use git ls-remote at least once every other day to see
> > what branches are available on my egit/spearce.git fork.  Its ok,
> > I guess I can type a few extra characters...
> 
> Revision-requested-by: me
> 
> Unless/until we have an easy way to obtain the information "git-ls-files
> -u" gives during conflict resolution, ls-files should stay on the list of
> commonly used commands.

Doesn't "git status" tell you that? Or do you want the extra info from the 
implicit --stage?

	-Daniel
*This .sig left intentionally blank*
