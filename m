From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/git-submodule.txt: Further clarify the
	description
Date: Fri, 18 Jul 2008 15:36:44 +0200
Message-ID: <20080718133644.GQ10151@machine.or.cz>
References: <20080717121813.GC10151@machine.or.cz> <20080717122911.32334.73465.stgit@localhost> <7v4p6ofedl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heikki Orsila <shdl@zakalwe.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 15:37:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJq9f-000068-AL
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 15:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbYGRNgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 09:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbYGRNgs
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 09:36:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38443 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259AbYGRNgr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 09:36:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B78C12C4C02A; Fri, 18 Jul 2008 15:36:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4p6ofedl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89039>

On Thu, Jul 17, 2008 at 01:24:22PM -0700, Junio C Hamano wrote:
> Your lines are getting overlong to be easily quoted and commented...

I will watch for that.

> Petr Baudis <pasky@suse.cz> writes:
> > +....  In case you want to merge the project
> > +histories, possibly make local modifications within the tree, but also do not
> > +mind that your repository will bulk up with all the contents of the other
> > +project, consider adding a remote for the other project and using the 'subtree'
> > +merge strategy instead of setting up a submodule.
> 
> I'd suggest rephrasing "do not mind" to something a lot less nagative.
> The user decides to merge because both histories *are* relevant and at
> that point there is no _minding_ anymore.  If you want to have them, you
> not only "do not mind to have" them but you positively "want" them.
> 
> On the other hand, a situation where you would want to use submodules is
> when not necessarily all users of the superproject would want to have all
> submodules cloned nor checked out.  This needs to be stressed with equal
> weight as the above sentence in this "contrasting merged histories and
> submodules" paragraph.  With that explained clearly upfront, it would
> become easier for the readers to understand why you can choose not to even
> update nor fetch submodules you are not interested in.

You are right. I have tried to reword the sentence to fix these issues.

> > +Submodules are composed from a special kind of tree entry (so-called `gitlink`)
> > +in the main repository that refers to a particular commit object within
> 
> Do we have to say "special"?  Is a gitlink any more special than blob and
> tree entries are?  It tends to be rarer, it came later, but I do not think
> there is anything special from the end user's point of view.

Also the parenthesis look ugly, so I have reworded this to a simpler
formulation.

> >  checked out and at appropriate revision in your working tree. You can inspect
> >  the current status of your submodules using the 'submodule' subcommand and get
> > +an overview of the changes 'update' would perform using the 'summary'
> > +subcommand.
> 
> Sorry, cannot parse the last three lines...

The mention of 'update' is confusing, and it was overally imprecise.
(I think that in general, the summary/status distinction was not a wise
UI decision.)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
