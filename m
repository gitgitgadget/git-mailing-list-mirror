From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Thu, 4 Sep 2008 00:23:50 +0200
Message-ID: <20080903222350.GC10360@machine.or.cz>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <20080826172410.GJ26523@spearce.org> <7v1w0bab1c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	andi@firstfloor.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:25:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0me-0000cW-Ik
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbYICWXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 18:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbYICWXz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 18:23:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56914 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbYICWXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 18:23:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 60BF2393A2E4; Thu,  4 Sep 2008 00:23:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w0bab1c.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94865>

On Tue, Aug 26, 2008 at 11:25:35AM -0700, Junio C Hamano wrote:
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

I started on a patch, but frankly, I hate it. Adding such a filtering to
git-status is quite invasive, while I believe that it's simply not worth
it - I have yet to encounter a situation with git when simply looking at
either git diff or plain git status is impractical to check which files
need to be merged yet, so I don't want to expend energy on a patch which
is going to be ugly and useless by my belief.

If you do insist that we need this functionality, can you please just
drop the git ls-files bit from the patch, or should I resend it?

Thanks,

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
