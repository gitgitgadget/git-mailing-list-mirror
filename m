From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Sat, 24 Sep 2011 23:17:35 +0100
Message-ID: <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <op.v2byz2p80aolir@keputer.lokaal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 00:23:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7acx-00057O-2x
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 00:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab1IXWRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 18:17:54 -0400
Received: from lo.gmane.org ([80.91.229.12]:41720 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab1IXWRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 18:17:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R7aXh-0003YJ-Bd
	for git@vger.kernel.org; Sun, 25 Sep 2011 00:17:53 +0200
Received: from 31.64.20.37 ([31.64.20.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 00:17:53 +0200
Received: from a5158017 by 31.64.20.37 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 00:17:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.20.37
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182047>

Frans Klaver wrote:

>> Mercurial allows this, and it's a very powerful feature.  After reading
>> this thread, I could not believe Git didn't pulling with local changes,  
>> and so I tried it, and also asked on IRC -- and it seems that Git really
>> doesn't.
> 
> Git doesn't do it implicitly. Be explicit about it
> 
> $ git stash
> $ git pull
> $ git stash pop
> 
> seems to do exactly what you want.

Does popping the stash allow for a three-way merge?  If not, this doesn't
really solve the problem.

Thanks
