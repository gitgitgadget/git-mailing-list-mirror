From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: remove redundant slashes from show-ignore
Date: Sat, 29 Mar 2008 18:36:00 -0700
Message-ID: <20080330013600.GB16157@soma>
References: <b762bfda0803291340ta70ee88k8d5d7c7e384e41e0@mail.gmail.com> <20080329233717.GA16157@soma> <1206834466.6543.30.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 03:37:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfmTj-0008KT-QY
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 03:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYC3BgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 21:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYC3BgD
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 21:36:03 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40906 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbYC3BgC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 21:36:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CCB7A7F4109;
	Sat, 29 Mar 2008 18:36:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1206834466.6543.30.camel@brick>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78494>

Harvey Harrison <harvey.harrison@gmail.com> wrote:
> On Sat, 2008-03-29 at 16:37 -0700, Eric Wong wrote:
> > Jonathan Scott Duff wrote:
> > > Recently I tried "git svn showignore" on my parrot repository and it
> > > failed.  I tracked it down to the prop_walk() sub.  When it recurses,
> > > $path has an extra / on the beginning (i.e., when it recurses, it
> > > tries to get the props for "//apps" instead of "/apps").   I *think*
> > > this is because $path is used in the recursive call rather than $p
> > > (which seems to contain a properly transformed $path).  Anyway, I've
> > > attached a patch that works for me and I think is generally the right
> > > thing.
> > 
> > Patch-submitted-by: Jonathan Scott Duff
> 
> Shouldn't that be Signed-off-by?

I'm not sure what the proper protocol for this should be,
as Jonathan emailed the patch to me privately without a sign-off...

[1] - Out of respect for his privacy, I'm only Bcc-ing him to avoid
  putting his address on the list.

-- 
Eric Wong
