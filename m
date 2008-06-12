From: "Shak" <sshaikh@hotmail.com>
Subject: Re: Deleting files
Date: Thu, 12 Jun 2008 13:23:53 +0100
Message-ID: <g2r4ha$74i$1@ger.gmane.org>
References: <g2r19e$s6e$1@ger.gmane.org> <g2r1sb$tut$1@ger.gmane.org> <g2r36d$2ju$1@ger.gmane.org> <477B22F6-9F24-4CBE-98EE-58EF697E6320@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 14:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6lrg-0007Gr-BQ
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 14:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633AbYFLMYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 08:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758005AbYFLMYV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 08:24:21 -0400
Received: from main.gmane.org ([80.91.229.2]:35013 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890AbYFLMYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 08:24:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K6lqk-0000lq-Sx
	for git@vger.kernel.org; Thu, 12 Jun 2008 12:24:18 +0000
Received: from cpc4-seve16-0-0-cust781.popl.cable.ntl.com ([86.21.191.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 12:24:18 +0000
Received: from sshaikh by cpc4-seve16-0-0-cust781.popl.cable.ntl.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 12:24:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpc4-seve16-0-0-cust781.popl.cable.ntl.com
In-Reply-To: <477B22F6-9F24-4CBE-98EE-58EF697E6320@ai.rug.nl>
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6001.18000
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84752>

"Pieter de Bie" <pdebie@ai.rug.nl> wrote in message 
news:477B22F6-9F24-4CBE-98EE-58EF697E6320@ai.rug.nl...
>
> In short, the point is that you never commited the deletions! Your  whole 
> history
> until now will still show those deleted files. You can commit the 
> actually deletions
> now, as you should have done before (either by using "git rm <file>", 
> "git add -u",
> "git commit -a" or "git commit <file>".
>

Thanks for the quick workflow. To fill in a gap in my OP, I was using "git 
add ." to add new files before a "commit". Since I (perhaps incorrectly) 
took "commit -a" as a short cut for these two commands, I assumed that "git 
add ." would also commit deletions.

So sticking to my previous workflow (I need to do this since "commit -a" as 
I understand it doesn't commit new files, and I often forget that I've added 
:)), it seems I should do the following to keep the working directory in 
sync with the repository:

git add .
git add -u
git commit

Is that right? Should the two add commands be called in that order or 
doesn't it matter?

I ask because I'm still concerned with how git assumed I had renamed files 
after I had "git rm"d them. As far as I could tell they were not very alike. 
Perhaps adding the new files before removing the old ones would stop this 
behavior?

Shak 
