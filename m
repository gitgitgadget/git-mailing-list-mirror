From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn added files to my commit?!
Date: Sat, 05 Aug 2006 22:22:55 -0700
Message-ID: <m2fygazbdc.fsf@gmail.com>
References: <m2vep7yqzh.fsf@gmail.com> <20060805211337.GA31264@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 07:23:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9b6a-0003ll-Cs
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 07:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWHFFXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 01:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWHFFXE
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 01:23:04 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:47310 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751456AbWHFFXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 01:23:02 -0400
Received: by py-out-1112.google.com with SMTP id z74so286935pyg
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 22:23:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=fIZ9i9DpbLsTflZ6ruDXgVgLQUyFV6vr2d4Mc/3B7Ja5rshfGRAaGI7xvLJ7Y5gQdzpqeArKgUx5BBEBLq3SOhnZ9F0xP1bvBU/jaPxZp90OnPGpLAFHkTQ9XhWJqvpIGGujUbbYXwYpcKHIs18ZZnglqbDvP+9k0p0iqIj3xy8=
Received: by 10.35.87.8 with SMTP id p8mr8998560pyl;
        Sat, 05 Aug 2006 22:23:01 -0700 (PDT)
Received: from ziti ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 38sm1072702nzf.2006.08.05.22.23.00;
        Sat, 05 Aug 2006 22:23:01 -0700 (PDT)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060805211337.GA31264@hand.yhbt.net> (Eric Wong's message of "Sat, 5 Aug 2006 14:13:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24965>

[cc'ing the list in case others are seeing similar, etc]

Eric Wong <normalperson@yhbt.net> writes:
> Seth Falcon <sethfalcon@gmail.com> wrote:
>> Hi Eric,
>> 
>> I just used git-svn commit to commit a change back to an svn
>> repository and a few files made it into the commit that didn't appear
>> in the git diff output.  This resulted in a "dirty" commit to the svn
>> repository.  Perhaps it is user error, but I would appreciate it if
>> you could take a quick look.
>> 
>> Here is the log for my git-svn branch:
>> 
>>    $ git log --stat remotes/git-svn
>>    commit 6a376fa49bb5e9917c6272d61c6ee0769674da34
>>    Merge: c40e1e6... e4a5813...
>>    Author: sethf <sethf@bc3139a8-67e5-0310-9ffc-ced21a209358>
>>    Date:   Sat Aug 5 18:02:01 2006 +0000
>>    
>>        Fixed bug in certain vectorized uses of removeEdge
>>        
>>        Thanks to Denise Scholtens for reporting.
>>        
>>        
>>        git-svn-id: https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks/graph@190
>>    commit e4a581328e194d545eb2e6a0e61f55c6d8ae56b8
>>    Author: Seth Falcon <seth@ziti.local>
>>    Date:   Sat Aug 5 11:00:59 2006 -0700
>>    
>>        Fixed bug in certain vectorized uses of removeEdge
>>        
>>        Thanks to Denise Scholtens for reporting.
>>    
>>     DESCRIPTION                    |    2 +-
>>     R/graphNEL.R                   |   23 ++++++++++++++++-------
>>     inst/unitTests/graphNEL_test.R |   40 +++++++++++++++++++++++++++++++++++++++-
>>     3 files changed, 56 insertions(+), 9 deletions(-)
>> 
>> git-svn log has:
>> 
>>    ------------------------------------------------------------------------
>>    r19045 | sethf | 2006-08-05 11:02:01 -0700 (Sat, 05 Aug 2006) | 4 lines
>>    
>>    Fixed bug in certain vectorized uses of removeEdge
>>    
>>    Thanks to Denise Scholtens for reporting.
>> 
>> Ok, looks good.  But in an updated svn working copy, I get:
>> 
>> svn log -v:
>>     ------------------------------------------------------------------------
>>     r19045 | sethf | 2006-08-05 11:02:01 -0700 (Sat, 05 Aug 2006) | 4 lines
>>     Changed paths:
>>        M /trunk/madman/Rpacks/graph/DESCRIPTION
>>        M /trunk/madman/Rpacks/graph/R/graphNEL.R
>>        M /trunk/madman/Rpacks/graph/inst/GXL/complexExample.gxl
>>        M /trunk/madman/Rpacks/graph/inst/GXL/simplExample.gxl.www
>>        M /trunk/madman/Rpacks/graph/inst/GXL/simpleExample.gxl
>>        M /trunk/madman/Rpacks/graph/inst/doc/GraphClass.tex
>>        M /trunk/madman/Rpacks/graph/inst/doc/GraphDesign.tex
>>        M /trunk/madman/Rpacks/graph/inst/unitTests/graphNEL_test.R
>>     
>>     Fixed bug in certain vectorized uses of removeEdge
>>     
>>     Thanks to Denise Scholtens for reporting.
>> 
>> Here is where you can see that a number of files "snuck" into the
>> commit.  When I looked at the diffs, it seemed to be line ending
>> changes only, but I was very surprised because 'git diff
>> remotes/git-svn..master' didn't show these, so I wasn't expecting them
>> to be part of the commit.
>
> That's very strange, git diff not showing anything suspicious.  The
> modified files have eol-style:native set on them, so it could be an
> issue with git-svn's eol-style handling.  From the info below, I assume
> you're _not_ using the SVN:: libraries, correct?

Right, I haven't installed any Perl libs out of laziness.  What are
the advantages of using the SVN:: libs?

> Looks like a bug, might as well cc the ml as it's a public repo.  I had
> issues accessing it with the SVN:: libraries, though (probably a
> permissions handling issue with git-svn) and had to use the
> command-line.

The repos is public, but you need --username=readonly
--password=readonly.

I think this is related to git-svn eol handling.  I tried the
following experiment:

Create a fresh git-svn repos along with a vanilla svn working copy.
Then diff.  I get differences in eol and I think there should be no
differences.

 ## create svn working copy
 svn co \
   https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks/graph graph-svn
 cd graph-svn
 svn update -r18986

 ## create git-svn repos
 cd ~/
 mkdir graph-git
 cd graph-git
 git-svn init https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks/graph
 git-svn fetch -r18300:18986
 git checkout master
 git diff remotes/git-svn..master  ## no output, as expected

 diff -ur inst/doc ~/graph-svn/inst/doc ## lots of output, unexpected


>> git-svn --version
>> git-svn version 1.4.2.rc3.g7e18e
>> 
>> git --version
>> git version 1.4.2.rc3.g7e18e
>> 
>> svn --version
>> svn, version 1.3.1 (r19032)
>> 
>> OSX 10.4.7


+ seth
