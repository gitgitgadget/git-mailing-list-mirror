From: david@lang.hm
Subject: Re: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 21:58:48 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901092157110.31038@asgard.lang.hm>
References: <20090109222344.3539138a@family.dyweni.com> <200901092238.06968.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: 4jxDQ6FQee2H@dyweni.com, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 05:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLVuc-0000Jk-VT
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 05:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbZAJE4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 23:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZAJE4G
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 23:56:06 -0500
Received: from mail.lang.hm ([64.81.33.126]:44798 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbZAJE4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 23:56:05 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n0A4u0sG006580;
	Fri, 9 Jan 2009 20:56:00 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <200901092238.06968.bss@iguanasuicide.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105075>

On Fri, 9 Jan 2009, Boyd Stephen Smith Jr. wrote:

> On Friday 2009 January 09 22:23:44 4jxDQ6FQee2H@dyweni.com wrote:
>> Our company's website is stored in a GIT Repository.
>
> Interesting.  I like the thought.
>
>> The repository is coded for our test server.  When we push updates to
>> the production server, have manually run a script to patch several
>> files to make the code work on the production server (i.e. port
>> numbers, etc).
>>
>> I'd like to write a script to email me whenever someone changes files
>> on the production server without checking those changes back into git
>> (i.e. running 'git status | grep "nothing to commit" ...').
>>
>> However, this approach get confused by the files patched to work
>> correctly.
>>
>> Is there any way to 'save' those patched files so they don't get
>> reported by 'git status', yet not mung up the git history every time
>> we push out an update?
>
> You could simply commit after running the perl script.  You could even commit
> to a branch so that it's (a little) less likely those changes get integrated
> into master.

one nice thing about git commit is that if there are no changes it doesn't 
make a commit.

I have a couple files on my desktop (firefox status files for example) 
that I have a cron job do a commit on every min so that when firefox 
crashes in a way that can't be recovered by it's 'restore old pages' 
option I can go back and save things anyway.

David Lang
