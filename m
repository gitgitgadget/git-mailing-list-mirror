From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 22:04:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902192203280.6223@intel-tinevez-2-302>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 22:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaG6L-0002Ln-Tb
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbZBSVFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZBSVFD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:05:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:48660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754509AbZBSVFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:05:01 -0500
Received: (qmail invoked by alias); 19 Feb 2009 21:04:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 19 Feb 2009 22:04:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YdEo71u+YdJizPxTnUlINTP1pU08nfdj8ljG10x
	rZhkDPwrhjpgE6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110751>

Hi,

On Thu, 19 Feb 2009, Jay Soffian wrote:

> On Thu, Feb 19, 2009 at 4:21 AM, John Tapsell <johnflux@gmail.com> wrote:
>
> >  I often do 'git rebase -i HEAD~10' to rebase.  Since afaics it 
> > doesn't matter if you go back 'too far' I just always use HEAD~10 even 
> > if it's just for the last or so commit.
> >
> >  Would there be any objections to making 'git rebase -i' default to 
> > HEAD~10 or maybe 16 or 20.  Having sensible defaults for commands 
> > helps a bit with making it easier to use.
> 
> I think the following might be reasonable to support:
> 
> $ git rebase -i -10
> $ git rebase -i -n -10

I disagree.

You think -10 would be the same as HEAD~10?  Think again.  And include 
merge commits amongst the last 9 commits in your thoughts.

Once you thought about such a scenario, "-10" is probably no longer that 
attractive, right?

Ciao,
Dscho
