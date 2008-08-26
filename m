From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 11:27:36 -0700
Message-ID: <20080826182736.GL26523@spearce.org>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <20080826172410.GJ26523@spearce.org> <7v1w0bab1c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	andi@firstfloor.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3HW-0007JU-UJ
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369AbYHZS1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbYHZS1h
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:27:37 -0400
Received: from george.spearce.org ([209.20.77.23]:39895 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbYHZS1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:27:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E61B738375; Tue, 26 Aug 2008 18:27:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v1w0bab1c.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93795>

Junio C Hamano <gitster@pobox.com> wrote:
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

Perhaps users should just do:

  git config --global alias.unmerged 'ls-files -u'

?

Ok, well, maybe git.c should do that for you as a builtin.

-- 
Shawn.
