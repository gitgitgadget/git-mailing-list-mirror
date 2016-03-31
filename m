From: Peter Olsson <peter@olssononline.se>
Subject: Re: Problem with Integrated Vim Editor on Win 10
Date: Thu, 31 Mar 2016 06:33:26 +0000 (UTC)
Message-ID: <loom.20160331T083046-590@post.gmane.org>
References: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 08:35:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alWCL-0007XA-7k
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 08:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbcCaGfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 02:35:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:60159 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbcCaGfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 02:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alWC7-0007T1-HC
	for git@vger.kernel.org; Thu, 31 Mar 2016 08:35:03 +0200
Received: from sofina.i3tex.com ([194.103.140.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 08:35:03 +0200
Received: from peter by sofina.i3tex.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 08:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.103.140.6 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290373>

Zachary Turner <zturner <at> google.com> writes:

> 
> Hi, just recently I installed the latest build of Windows 10 of my
> machine. This is my second Win10 machine. On the other I am using git
> 2.7.0.windows.1 and everything is working just fine.
> 
> On the second machine I am using git 2.8.0.windows.1 and vim does not
> work. I sent a bug report to bugs <at> vim.org, but frankly I don't 
know whose
> bug this is, so I'm including it here as well.
> 
> The problem is that vim is just a black screen when git launches it. 
If I
> mash enough keys eventually I see something that resembles vim output 
at
> the bottom, but I can't actually use it.
> 
> I tried going into program files\git\usr\bin and just running vim.exe.
> Again, black screen. If I press enter about 10 times I can see the
> introduction screen. Then if I press : about 10-20 times it will go 
into
> command mode and a single : appears. after pressing a few more keys 
all
> the rest of the :s appear. Basically, everything is completely 
unusable.
> 
> I tried downloading vim 7.4 from www.vim.org, and low and behold, it
> works. For now I've replaced the copy of vim.exe that ships with git 
with
> the copy from www.vim.org. But this leaves me nervous that something 
is
> seriously wrong.
> 
> Has anyone seen anything like this before, or have any ideas how I 
might
> better diagnose this?
> 


Same problem here, but on Windows 7. I'm pretty sure that this was 
introduced in version 2.8.0 for Windows. Before upgrading, I used the 
latest 2.7 version and it worked as expected.

I'm not sure where we should report this?

/Peter
