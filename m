From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-remote exclude
Date: Mon, 15 Jan 2007 21:10:34 +0100
Organization: At home
Message-ID: <eogn2u$i8d$1@sea.gmane.org>
References: <45AA44D6.6080605@gmail.com> <Pine.LNX.4.63.0701151118400.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200701151155.26111.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jan 15 21:46:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6YA9-0000mR-I5
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 21:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXAOUKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 15:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAOUKb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 15:10:31 -0500
Received: from main.gmane.org ([80.91.229.2]:40915 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbXAOUKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 15:10:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6Y9q-0006GR-L5
	for git@vger.kernel.org; Mon, 15 Jan 2007 21:10:19 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 21:10:18 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 21:10:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36879>

Andy Parkins wrote:

> On Monday 2007 January 15 10:23, Johannes Schindelin wrote:
> 
>> But then, I don't really see _why_ you would want such a solution. After
>> all, you are more likely to be interested in _specific_ branches, rather
>> than all branches _except_ a few.
> 
> That's not true.  I have a patch (that doesn't work, so it's not submitted), 
> that would allow me to have:
> 
> [remote "origin"]
>     url = git://git2.kernel.org/pub/scm/git/git.git
>     fetch = refs/heads/*:refs/remotes/up/*
>     fetch = !refs/heads/html
>     fetch = !refs/heads/todo
> 
> i.e. I don't want those two branches, but I do want everything else.  I'd also 
> like to be able to do "!/refs/heads/temp/*" so I could block a whole 
> subdirectory of branches.  I have a feeling that this would come in handy for 
> people like the person who was recently talking about having 880 branches in 
> his repository, with only a few active.

Very good idea. I even thought that this feature is present in git
already...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
