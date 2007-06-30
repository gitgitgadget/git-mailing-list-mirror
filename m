From: walt <wa1ter@myrealbox.com>
Subject: Re: Question about git-prune
Date: Sat, 30 Jun 2007 13:06:09 -0700
Organization: none
Message-ID: <f66d3l$sa6$1@sea.gmane.org>
References: <Pine.LNX.4.64.0706300915440.16800@x2.ybpnyarg> <Pine.LNX.4.64.0706301900290.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 30 22:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jDF-0004xU-F6
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXF3UG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbXF3UG3
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:06:29 -0400
Received: from main.gmane.org ([80.91.229.2]:42558 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbXF3UG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:06:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I4jD4-0005fF-At
	for git@vger.kernel.org; Sat, 30 Jun 2007 22:06:22 +0200
Received: from adsl-69-234-198-180.dsl.irvnca.pacbell.net ([69.234.198.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 22:06:22 +0200
Received: from wa1ter by adsl-69-234-198-180.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 22:06:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-198-180.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/20070630)
In-Reply-To: <Pine.LNX.4.64.0706301900290.4438@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51250>

Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 30 Jun 2007, walt wrote:
...
>> $git-prune
>> $git-fsck
>> dangling tree c642c018aa55d39fff061183f58062de9d8375ac
>> dangling commit e1341abc3759950e891822088cb0163b71b316b3
>> dangling commit 9f38e1ef7e7992ca490b9b419f52fb4d11efb0e4
>> dangling commit b82871b3c32faa8a317007f343fdf2d0ddc9954e
> 
> Probably the objects were packed.

I also tried git-prune-packed, which also did nothing AFAICT.

> I do not understand why you use git-prune directly, to begin with. Why not 
> use git-gc and be done with it?

It didn't exist when I started using git.  I normally don't use 
git-prune either, but in this case I was just scanning for problems
after switching from cg-update to git-pull.

git-gc did get rid of all the danglers even though git-prune didn't.
I'll do some investigating to find out why -- that should get me more
up to date with recent changes.

Thanks for your help.
