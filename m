From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git and cvsimport
Date: Tue, 27 Apr 2010 13:03:18 +0200
Message-ID: <4BD6C476.6060007@drmicha.warpmail.net>
References: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>	 <4BD69450.8040608@drmicha.warpmail.net> <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marin Atanasov <dnaeon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 13:04:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6iaL-0007nG-9k
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 13:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab0D0LDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 07:03:23 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42112 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754582Ab0D0LDW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 07:03:22 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9C251F2001;
	Tue, 27 Apr 2010 07:03:20 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 27 Apr 2010 07:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=jOS6ILnZuQY4QLDaUf+BW1ePfrs=; b=TDjvDtzRUB9Cmf7EXvXz3jULkXjgPbJiUi35ZhXmxFeEeNarsWQZ3DJfwJ0VGqwQb4VQR6WrFZNAu8auLbnD7O/pvuqcLsK5QhgTjon7jFLLzO+lUe3yqPeGSMhxO1u7nkPpRcH5mLoN+Al2avYtAqVCA7Z24VXENnNn0PDxN3Q=
X-Sasl-enc: SxFYb6CKZTNp73V6VjpuhsqKh+zIf1IevbeKu/89VcQM 1272366200
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CC1FD4AC2B3;
	Tue, 27 Apr 2010 07:03:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100426 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145897>

Marin Atanasov venit, vidit, dixit 27.04.2010 12:41:
> On Tue, Apr 27, 2010 at 10:37 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Marin Atanasov venit, vidit, dixit 26.04.2010 16:27:
>>> Hello,
>>>
>>> I need to import an existing CVS repo to Git. Using git-cvsimport
>>> works well for me when importing from the CVS server itself, but I
>>> need to do something different.
>>>
>>> Here's a little info about what I'm doing.
>>>
>>> $ pwd
>>> /home/<user>/test
>>>
>>> $ git --version
>>> git version 1.5.6.5
>>>
>>> $ git cvsimport -v -d :pserver:<user>@<server>:/var/
>>> cvsroot -C test.git test-repo
>>> Initialized empty Git repository in /home/<user>/test/test.git/.git/
>>> Running cvsps...
>>> connect error: Network is unreachable
>>> cvs rlog: Logging test-repo
>>> Fetching file1   v 1.1
>>> New file1: 14 bytes
>>> Fetching file2   v 1.1
>>> New file2: 14 bytes
>>> Fetching file3   v 1.1
>>> New file3: 14 bytes
>>> Tree ID bf675ce25c8ca3fd1f4a120ea933510c90ccda16
>>> Parent ID (empty)
>>> Committed patch 1 (origin +0000 2010-04-26 09:40:58)
>>> Commit ID 377641eae81975e214a579da9e6c0c5afd819b17
>>> Created tag 'SOMETAG' on 'origin'
>>> Fetching file1   v 1.2
>>> Update file1: 47 bytes
>>> Fetching file3   v 1.2
>>> Update file3: 47 bytes
>>> Tree ID 10ab70cdcc53bb94684d09e60817bb62cb8c3d98
>>> Parent ID 377641eae81975e214a579da9e6c0c5afd819b17
>>> Committed patch 2 (origin +0000 2010-04-26 09:44:22)
>>> Commit ID fea2a99c906e57df5c4735ba3f9627cbb8fba295
>>> DONE; creating master branch
>>>
>>> The above commands works fine, when I directly get the files from the
>>> CVS server, but I want to do the following.
>>>
>>>  - checkout files from CVS, which are already tagged with certain
>>> names to a local folder
>>>  - then import those files to Git with git-cvsimport
>>>  - fetch those imports later by a shared bare repo into different
>>> branches, so at the end each branch will contain the files with the
>>> certain tag.
>>>
>>> So, If i do the following, then git-cvsimport fails:
>>>
>>> $ pwd
>>> /home/<user>/test
>>>
>>> $ cvs -d :pserver:<user>@<server>:/var/cvsroot co -r SOMETAG test-repo
>>> cvs checkout: Updating test-repo
>>> U test-repo/file1
>>> U test-repo/file2
>>> U test-repo/file3
>>>
>>> $ git cvsimport -v -d /home/<user>/test -C test.git test-repo
>>> Expected Valid-requests from server, but got: E Cannot access
>>> /home/<user>/test/CVSROOT
>>>
>>> Can you give me some hints how to do this? Seems that I can import CVS
>>> repos from remote server, but cannot do this from a local folder..
>>
>> ... because a folder is not a server, and a cvs checkout is not a cvs repo.
>>
>> It's not completely clear to me what you want and why, but the simplest
>> way seems to be to checkout each cvs tag using cvs, and (add &) commit
>> the result to the git branch of your choice using git. You don't seem to
>> want to convert the cvs repo, so don't use git cvs-import.
>>
>> But, really, I don't know what you want - history-less git branches from
>> cvs tags?
>>
>> Michael
>>
> 
> Hello Michael,
> 
> Perhaps I didn't explain better what I want to accomplish :)

and perhaps I don't understand cvs tags well enough :)

> 
> I want to convert CVS repo to a Git one.
> 
> But checking  out from CVS and then converting to Git, checks out HEAD
> from CVS, thus the latest revisions.
> 
> What I want to do is to checkout from CVS the files which are tagged
> RELEASE_1_0 for example, and then import the files to a Git repo.
> Files tagged as RELEASE_1_0 differ from HEAD files, so I want only
> those files with that tag for example.
> 
> Is this possible to do with git-cvsimport, to specify the tag you want
> to checkout from CVS?
> 

I don't think so, but the actual CVS checkout doesn't matter so much.
git cvsimport will import cvs tags as git tags (at least it promises to,
never tried myself). Once your git repo has all the cvs commits you want
(and more) you can always create a git branch which points at the tag
you want, and delete the other branches if you like. You can even give
them the same name if you don't mind dealing with ambiguous refnames
(git checkout -b tagnamebranch tagname).

Especially since you seemlingy want to do this with multiple tags, the
advantage of that approach is that you run git cvsimport once, and then
git branch or checkout multiple times (once for each tag), which is fast.

[Do you want to do a one-off conversion or keep syncing with cvs?]

Michael
