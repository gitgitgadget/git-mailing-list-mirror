From: Gelonida <gelonida@gmail.com>
Subject: Re: how to delete the entire history before a certain commit
Date: Tue, 04 May 2010 01:58:20 +0200
Message-ID: <4BDF631C.8010800@gmail.com>
References: <hrnidr$etm$1@dough.gmane.org>	<m3ocgwfvw2.fsf@localhost.localdomain> <hrnl7o$nnf$1@dough.gmane.org> <m3k4rkft7k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 01:58:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O95X2-00012d-JT
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759961Ab0ECX6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 19:58:31 -0400
Received: from lo.gmane.org ([80.91.229.12]:45236 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523Ab0ECX6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:58:30 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O95Wu-00011D-9K
	for git@vger.kernel.org; Tue, 04 May 2010 01:58:28 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 01:58:28 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 01:58:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <m3k4rkft7k.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146275>

Hi Jakub,

Jakub Narebski wrote:
> Gelonida <gelonida@gmail.com> writes:
>> Jakub Narebski wrote:
>>> Gelonida <gelonida@gmail.com> writes:
>>>
>>>> We have a git repository, whose size we want to reduce drastically 


>>> If you want to simply _remove_ history before specified commit,
>>> instead of squashing it, the best solution would be to use grafts to
>>> cauterize (cut) history, check using [graphical] history viewer that
>>> you cut it correctly, and then then use git-filter-branch to make this
>>> cut permanent.

> You can read about grafts in git-filter-branch(1) manpage, in
> gitrepository-layout(5) git repository layout description, and in
> gitglossary(7) a git glossary.
> 
> In short, each line in .git/info/grafts consist of sha1 id of object,
> followed by space-separated list of its effective (grafted) parents.
> So to cut history e.g. after commit a3eb250f996bf5e, you need to put
> line containing only this SHA-1 in .git/info/grafts file, e.g.:
> 
>   $ git rev-parse --verify a3eb250f996bf5e >> .git/info/grafts
>  
>> So the command to look for is git-filter-branch, right ?
>> I'll read the doc.
> 
> 
> As you would see in git-filter-branch(1) documentation, simple
> 
>   $ git filter-branch --all


The command
git filter-branch --all
did not work for me. it just fdisplays the help text.

however without '--all'
git filter-branch

seems to have worked.

Thanks a lot :-)
