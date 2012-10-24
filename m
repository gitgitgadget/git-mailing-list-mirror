From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [DOCBUG] git subtree synopsis needs updating
Date: Wed, 24 Oct 2012 16:29:47 +0200
Organization: Bertin Technologies
Message-ID: <20121024162947.2c1edc50@chalon.bertin.fr>
References: <20121019152158.4297707b@chalon.bertin.fr>
 <5082FE13.2000003@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Wed Oct 24 16:30:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR1y3-0001ty-BN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 16:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934881Ab2JXO3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 10:29:47 -0400
Received: from cabourg.bertin.fr ([195.68.26.10]:64829 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934863Ab2JXO3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 10:29:46 -0400
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 891E7A1028
	for <git@vger.kernel.org>; Wed, 24 Oct 2012 16:29:44 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 5FB18A1012
	for <git@vger.kernel.org>; Wed, 24 Oct 2012 16:29:44 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MCE000OIIXJZ9A0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 24 Oct 2012 16:29:44 +0200 (CEST)
In-reply-to: <5082FE13.2000003@initfour.nl>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19302.003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208307>

On Sat, 20 Oct 2012 21:40:03 +0200
Herman van Rink <rink@initfour.nl> wrote:

> On 10/19/2012 03:21 PM, Yann Dirson wrote:
> > As the examples in git-subtree.txt show, the synopsis in the same file should
> > surely get a patch along the lines of:
> >
> > -'git subtree' add   -P <prefix> <commit>
> > +'git subtree' add   -P <prefix> <repository> <commit>
> >
> > Failure to specify the repository (by just specifying a local commit) fails with
> > the cryptic:
> >
> >  warning: read-tree: emptying the index with no arguments is deprecated; use --empty
> >  fatal: just how do you expect me to merge 0 trees?
> >
> >
> > Furthermore, the doc paragraph for add, aside from mentionning <repository>, also
> > mentions a <refspec> which the synopsis does not show either.
> >
> >
> > As a sidenote it someone wants to do some maintainance, using "." as repository when
> > the branch to subtree-add is already locally available does not work well either
> > (fails with "could not find ref myremote/myhead").
> >
> 
> The version of subtree in contrib is rather out-dated unfortunately.
> 
> I've collected a bunch of patches in
> https://github.com/helmo/git/tree/subtree-updates

Ah, it's nice to see subtree updates.  Any plans to get them merged anytime soon ?

I guess you may want to rebase the patches from https://github.com/helmo/git-subtree,
the subtree-updates patch looks like a "subtree merge --squash" result, and is not really
suitable for reviewing on the list.

> The documentation issue is also fixed in there.
> 


-- 
Yann Dirson - Bertin Technologies
