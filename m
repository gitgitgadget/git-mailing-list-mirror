From: david@lang.hm
Subject: Re: how to recover a repository
Date: Fri, 17 Dec 2010 12:20:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1012171218450.18272@asgard.lang.hm>
References: <alpine.DEB.2.00.1012162024020.22269@asgard.lang.hm> <20101217044530.GA8590@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 21:21:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTgnY-0004tY-8i
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 21:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab0LQUU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 15:20:59 -0500
Received: from mail.lang.hm ([64.81.33.126]:37833 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab0LQUU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 15:20:59 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id oBHKKuBZ027936;
	Fri, 17 Dec 2010 12:20:56 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20101217044530.GA8590@burratino>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163887>

On Thu, 16 Dec 2010, Jonathan Nieder wrote:

> Hi David,
>
> david@lang.hm wrote:
>
>> I managed to do a 'rm *' in the .git directory (the usual sort of
>> fat-fingering when cleaning up after another mistake)
>>
>> the subdirectories are still there.
>
> I'd suggest:
>
> 1. Make a backup!
> 2. From the worktree (i.e. parent to the .git directory),
>    run "git init".
> 3. git update-ref HEAD refs/heads/(branch you were on)

I was on the default branch but if I do 'git update-ref HEAD 
refs/heads/master' I get an error 'not a valid SHA1'

.git/refs/heads is empty

.git/logs/HEAD looks like it shows all the commits in it properly

David Lang

> 4. git reset;	# (alas, the old index file is gone)
> 5. git diff; gitk --all
>
> See gitrepository-layout(7) for details.
>
