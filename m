From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 18:47:50 +0200
Message-ID: <8CC7951E-48C9-411E-8F98-776661C38BD3@zib.de>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org> <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de> <Pine.LNX.4.64.0708101113380.21857@racer.site> <3351C69E-C0A8-4D02-9E04-085E18F1DF75@zib.de> <Pine.LNX.4.64.0708101309430.21857@racer.site> <31EFF30A-CC7A-4BB0-B083-13A1F7B62781@zib.de> <Pine.LNX.4.64.0708101452060.21857@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJXh6-00050K-Rt
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938640AbXHJQtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937799AbXHJQtw
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:49:52 -0400
Received: from mailer.zib.de ([130.73.108.11]:63634 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937238AbXHJQtv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 12:49:51 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7AGl3fK006514;
	Fri, 10 Aug 2007 18:49:45 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7AGl2XT029263
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 18:47:02 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708101452060.21857@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55554>


On Aug 10, 2007, at 3:53 PM, Johannes Schindelin wrote:

> On Fri, 10 Aug 2007, Steffen Prohaska wrote:
>
>> I have a mob for /.git, but I do not have the setup for /git/.git.  
>> Maybe
>> I deleted it because I didn't understand what is means.
>
> Ah, I misunderstood.  Yes, it is quite possible to have a mob  
> installed
> for 4msysgit.git by default.  Should by done in
> msysgit.git:share/GitMe/setup-msysgit.sh.

Yeah, but what is the right URL to push mob to? I wasn't abel to
figure it out.


>> Whoever has setup the mob configurations, maybe it would be a good  
>> idea
>> to forbid non-fast-forward but instead allow the creation of new mob*
>> branches. If I can't push to mob, I could push to mob-topic instead.
>> Cleanup would be in the responsibility of the repository owner.
>
> This is not possible.  The refusal of a non-fast-forward is a per- 
> repo,
> not a per-user, configuration.

I see.

I expected some scripting magic in place that already deals with  
handling
the mob user, and expected it could be used to deny fast-forwards on  
a per
user basis. But I haven't looked into the git scripting hooks so far.
So I have basically no clue about what I'm talking here ;)

	Steffen
