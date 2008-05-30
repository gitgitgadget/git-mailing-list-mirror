From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: Confused about recovering from a merge conflict
Date: Fri, 30 May 2008 08:42:57 -0500
Message-ID: <c0f2d4110805300642re4e66dx7b62de3fd5afd78d@mail.gmail.com>
References: <482B0C52.4030206@et.gatech.edu>
	 <c0f2d4110805290949m18822c3x15675bed83c7fa5@mail.gmail.com>
	 <483F0895.6040104@et.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: stuart.freeman@et.gatech.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 15:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24tc-0004TB-R2
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 15:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbYE3NnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 09:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbYE3NnA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 09:43:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:54091 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbYE3Nm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 09:42:59 -0400
Received: by ug-out-1314.google.com with SMTP id h2so317552ugf.16
        for <git@vger.kernel.org>; Fri, 30 May 2008 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/IrjnMVbhXXl4TJk3tKQdpCk4JzSgneedQovBXfZVQU=;
        b=CA0cWAtlBHG2EYBuTy1T+qlITtXBKtEQ9WA8TE5LtagHynJGcfG5IjowYlmOwK4F7n3KNhAAsmyUy8qLoHW1nAabM+jOLLiabeYEaS3zXnDw4XPzn3r92gFwwujai+CdmUxX46Ihil4YE6O8iJHtdI1JbdWYm8W7LVHzmqRBMmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sP4eWlRrbtDasjylQo+efvrAsnY5F0pzfT4449ytbz/0kc4wKkYQp2hl2tVUk/dGWzZxFy8XaLqwOST8Vqf8ruLFFrVvo1FCUgIOH1vqGbXjT+RlOY2bGEfxddxqwavf6jeU3PERPl9kJQV5Nx3NH9vI3VJbx2cerE/++S9hTJQ=
Received: by 10.86.63.19 with SMTP id l19mr206021fga.77.1212154977615;
        Fri, 30 May 2008 06:42:57 -0700 (PDT)
Received: by 10.86.50.10 with HTTP; Fri, 30 May 2008 06:42:57 -0700 (PDT)
In-Reply-To: <483F0895.6040104@et.gatech.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83301>

I wonder if it has to do with windows just sucking at disk access?
I am getting some other weirdness like dirty index even though nothing
shows up with git status and after doing a git reset --hard HEAD

On Thu, May 29, 2008 at 2:48 PM, D. Stuart Freeman
<stuart.freeman@et.gatech.edu> wrote:
> It was actually my boss that ran into this, he's using msysgit on XP.
> I'm not sure what service pack.
>
> Chris Ortman wrote:
>> I am also running into this problem.
>> Are you running windows+cygwin or git on linux?
>> I am on XPSP2 and cygwin
>>
>> On Wed, May 14, 2008 at 10:59 AM, D. Stuart Freeman
>> <stuart.freeman@et.gatech.edu> wrote:
>>> I've made some local modifications and want to 'git svn dcommit' them so
>>> I 'git svn rebase' first:
>>>
>>>  $ git svn rebase
>>>  First, rewinding head to replay your work on top of it...
>>>  HEAD is now at cdef7ac Cleanup of new assignment screens
>>>  Applying Cleanup new assignment screens
>>>  error: tool/src/webapp/content/css/thickbox.css: does not match index
>>>  error: patch failed:
>>> tool/src/webapp/content/templates/newassignment1.html:6
>>>  error: tool/src/webapp/content/templates/newassignment1.html: patch
>>> does not apply
>>>  Using index info to reconstruct a base tree...
>>>  Falling back to patching base and 3-way merge...
>>>  error: Entry 'tool/src/webapp/content/css/thickbox.css' not uptodate.
>>> Cannot merge.
>>>  fatal: merging of trees aa2dad90c89e9063f2a8002e4b5a11f6b1583955 and
>>> 6535ebaaebf
>>>  fdaadd44a93bc1fc4a66a5ec4dcf4 failed
>>>  Failed to merge in the changes.
>>>  Patch failed at 0001.
>>>
>>>  When you have resolved this problem run "git rebase --continue".
>>>  If you would prefer to skip this patch, instead run "git rebase --skip".
>>>  To restore the original branch and stop rebasing run "git rebase --abort".
>>>
>>>  rebase refs/remotes/iteration_5: command returned error: 1
>>>
>>> Uh-oh, now I appear to be on 'no branch' and the contents of
>>> thickbox.css aren't marked up with the conflict markers, it appears to
>>> just be the old file without my revisions.  Did I do something wrong?
>>> How do I recover from this state?
>>>
>>> --
>>> D. Stuart Freeman
>>> Georgia Institute of Technology
>>>
>
>
> --
> D. Stuart Freeman
> Georgia Institute of Technology
>
