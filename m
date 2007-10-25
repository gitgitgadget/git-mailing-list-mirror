From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 14:09:01 +0200
Message-ID: <D94E760B-0DFC-4735-AB8D-3E7B4E47950A@zib.de>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 14:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il1VE-0001FW-Bt
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 14:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbXJYMHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 08:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbXJYMHm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 08:07:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:38418 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682AbXJYMHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 08:07:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9PC7Wmq011827;
	Thu, 25 Oct 2007 14:07:32 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9PC7WwP000858
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Oct 2007 14:07:32 +0200 (MEST)
In-Reply-To: <472070E5.4090303@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62312>


On Oct 25, 2007, at 12:33 PM, Andreas Ericsson wrote:

>> I slowly start to understand why your users are confused.   
>> _Nobody_ works on 200 branches at the same time.  (No, maintainers  
>> don't count: they do not work _on_ the branches, but _with_; they  
>> merge them.)
>> When you're done with a topic, why do you leave it around?   
>> Cluttering up your "git branch" output?
>
> We have 91 repositories at work. Roughly 60 of those are in active  
> use.
> The active repos are organized pretty much like the git repo with
> 'master', 'next' and 'maint'. We *do* work on all branches, but not
> every day, ofcourse. They're NOT topic branches. We implement features
> on topic-branches that we DO throw away, but those branches HAVE to be
> there for us to be able to handle supporting of old versions as  
> well as
> implementing new features in a sane way. Throwing them away locally  
> would
> mean having to re-create them very frequently, and since they have to
> exist in the upstream repo, "git fetch" would fetch and re-create them
> every single time anyway.
>
> So please, pretty please just drop the entire "use topic branches"  
> argument.
> We do that, but still have this problem, and it *is* a problem.

This is an interesting situation. If we find a good solution
that is accepted by the average developer in daily work. We
can probably learn a lot.

	Steffen
