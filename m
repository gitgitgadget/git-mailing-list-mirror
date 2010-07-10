From: Martin Pettersson <martin@siamect.com>
Subject: Re: Cutting history
Date: Sat, 10 Jul 2010 17:40:20 +0700
Message-ID: <201007101740.20854.martin@siamect.com>
References: <20100710032553.GB554@nibiru.local> <4C37F24E.30407@workspacewhiz.com> <m3tyo7lo6n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 10 12:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXXdC-0005A9-8l
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 12:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543Ab0GJKts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 06:49:48 -0400
Received: from smtp4.34sp.com ([80.82.115.203]:57447 "EHLO smtp4.34sp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab0GJKtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 06:49:47 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Jul 2010 06:49:47 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp4.34sp.com (Postfix) with ESMTP id E148CEA1040
	for <git@vger.kernel.org>; Sat, 10 Jul 2010 11:40:49 +0100 (BST)
X-Virus-Scanned: amavisd-new at smtp.34sp.com
Received: from smtp4.34sp.com ([127.0.0.1])
	by localhost (smtp4.34sp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3GkZX470iwKG for <git@vger.kernel.org>;
	Sat, 10 Jul 2010 11:40:49 +0100 (BST)
Received: from our-server.localnet (ppp-124-121-207-247.revip2.asianet.co.th [124.121.207.247])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: controlcentres.com)
	by smtp4.34sp.com (Postfix) with ESMTP id 62FE7EA103F
	for <git@vger.kernel.org>; Sat, 10 Jul 2010 11:40:49 +0100 (BST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <m3tyo7lo6n.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150718>

On Saturday, July 10, 2010 03:47:14 pm you wrote:
> Joshua Jensen <jjensen@workspacewhiz.com> writes:
> >   ----- Original Message -----
> > 
> > From: Enrico Weigelt
> > Date: 7/9/2010 9:25 PM
> > 
> > > I'm using git for automatic backups (eg. database dumps). This
> > > works quite well, but as time goes, the history (and so the repo)
> > > gets larger and larger. It would be really nice to allow cutting
> > > off old stuff (eg. after N commits in the past).
> 
> This is certainly Using Git For What It Was Not Intended...
> 
> > > Maybe that could be done by introducing "stopper" tags: commits
> > > that have an stopper-tag may have missing parents, and git-gc
> > > can be told to ignore those parents and throw away everything
> > > behind the stopper (if not referenced otherwise).
> > > 
> > > A probably cleaner, but more invasive way could be making refs
> > > to vectors, which may contain stop points (multiple ones in case
> > > of merges) additionally to the start point. Remote transmits only
> > > contain the commits within this range, and GC also just scans
> > > the range (instead of following all parents).
> > 
> > Your post reminded me of this: http://progit.org/2010/03/17/replace.html
> 
> Another solution would be to make history shallower like shallow clone
> ("git clone --depth <depth>") does it[1], and then prune history.  Or
> you can use grafts to cauterize history.
> 
> Both of those solutions have disadvantages wrt pushing and pulling to
> other repositories (shallow clone less so), but I don't think that
> would be a problem for your situation.
> 
> [1] Documentation/technical/shallow.txt

Don't complicate things, just make new repo when the old one is too large. 
That is what I do and it is for me the best backup system I ever had.
Martin
