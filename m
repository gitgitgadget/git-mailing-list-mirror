From: Gelonida N <gelonida@gmail.com>
Subject: Re: How to properly rename a repository with submodules
Date: Sun, 20 May 2012 20:49:13 +0200
Message-ID: <jpbeb9$cni$1@dough.gmane.org>
References: <jpbcjj$ho$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 20:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWBCO-0001uD-Kh
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 20:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811Ab2ETSt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 14:49:26 -0400
Received: from plane.gmane.org ([80.91.229.3]:45329 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756741Ab2ETStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 14:49:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SWBBz-0001By-ET
	for git@vger.kernel.org; Sun, 20 May 2012 20:49:23 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 May 2012 20:49:23 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 May 2012 20:49:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <jpbcjj$ho$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198068>

On 05/20/2012 08:19 PM, Gelonida N wrote:
> Hi,
>
> Today I noticed to my surprise, that a repository with submodules
> contains absolute paths.in the .git file of each sub module.
>
> This is kind of surprising to me and seems to make it absolutely
> impossible to have a non bare git repository on a memory stick.
>
> It also seems to make it impossible to rename a working repository after
> cloning.
>
> So I have three questions.
>
> 1.) Is there any way to force git to use relative path names, such, that
> this issue just disappears.
>
> 2,) Is there any existing script, that allows me to move a git
> repository to another location without breaking it's sub modules.
>
> 3.) Why do these path names have to be absolute? Is this for performance
> reasons? path names relative to the location of the .git file seem to be
> much more flexible / portable.
>

It seems this behaviur is just on one of my 'new' machines which was 
upgraded to
Ubuntu 12.04 (git version 1.7.9.5)


on my old machines I had either really old git versions or the most 
recent ones 1.7.10


I just added ppa:git-core/ppa to the Ubuntu sources and upgraded git to 
1.7.10

Problem solved!! Path names are now relative. So it seems it wasn't only 
me thinking absolute path names are a bad idea :-)
