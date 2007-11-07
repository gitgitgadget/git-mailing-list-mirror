From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 18:19:24 -0500
Message-ID: <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> <Pine.LNX.4.64.0711072242230.4362@racer.site> <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpuBS-0005o1-DN
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbXKGXT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbXKGXT1
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:19:27 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:35460 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbXKGXT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:19:26 -0500
Received: from [192.168.1.5] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E87491FFC011;
	Wed,  7 Nov 2007 23:19:25 +0000 (UTC)
In-Reply-To: <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63893>


On Nov 7, 2007, at 6:03 PM, Jon Smirl wrote:

> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>> We also tend to take the approach of viewing the history as that of
>> the whole project.
>
> But if you type 'git log' while cd'd into a subdirectory the whole log
> is almost never what you want. It's this kind of thing that makes git
> harder to use.

Here's where I'd have to disagree with you.  If I'm in git.git/ 
Documentation and am trying to remember which commit I'm trying to  
document, suddenly having 90+% of the history vanish would make git  
harder to use.  Same with my rails projects, my mudlib, etc.  Hiding  
history is a bad default.

I think the problem is that you're still thinking in the CVS-style per- 
file history.  "git log" works on the history not the files, so the  
automatic filtering simply doesn't make sense.  Git's whole-tree  
approach makes it much easier to find when Makefile or API changes  
have broken your code.  But if you know that the error is in a  
specific place, then using "." lets you get at it.

However, Dave's suggestion of altering git-status output to be  
relative to (but not limited by) CWD has merit.  Too bad I don't have  
time to work on it right now.

~~ Brian Gernhardt
