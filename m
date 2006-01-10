From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] glossary: explain "master" and "origin"
Date: Tue, 10 Jan 2006 22:40:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601102238570.802@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0601102226130.649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060110213645.GF13450@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jan 10 22:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwREP-0002Lj-AA
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 22:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWAJVki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWAJVki
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 16:40:38 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60613 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932359AbWAJVki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 16:40:38 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 11E0B141370; Tue, 10 Jan 2006 22:40:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 04F53FDA;
	Tue, 10 Jan 2006 22:40:37 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id DBA1394A;
	Tue, 10 Jan 2006 22:40:36 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 83B8B141370; Tue, 10 Jan 2006 22:40:36 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060110213645.GF13450@fieldses.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14460>

Hi,

On Tue, 10 Jan 2006, J. Bruce Fields wrote:

> On Tue, Jan 10, 2006 at 10:26:46PM +0100, Johannes Schindelin wrote:
> > +origin::
> > +	The default upstream branch. Most projects have one upstream 
> > +        project which is tracked, and augmented with local changes which
> > +        eventually get merged back. You never commit to this branch,
> > +	unless you are maintaining the upstream project.
> 
> The last line is somewhat confusing--a naive reader might take it to
> mean that as an upstream maintainer it would make sense to commit to a
> branch named "origin".  How about something like this?
> 
> 	"The default upstream branch.  Most projects have one upstream
> 	project which they track.  This is is the branch used for
> 	tracking that project.  New updates from upstream will be
> 	fetched into this branch, but you should never commit to it
> 	yourself."

It is probably safer. Note: I actually commit to the origin branch in one 
of my projects, and I follow it directly by a "git push origin".

Ciao,
Dscho

P.S.: I just noted that some of the tabs were turned into spaces. Does 
asciidoc mind?
