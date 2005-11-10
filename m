From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 00:56:54 +0100
Message-ID: <200511110056.54476.Josef.Weidendorfer@gmx.de>
References: <1124832796.23795.9.camel@dv> <200511110026.18324.Josef.Weidendorfer@gmx.de> <20051110234029.GE30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 00:59:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaMJv-0000ec-7P
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 00:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVKJX67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 18:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKJX67
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 18:58:59 -0500
Received: from pop.gmx.net ([213.165.64.20]:14569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932226AbVKJX66 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 18:58:58 -0500
Received: (qmail invoked by alias); 10 Nov 2005 23:58:57 -0000
Received: from p5496BEC1.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.190.193]
  by mail.gmx.net (mp019) with SMTP; 11 Nov 2005 00:58:57 +0100
X-Authenticated: #352111
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.2
In-Reply-To: <20051110234029.GE30496@pasky.or.cz>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11538>

On Friday 11 November 2005 00:40, Petr Baudis wrote:
> Dear diary, on Fri, Nov 11, 2005 at 12:26:18AM CET, I got a letter
> where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> > On Tuesday 23 August 2005 23:33, Pavel Roskin wrote:
> > > Hello!
> > > 
> > > This patch changes cg-pull so that if the branch is not specified, it
> > > takes origin's .git/HEAD without first trying .git/refs/heads/master.
> > > This removes preferential treatment of the "master" branch, allowing the
> > > upstream to use another name for the default branch.  To get the master
> > > branch, users would have to append "#master" to the URL.
> ...
> > Or am I missing something here?
> 
> That this is from 23 August and this change was in Cogito for several
> major releases and noone ever complained. ;-)

You catched me ;-)

Still I think my reasoning holds: cg-clone is also used locally, thus
cloning a repository on which you probably are working on, too.
If I want to branch off from master, I can use cg-clone to start a new
development branch. I suppose this is the suggested Cogito way, from
the README; and it makes Cogitos usage so simple, even with multiple
development branches: by using a cloned repository for each branch.

Of course, a Git user would use "git branch ...", and switch between
branches inside of one repository.

Josef
