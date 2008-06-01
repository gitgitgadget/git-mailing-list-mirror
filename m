From: david@lang.hm
Subject: Re: unable to push
Date: Sun, 1 Jun 2008 11:34:19 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0806011133050.15294@asgard.lang.hm>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net> <alpine.DEB.1.10.0805310855000.15294@asgard.lang.hm> <20080601182205.GA742@sigill.intra.peff.net> <alpine.DEB.1.10.0806011125340.15294@asgard.lang.hm>
 <20080601183134.GA2623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2sOX-0006pg-1q
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbYFASeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 14:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbYFASeM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:34:12 -0400
Received: from mail.lang.hm ([64.81.33.126]:49731 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbYFASeL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:34:11 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m51IY2G2032693;
	Sun, 1 Jun 2008 11:34:02 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080601183134.GA2623@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83461>

On Sun, 1 Jun 2008, Jeff King wrote:

> On Sun, Jun 01, 2008 at 11:28:39AM -0700, david@lang.hm wrote:
>
>>> I'm not understanding that, either. You not only created localmaster,
>>> but you deleted master. Did you maybe do a "git branch -m"?
>>
>> in the public repo I had never created a 'master' branch. I had just done
>> a clone, setup git daemon, and pushed to it.
>
> Did you mean "init" here instead of clone? The clone should have created
> at least one branch (generally master, but depending on the current
> branch of the cloned repo).

no, it was definantly a clone, and it did not create a master branch (at 
least not one that showed up with git branch -a)

David Lang

>> at some point several days later I found that my push didn't work and that
>> I wasn't on any branch in the public repo. in reading the man page for git
>> branch I saw the --track option, so I created the localmaster branch to
>> try and get things working.
>
> Ah, ok. That makes sense. The right fix was to just manually specify the
> refspec the first time ("git push public master") after which you could
> just do "git push public" if you wanted.
>
> -Peff
>
