From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 04 Feb 2008 20:42:49 -0600
Message-ID: <47A7CD29.40306@nrlssc.navy.mil>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil> <alpine.LSU.1.00.0802042128170.8543@racer.site> <47A78CF9.6040001@nrlssc.navy.mil> <alpine.LSU.1.00.0802042218280.8543@racer.site> <47A79541.6070900@nrlssc.navy.mil> <alpine.LSU.1.00.0802050047340.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 03:43:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMDmc-0003sX-MO
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 03:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbYBECnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 21:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbYBECnD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 21:43:03 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44991 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbYBECnB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 21:43:01 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m152gonL016137;
	Mon, 4 Feb 2008 20:42:50 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Feb 2008 20:42:50 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0802050047340.8543@racer.site>
X-OriginalArrivalTime: 05 Feb 2008 02:42:50.0049 (UTC) FILETIME=[CC532B10:01C867A0]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--12.842900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAzNzg4LTcwNjE1OS03MDcxMTktMTA1NzAwLTcwNzQxNi03?=
	=?us-ascii?B?MDU5NjktNzAxODM3LTcwMjcyNi03MDE2MTgtNzAzNzEyLTcwMjM1?=
	=?us-ascii?B?OC03MDUzODgtNzA1MjExLTcwMTc0Ny0xMDU2NDAtNzA0NDI1LTcx?=
	=?us-ascii?B?MTk1My0xMDUwNDAtNzAxNDU1LTcwODE3OS03MDc0NTEtNzAxNDM3?=
	=?us-ascii?B?LTcwMjAyMC03MDEwMDUtNzAyMDQ0LTcwMDY5My03MDk4MDMtNzA3?=
	=?us-ascii?B?Nzg4LTcxMDIwNy03MDQ0MTAtNzAxMjQ5LTcwNTUwOC0xMzk1MDQt?=
	=?us-ascii?B?NzA2NDU0LTcxMTQzMi03MDIwNjctNzA1MTY3LTcwMTA5OS03MDA3?=
	=?us-ascii?B?NTYtNzA1NjgzLTcwMDg0OS03MDE5MzctNzAzMTU3LTcwOTgyMy03?=
	=?us-ascii?B?MDMyNjctNzA2ODkxLTcwMjE4Ny03MDE3MzgtMTM2MDcwLTE0ODAz?=
	=?us-ascii?B?OS0xNDgwNTEtMjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72614>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 4 Feb 2008, Brandon Casey wrote:
> 
>> When we talk about clones we are not always talking about a strict 
>> "full" clone.
> 
> Here, sir, we disagree.  I tend to like the fact that a clone is a clone 
> is a clone.  Which BTW is the reason why I do not like requests to "clone" 
> only one branch: this is not a clone.

It seems the git-clone utility has been extended to create more than just
clones in that case.

My use of the term "clone" with respect to git, is to refer to the product
of the git-clone utility. With that in mind, git-clone produces all of the
repo/work-dir combinations I described.

The strict (or precise) definition of "clone" seems like a subset of the
more generic "create new repository/workdir from existing repository". The
different options then allow you to control how the new repo/workdir is
structured.

We don't currently have a generic "create new repository/workdir from
existing repository" command. So people have been using git-clone to
create new repository/workdir's and calling the result clones, even
though they could have produced the same result by running some sequence
of mkdir, git init, and git pull.

>> If your statement above is rephrased to "I _want_ the original 
>> repository to know that it has conjoined siblings.", then we have a new 
>> repository type:
>>
>> 	4) conjoined repository (it has multiple sibling repositories each
>> 	   with their own working directory, but they all share and modify the
>> 	   same .git directory)
> 
> No.  The repository does not even need a working directory (in which case 
> we call it "bare").

The additional term "bare" that is used with such a repository without a
working directory implies to me that this is a "special" or "uncommon"
repository configuration.

I think in many places in the documentation and it seems in common use on
the mailing list, the contents of the directory created by git-clone is
informally referred to as the repository. This is even though most people
understand that the precise definition of repository is the .git directory
and the rest of the contents are the working directory.

So I hope you excuse me for referring to the result of git-clone as a
repository. I'll try to think of something else to call it (above I used
repo/workdir).

None of that changes my opinion that a descent model for the user interface
is to have two high-level commands that create repo/workdir's.

     git-init: creates a new repo/workdir from scratch.
    git-clone: creates a new repo/workdir from an existing repository.

Or the opinion that git-clone is a closer operation to creating a new working
directory and associating it with a repository than either git-branch or
git-checkout, which in normal usage (i.e. _not_ setting GIT_DIR or using
--git-dir) operate within a working directory.

With that, I think I have described my thinking well enough, so I won't continue
any more unless you really ask a question.

>  Up until now, it _can_ have _one_ working directory.  
> With my plans, it can have more than one.

I'm looking forward to your plans, since I find the git-new-workdir script very
useful.

-brandon
