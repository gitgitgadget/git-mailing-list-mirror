From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/5] Builtin "git remote"
Date: Thu, 28 Feb 2008 21:17:43 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802282104500.19665@iabervon.org>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:18:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUupM-00023v-Sg
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbYB2CRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 21:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757363AbYB2CRp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:17:45 -0500
Received: from iabervon.org ([66.92.72.58]:42404 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbYB2CRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:17:45 -0500
Received: (qmail 14190 invoked by uid 1000); 29 Feb 2008 02:17:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Feb 2008 02:17:43 -0000
In-Reply-To: <7vwsoofrue.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75498>

On Thu, 28 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It also demonstrates that format-patch --cover-letter should default to -M
> > for the diffstat (search for "git-remote.perl"...).
> 
> It probably should inherit the settings for the primary part.
> You did generate the series with -M, especially [PATCH 4/5],
> didn't you?

Obviously not the output_format, but everything else, I assume? Easy 
enough to pass the main diff options into make_cover_letter() and use them 
to initialize the diff options there.

> > Johannes Schindelin (5):
> >       path-list: add functions to work with unsorted lists
> >       parseopt: add flag to stop on first non option
> >       Test "git remote show" and "git remote prune"
> >       Make git-remote a builtin
> >       builtin-remote: prune remotes correctly that were added with --mirror
> 
> Also I wish the default indentation were not that deep, and also
> line-wrapped at around 72-76 columns.

Only for the cover letter, and not shortlog in general, I assume? It 
should be easy to set the struct shortlog fields to whatever suits your 
taste. Making it configurable (without getting tangled in other option 
parsing) is trickier, though.

	-Daniel
*This .sig left intentionally blank*
