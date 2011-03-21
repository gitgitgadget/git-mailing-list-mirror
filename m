From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Mon, 21 Mar 2011 23:07:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1103212302000.1561@bonsai2>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	lee.marlow@gmail.com, markus.heidelberg@web.de, szeder@ira.uka.de,
	spearce@spearce.org, bebarino@gmail.com, ted@tedpavlic.com,
	tlikonen@iki.fi, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1nG6-0002bB-FP
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 23:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab1CUWH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 18:07:26 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:54616 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754567Ab1CUWHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 18:07:25 -0400
Received: (qmail invoked by alias); 21 Mar 2011 22:07:19 -0000
Received: from pD9EB132E.dip0.t-ipconnect.de (EHLO noname) [217.235.19.46]
  by mail.gmx.net (mp041) with SMTP; 21 Mar 2011 23:07:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jibc8IlgjWU9YVPMubW5zSsphVZJed+xxAKW8zi
	IHWFgUUSVhJX0R
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vhbawno11.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169679>

Hi,

On Mon, 21 Mar 2011, Junio C Hamano wrote:

> Jakob Pfender <jpfender@elegosoft.com> writes:
> 
> > Enable bash completion for "git help <alias>", analogous to "git
> > <alias>", which was already implemented.
> >
> > Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
> > ---
> >  contrib/completion/git-completion.bash |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash
> > b/contrib/completion/git-completion.bash
> > index 893b771..f9a74d3 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1506,7 +1506,7 @@ _git_help ()
> >  		;;
> >  	esac
> >  	__git_compute_all_commands
> > -	__gitcomp "$__git_all_commands
> > +	__gitcomp "$__git_all_commands $(__git_aliases)
> >  		attributes cli core-tutorial cvs-migration
> >  		diffcore gitk glossary hooks ignore modules
> >  		repository-layout tutorial tutorial-2
> 
> This patch may not be _wrong_ per-se, but it it useful in practice?
> 
> I dunno.
> 
> Don't people usually use aliases so that they do not have to type long
> command names that would need completion?

Yes. And if you use a lot of aliases, or a lot of machines with evolving 
aliases, the easiest way to inspect the alias is "git help <alias>". Not 
seeing it completed is an unexpected behavior.

Git is moving the right direction in terms of user-friendliness, e.g. by 
DWIMming "git checkout <remote branch>". Adding this completion would be 
a small step in the same direction, not more.

Ciao,
Johannes
