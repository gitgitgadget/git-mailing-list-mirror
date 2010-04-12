From: Eric LEBIGOT <Eric.Lebigot@normalesup.org>
Subject: Re: Is it possible to have a file shared between branches?
Date: Mon, 12 Apr 2010 16:46:11 +0200 (CEST)
Message-ID: <alpine.OSX.2.01.1004121639230.60420@kroll.spectro.jussieu.fr>
References: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr> <m3ljctf0hs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:46:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1KuC-0002zS-5F
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab0DLOqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 10:46:21 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:53540 "EHLO shiva.jussieu.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab0DLOqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 10:46:21 -0400
Received: from y-wing.spectro.jussieu.fr (y-wing.spectro.jussieu.fr [134.157.7.7])
          by shiva.jussieu.fr (8.14.3/jtpda-5.4) with ESMTP id o3CEkImj019943
          ; Mon, 12 Apr 2010 16:46:18 +0200 (CEST)
X-Ids: 164
Received: from kroll.spectro.jussieu.fr (kroll.spectro.jussieu.fr [134.157.7.136])
          by y-wing.spectro.jussieu.fr (8.14.2/jtpda-5.4) with ESMTP id o3CEkGGi016779
          ; Mon, 12 Apr 2010 16:46:16 +0200
X-X-Sender: lebigot@kroll.spectro.jussieu.fr
In-Reply-To: <m3ljctf0hs.fsf@localhost.localdomain>
User-Agent: Alpine 2.01 (OSX 1266 2009-07-14)
X-Virus-Scanned: ClamAV 0.94.2/10729/Mon Apr 12 14:02:21 2010 on shiva.jussieu.fr
X-Virus-Status: Clean
X-Miltered: at jchkmail.jussieu.fr with ID 4BC3323A.003 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 4BC3323A.003/134.157.7.7/y-wing.spectro.jussieu.fr/y-wing.spectro.jussieu.fr/<Eric.Lebigot@normalesup.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144736>

Thank you!  I can see what is done in the git.git repository, thanks to your 
pointer, and it looks like I'm trying to get from git.  But how do you create 
and manage such an independent 'todo' branch?  This branch appears on the 
same level as master, in the pages you gave, but you also mention a "non 
versioned Meta/ directory".  Does this mean that the file structure is like 
the following?

  ./.git
  Meta/.git
  Meta/<todo files>

If yes, how do all branches appear at the same level in 
http://git.kernel.org/?p=git/git.git;a=summary ?  If no, how was the 'todo' 
branch created?  (I would love to have the todo file in the same directory as 
the rest.)

EOL

On Mon, 12 Apr 2010, Jakub Narebski wrote:

> Eric LEBIGOT <Eric.Lebigot@normalesup.org> writes:
>
>> Is it possible for git to track a single file that would be shared
>> accross branches?  Case in point: a to-do list file that describes
>> what has to be done in all the branches; it can be convenient to put
>> all the things that have to be done in a single, shared file, while
>> keeping this to-do list in sync with the code (so that it lists what
>> has been done, and what remains to be done).  Committing in a branch
>> would in effect also commit the shared file in the other branches
>> (another possibility may be to have in effect many "trees" in a single
>> git directory, with a specific tree for the to-do list).
>>
>> Is this something git can do?
>
> Look how it is done in git.git repository.  If I remember it
> correctly, Junio manages separate small repository inside
> non-versioned Meta/ directory inside git.git checkout, which contains
> TODO list and some scripts to help maintenance (e.g. to help generate
> "What's in..." and "What's cooking..." emails).
>
> For distribution this repository is pushed into independent 'todo'
> branch in git.git repository.  It doesn't share commits with other
> "normal" branches, i.e. 'maint', 'master', 'next', 'pu'.
>
> The 'todo' branch can be seen e.g. here:
>  http://git.kernel.org/?p=git/git.git;a=shortlog;h=refs/heads/todo
>
> The history of TODO file can be viewed e.g. here:
>  http://git.kernel.org/?p=git/git.git;a=history;f=TODO;hb=refs/heads/todo
>
>
