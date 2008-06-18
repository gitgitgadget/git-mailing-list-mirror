From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Add SVN->Git conversion example to documentation
Date: Wed, 18 Jun 2008 03:55:55 +0300
Message-ID: <20080618005555.GB5930@jolt.modeemi.cs.tut.fi>
References: <20080614215812.GA28574@zakalwe.fi> <7viqw74phb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 02:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8lzv-0006Q6-1U
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 02:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318AbYFRA4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 20:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758180AbYFRA4h
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 20:56:37 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:60608 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757356AbYFRA4g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 20:56:36 -0400
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id 3128822C1;
	Wed, 18 Jun 2008 03:56:27 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 28251-09-4; Wed, 18 Jun 2008 03:56:26 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 3C1B222BF;
	Wed, 18 Jun 2008 03:56:26 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 0592F22201;
	Wed, 18 Jun 2008 03:55:56 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id DD1B7501EE; Wed, 18 Jun 2008 03:55:55 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7viqw74phb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85350>

On Tue, Jun 17, 2008 at 04:21:36PM -0700, Junio C Hamano wrote:
> > -git-svn is a simple conduit for changesets between Subversion and git.
> > -It is not to be confused with linkgit:git-svnimport[1], which is
> > -read-only.
> > +git-svn is a simple bidirectional conduit for changesets between
> > +Subversion and git. It is used to develop projects with Git tools,
> > +but commit changes to a Subversion repository. It can also be used to
> 
> That is correct but doesn't the above give a false impression that commits
> are only made on subversion side and never on git side?

Hmm.. I'll try to make it more explicity. Will send another patch soon.

> > +convert a Subversion repository to a Git repository. It should not
> > +be confused with linkgit:git-svnimport[1], which does Subversion to
> > +Git conversion, but not the other direction.
> 
> We do not ship nor document svnimport anymore and linkgit: there is
> actively wrong.  People seem to be confused with ancient documents still
> floating on the Web that talk about svnimport, and I think it is a good
> idea to try to clear the confusion here, but perhaps...

OK, I will not mention svnimport in the next patch.

> 	... with the deprecated `git-svnimport`, which was used for
> 	one-way conversion from Subversion to git.
> 
> > @@ -520,6 +523,38 @@ have each person clone that repository with 'git clone':
> >  	git-svn rebase
> >  ------------------------------------------------------------------------
> >  
> > +CONVERTING A SUBVERSION REPOSITORY TO A GIT REPOSITORY
> > +------------------------------------------------------
> > +
> > +When converting a Subversion repository to a Git repository
> > +--no-metadata removes "git-svn-id:" comments from the log.
> > +-A option is used to convert SVN pseudonyms to real names
> 
> Anything that user usually would type on the command line it is preferred
> to typeset with `quoted like this`, so "`--no-metadata`" and "`-A` option".
> 
> It is not `--no-metadata` "removes".  git-svn adds cruft because it wants
> to use it for bidi operation, but --no-metadata prevents it from doing
> so.

OK

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
