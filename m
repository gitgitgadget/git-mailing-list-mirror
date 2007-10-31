From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito and remote#branch, was Re: [PATCH] Git homepage: remove
	all the references to Cogito
Date: Wed, 31 Oct 2007 18:09:51 +0100
Message-ID: <20071031170951.GR18279@machine.or.cz>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz> <Pine.LNX.4.64.0710161139530.25221@racer.site> <2c6b72b30710161516j5c029847r1acb3ce2d88344a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 18:10:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InH54-00079X-Tw
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 18:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680AbXJaRJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 13:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756600AbXJaRJy
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 13:09:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38709 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645AbXJaRJx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 13:09:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 285DB5A4A9; Wed, 31 Oct 2007 18:09:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2c6b72b30710161516j5c029847r1acb3ce2d88344a1@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62849>

On Wed, Oct 17, 2007 at 12:16:25AM +0200, Jonas Fonseca wrote:
> On 10/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 16 Oct 2007, Petr Baudis wrote:
> > > I'm not sure this is good idea, Cogito is still quite frequently used
> > > and it should be documented that it exists.
> >
> > I agree.  But maybe it could be marked as unmaintained?  Maybe someone
> > steps up to maintain it.  Or, even better, comes up with a list of "this
> > is what I like do regularly with cogito, but there's no easy way with core
> > git" issues.
> 
> One thing that I occasionally miss is
> 
>   cg-export /path/to/directory/
> 
> And yes, I know it can be accomplished via "obscurities" like
> git-archive+tar (or worse git-checkout-index) but I think having
> an easy way to checkout to a directory could be great (and possibly
> with the ability to apply substitutions with the recent discussion).
> 
> Else, I am really looking forward for the option parser work to provide
> an easy way to list options. I found it very useful with Cogito.
> Also, most of the "status" commands in Cogito seemd to provide a richer
> default output geared towards human consumption. For example stuff like
> git-branch -v and git remote -v flags would have been the default for
> Cogito ... I think.

A "me too" mail for once...

I fully second this. cg-export is one of the Cogito commands I still use
frequently. I wonder if there is any obvious piece of Git command set we
could glue this on (so that we don't introduce Yet Another Command)... I
think cg-export is better-named here than git-archive. ;-)

And some command in Git to easily get the equivalent of cg-status -g
output is something I probably miss the most in Git now. (Originally I
was about to say that I just miss an equivalent of cg-status, but
thinking about it, most of the time I'm interested only in either -g
(long branch info) or -w (git status output)).

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
