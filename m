From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bare repositories: packing and fetching
Date: Fri, 15 Sep 2006 20:50:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609152049310.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <450AEB37.3090909@shadowen.org> <eeeqbv$8na$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 20:50:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOIli-00034J-Rh
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 20:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWIOSu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 14:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWIOSu0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 14:50:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:33243 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932219AbWIOSuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 14:50:25 -0400
Received: (qmail invoked by alias); 15 Sep 2006 18:50:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 15 Sep 2006 20:50:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eeeqbv$8na$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27098>

Hi,

On Fri, 15 Sep 2006, Jakub Narebski wrote:

> Andy Whitcroft wrote:
> 
> > I was trying to make a bare repo to stage linus' main tree.  As this was
> > only to be a local tree for others to pull from I thought that I could
> > clone his tree 'bare' and then fetch into that on a regular basis.  That
> > does not appear to be the case?  Both git fetch and git repack say 'not
> > a git repository .git' and bail.
> > 
> > Is this expected behaviour.  Do I have to have all the checked out files?
> 
> No, but perhaps git doesn't detect _where_ is a git repository. With full
> repository git tries to find .git somewhere in the directory, or it's
> parents, if I understand correctly.

Exactly. Since there is no .git directory, git does not know where it 
should look for the repository.

Try "git --bare fetch".

Hth,
Dscho
