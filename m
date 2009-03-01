From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 11:11:48 +0100
Message-ID: <49AA5F64.6070207@pelagic.nl>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <20090228172622.GC26689@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 11:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldigr-00076Z-U3
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 11:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbZCAKLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 05:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbZCAKLw
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 05:11:52 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:50159 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751296AbZCAKLv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 05:11:51 -0500
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 9748158BDBA;
	Sun,  1 Mar 2009 11:11:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090228172622.GC26689@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111834>

Shawn O. Pearce wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
>> I'm using jgit in eclipse. Works great for me.
>  
> Yay!
> 
>> I have a couple of generated files in my working directory. There
>> doesn't seem to be any UI for ignoring them. Is it there and I just
>> can't find it?
> 
> EGit doesn't (yet) honor the .gitignore files like it should. Someone
> (Ferry i-forget-the-rest-of-his-name) is working on adding ignore
> support and has patches in flight for at least some of it.
> 
Ferry i-do-remember-my-name Huberts is working on it :-)

I have most of it working in a basic form already but am currently
refactoring things to take care of some nasty little details.
Expect something to arrive within (my best guesstimate) about 3 to 4
weeks. after next week I'll be skiing for a week, so no coding then :-)

For the new functionality:
You don't really need a UI: just add a .gitignore file with a pattern
and the plugin will pick it up and show you what is ignored by means of
a nice little decoration.

Ferry
