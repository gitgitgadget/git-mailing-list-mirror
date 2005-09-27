From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH] Added an option to cvsimport to specify email domain
Date: Tue, 27 Sep 2005 08:54:16 -0400
Organization: Cobite, Inc
Message-ID: <1127825656.30421.15.camel@gandalf.cobite.com>
References: <u5tzmqp8fzx.fsf@lysator.liu.se>
	 <7vhdcw661g.fsf@assigned-by-dhcp.cox.net>
	 <20050914193457.GE2936@pasky.or.cz> <200509270834.55486.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 14:57:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKEyU-0003EE-Bq
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 14:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVI0MyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 08:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbVI0MyT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 08:54:19 -0400
Received: from iris.cobite.com ([208.222.83.2]:20450 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S964917AbVI0MyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 08:54:18 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id CD10E985E5; Tue, 27 Sep 2005 08:53:47 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00424-01; Tue, 27 Sep 2005 08:53:47 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id 96E0F987DD; Tue, 27 Sep 2005 08:53:47 -0400 (EDT)
Received: from gandalf.cobite.com (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id C9824985E5; Tue, 27 Sep 2005 08:53:46 -0400 (EDT)
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200509270834.55486.snake@penza-gsm.ru>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9393>

On Tue, 2005-09-27 at 08:34 +0400, Alexey Nezhdanov wrote:
> (Re-post. Sorry for any inconvenience.)
> On September 14, 2005 23:34 Petr Baudis wrote:
> > Dear diary, on Wed, Sep 07, 2005 at 09:18:03PM CEST, I got a letter
> > where Junio C Hamano <junkio@cox.net> told me that...
> >
> > > David K?.A?Negedal <davidk@lysator.liu.se> writes:
> > > > The authorship info in commits created by git-cvsimport-script
> > > > only contains the username of the CVS committer.  This patch
> > > > adds a flag -e <domain> to git-cvsimport-script that makes it
> > > > possible to specify an email domain that is added to all email
> > > > addresses in the commit "author" and "committer" fields.
> > > >
> > > > ---
> > > > I have stopped using cvsimport, because cvsps seems to produce bad
> > > > output on the repository I'm using it with, but I had already prepared
> > > > this patch.
> > >
> > > Hmph.  One reason the original implementation did not do this is
> > > because Linus and other people wanted to have a repeatability,
> > > so making this an optional thing is good, but if we go this
> > > route, I think if it would be nicer to have a --author-map
> > > option that lets you feed a list of:
> > >
> > >     <author> ==> "A U Thor <author@author.dom>"
> > >
> > > mappings, instead of a single -e, which essentially does not add
> > > much information to the result.
> > >
> > > I take that your oob comment indicates that you do not have much
> > > incentive/inclination to further hack on this, so I am not
> > > asking you to do the above even if you find my suggestion
> > > worthwhile.
> >
> > Various tools use CVSROOT/users to map usernames to realname <email>.
> > I actually wanted to send a patch, looked at the cvsimport script and
> > got totally scared away (at least for now)... ;-)
> git uses cvsps output to determine authorship. Do you think if this problem 
> should be solved on cvsps side? It should be relatively easy IMHO.
> David, can you add another key to output CVSROOT/users mapping result instead 
> of usernames if available?

I apologize that I probably won't have time to look at this right now...

David
