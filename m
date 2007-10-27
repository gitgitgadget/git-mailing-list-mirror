From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge vs rebase: Is visualization in gitk the only problem?
Date: Sat, 27 Oct 2007 10:58:14 +0200
Message-ID: <CEA39C15-F9AE-46F5-BBE9-3F7AB0711494@zib.de>
References: <8E86BDBA-A49A-49BB-8E00-8BF6DD7237E9@zib.de> <ee77f5c20710270116g45a644bp2b6783310e16ff20@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhTc-0003KC-Lm
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbXJ0I4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXJ0I4u
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:56:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:53448 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbXJ0I4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:56:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9R8uk58024141;
	Sat, 27 Oct 2007 10:56:47 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db19f2b.pool.einsundeins.de [77.177.159.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9R8ukee017821
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 27 Oct 2007 10:56:46 +0200 (MEST)
In-Reply-To: <ee77f5c20710270116g45a644bp2b6783310e16ff20@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62478>


On Oct 27, 2007, at 10:16 AM, David Symonds wrote:

> On 10/27/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>> Rebase has definitely benefits but not all of its details
>> are obvious at a first glance. Tell a newbie to read the
>> git rebase man page and explain what git reabase does and
>> you know what I mean. Rebase definitely can help to create a
>> cleaner history. But it rewrites history and therefore destroys
>> information, for example information about the original code
>> base a patch was developed against, or merge conflicts that
>> were resolved. You also need to decide when to use rebase and
>> when to use merge. So you need to make a choice.
>>
>> Why not always use git merge?
>
> I'd use git-rebase for when I'm sending stuff upstream that I don't
> want to force the maintainer to merge, because I can probably do it
> better and quicker by rebasing. Once that's done, the upstream
> maintainer can just do a git-am (or similar), and it'll apply neatly
> on top of the current head. In other words, git-rebase allows the
> "merge effort" to be shifted to the brancher and away from the
> mainline maintainer/developer.

That definitely makes sense.

But you may need to do more merging because you need to merge every
single commit. It may be easier to merge only the final state of
a topic branch.

Could we somehow send rerere information together with a
patch? This would give the upstream maintainer (and everyone
else who wants to test the patch) the help needed to do a merge.

	Steffen
