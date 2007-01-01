From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 20:12:20 -0500
Message-ID: <20070101011220.GB15537@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org> <1167608858759-git-send-email-bfields@fieldses.org> <11676088582634-git-send-email-bfields@fieldses.org> <7vd55zd1nm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 02:12:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Biz-0004LF-SI
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 02:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbXAABMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 20:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbXAABMW
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 20:12:22 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60473 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbXAABMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 20:12:21 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1Biu-0004aw-8J; Sun, 31 Dec 2006 20:12:20 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd55zd1nm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35717>

On Sun, Dec 31, 2006 at 04:35:41PM -0800, Junio C Hamano wrote:
> bfields@fieldses.org writes:
> 
> >  git pull, git pull origin::
> > -	Fetch the default head from the repository you cloned
> > -	from and merge it into your current branch.
> > +	Update the remote tracking brances for the repository
> > +	you cloned from, then merge one of them into your
> > +	current branch.  Normally the branch merged in is
> > +	the HEAD of the remote repository, when your master
> > +	branch is checked out.  When on another branch,
> > +	the (alphabetically) first branch from the remote
> > +	repository is merged in.  These defaults can be modified
> > +	using the branch and remote sections of the repository
> > +	configuration; see gitlink:git-repo-config[1] for details.
> 
> I think documenting this is wrong.  At least we should say "do
> not be lazy and say 'git pull' or 'git pull origin' without
> configuring what branch you are interested in when on a branch
> you created yourself".  Later, people can supply patches to make
> that configuration easier.

Yeah, OK, I'll admit I felt silly writing that; so for now, how about
just omitting mention of the current behavior and saying instead
something like this?:

	"....  Normally the branch merged in is
	the HEAD of the remote repository, when your master
	branch is checked out.  For branches other than master,
	you can choose the default remote branch to merge using the
	branch.<name>.remote and branch.<name>.merge options; see
	gitlink:git-repo-config[1] for details."

--b.
