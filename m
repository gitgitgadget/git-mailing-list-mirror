From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sat, 24 May 2008 22:47:06 +0200
Message-ID: <200805242247.07565.jnareb@gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com> <5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com> <20080524195957.GC3745@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Govind Salinas <blix@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 22:48:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K00f6-0001yv-Po
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 22:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760554AbYEXUrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 16:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760468AbYEXUrS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 16:47:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:22468 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760008AbYEXUrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 16:47:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so620748nfc.21
        for <git@vger.kernel.org>; Sat, 24 May 2008 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=QMvvwlJNVQ12H4kdO9tmGLZRep9Swl3GsrepU1S5gvk=;
        b=G3g+8Y05xHsZMlKc8qxarpanDoy0lBpoZSehCcY3o+1sejlYiuao+aJfAbi54GNMMSBtw8frhz7z4raZvMfzlFHKpETPDH3Z00Ildpn9rP+jMr35pbT5VhspNRpkgd7csTJZJuH6hwGVVG6sMn0FaMKirLE70uSR2+8vRiA8fvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J6gCwp9XmHmRqvJDviXvuz+B7iWAtva89s9V05IxWJtZbbqAI3W9N1WGrTd0XtIFUKHRkZRjhbaW1ITpMG7ZDVI6L26zsfvdLYTNBcKo1O67VXNQ0OPvR/f2sVA/OYP0AqqyLeYRun9wX5jCQS4WcIzc22AX77gB5Jp4zPYe9T4=
Received: by 10.210.65.2 with SMTP id n2mr2468865eba.48.1211662035715;
        Sat, 24 May 2008 13:47:15 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.233.1])
        by mx.google.com with ESMTPS id b30sm7825711ika.3.2008.05.24.13.47.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 13:47:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080524195957.GC3745@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82827>

On Sat, 24 May 2008, Dmitry Potapov wrote:
> On Sat, May 24, 2008 at 12:16:17AM -0500, Govind Salinas wrote:
>> On Fri, May 23, 2008 at 8:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>>>
>>>> 1) Reduce the number of commands.
>>>>
>>>> I am currently at 30 total commands, and while I have some more to go, I
>>>> think there are some ways that I can get rid of some of them by
>>>> combining them.  Do we really need a clone, branch and checkout?  Don't
>>>> these all mean the same thing in the end?  They mean get me a working
>>>> directory of the repository starting at X.  For clone, you start
>>>> with 'master'. For checkout, you tell it what to get you.  Branch
>>>> will help you manage things you can locally get.  So perhaps we can
>>>> do something like the following...
>>>
>>> Note that you sometimes want to make a branch without checking it out.
>>> Also note that git-branch is overloaded to get a list of branches
>>> available.
>>>
>> 
>> Sure, removing commands is not about removing features, its about
>> reducing the learning curve and reducing confusion.
> 
> I don't see how hiding creating branch functionality behind some other
> command will help with learning curve or reduce confusion. If I started
> to use any new SCM and had to create a new branch, I would look for the
> "branch" command. If there is something wrong with the git-branch then
> it is that this command does not checkout the newly created branch by
> default. So, I usually create branches using git-checkout, which is
> counterintuitive.

That of course depends on the point of view [1].  Branches in git
are "growth point" pointers to DAG of revisions.  git-branch lists
and creates branches, and can be used to rename and delete branches
as well, and to enable reflog for branch.  It does not touch working
area; separation of domains.  (Note that sometimes you want to create
branch without checking it out).

git-checkout on the other hand is used to bring working area to given
state, usually from given branch (switching branches) or arbitrary
revision (detaching HEAD), but in some cases (with filename/pathspec)
from index.

Now, the seqence of
  $ git branch <newbranch>
  $ git checkout <newbranch>
could be written as
  $ git checkout -b <newbranch>
but could have been done as
  $ git branch -c <newbranch>
instead.  I think it is largely matter of priorities, taste... and
of course historical reasons and backwards compatibility.
 
> I don't think any commonly used SCM unites 'clone', 'branch', and
> 'checkout' functionality under the same name. This approach seems
> to be more confusing than helpful.

This is also my opinion.  Perhaps 'clone' and 'init', or 'clone' and
'import' could be the same command... hat might make sense...

Footnotes:
==========
[1] "The only intuitive interface is the nipple; everything else is
    learned." (attribution, anyone?)
-- 
Jakub Narebski
Poland
