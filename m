From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fetch and unannotated tags
Date: Fri, 27 Apr 2007 17:50:22 +0200
Organization: At home
Message-ID: <f0t5s3$f1e$1@sea.gmane.org>
References: <200704252004.45112.andyparkins@gmail.com> <200704252142.33756.andyparkins@gmail.com> <7vfy6ow4my.fsf@assigned-by-dhcp.cox.net> <200704260904.08447.andyparkins@gmail.com> <4630C377.8000602@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 17:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhSfH-0003AR-NI
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 17:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbXD0Pqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756021AbXD0Pqc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 11:46:32 -0400
Received: from main.gmane.org ([80.91.229.2]:52251 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756019AbXD0Pqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 11:46:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HhSeM-00068Z-Tg
	for git@vger.kernel.org; Fri, 27 Apr 2007 17:46:23 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 17:46:22 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 17:46:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45726>

Andreas Ericsson wrote:

> Andy Parkins wrote:
>> 
>> I'd be arguing for making not following unannotated tags the default, and then 
>> supply a switch to make them followed.  Is that too painful?  I think that's 
>> in keeping with the tradition that unannotated tags are, typically, not 
>> wanted in a central repository - the default update hook prevents it for 
>> example.
> 
> Yup. I share your feelings about simple tags. However, unless the repo owner
> has decided to explicitly push the simple tag to the repo, or fscked up by
> doing "git push --all" when he had cruft in his own repo, those tags are
> in fact part of the repo.
> 
> In the "oops" case, I'd point this out to the owner so he/she can delete them
> from the central repo (and enable the update-hook that barfs when simple tags
> are pushed). If the owner actually wants the tags there, then they're
> obviously important for some reason, so keeping them might make sense.

You can delete branch (ref?) using "<branch>:" refspec, if server you push to
has git new enough. HTH.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
