From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Re: git-svn: make git-svn commit-diff able to work without explicit arguments
Date: Tue, 02 Jan 2007 22:58:14 +0100
Organization: At home
Message-ID: <enekbs$n8g$1@sea.gmane.org>
References: <459AA31E.5070705@gmail.com> <7vr6udtbmv.fsf@assigned-by-dhcp.cox.net> <20070102211339.GF17898@hades.madism.org> <052E1601-5422-48A0-81B3-9A454467CE5F@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 02 22:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rbW-0002EG-8G
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbXABVz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbXABVz1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:55:27 -0500
Received: from main.gmane.org ([80.91.229.2]:52678 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646AbXABVz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:55:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H1rbM-0007N8-D3
	for git@vger.kernel.org; Tue, 02 Jan 2007 22:55:20 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 22:55:20 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 22:55:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35825>

Brian Gernhardt wrote:

>>   The reason is simple, I often use git commit as :wq in my editor,  
>> and
>> sometimes think that in a A--B--C--D and in fact, I'd prefer to have:
>>
>>   {A,C}--B--D. how is it possible to do that in a not too cumbersome
>> way? because that would make sens to work in some scratch branch, and
>> then reorganize patches in a saner better way in the master branch.
>>
>>   But I fail to see how to achieve that without using cumbersome
>> export-to-patch then git apply patch and edit logs which is painful  
>> and
>> not really using git.
> 
> The command you seem to be looking for is git-cherry-pick.  To  
> combine the two commits, I'd do something like:
> 
> $ git cherry-pick A
> $ git cherry-pick C
> $ git reset HEAD~2
> $ git add <files>
> $ git commit

Or better learn about --no-commit option of git-cherry-pick. Or if you
don't mind additional tools I think you can do this using StGIT.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
