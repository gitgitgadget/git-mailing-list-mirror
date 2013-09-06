From: Tim Chase <git@tim.thechases.com>
Subject: Re: coming from git, understanding mercurial branching
Date: Fri, 6 Sep 2013 08:26:21 -0500
Message-ID: <20130906082621.01162905@bigbox.christie.dr>
References: <20130905212714.636db4c4@bigbox.christie.dr>
	<CALUzUxoa7Lw-_sj3LRj-9=hSh17hi+j4JhfAPKaDfhuE8PnKCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 15:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHw2I-0003kt-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 15:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391Ab3IFNZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 09:25:12 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:60343 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707Ab3IFNZL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 09:25:11 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:53019 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1VHw2B-0003vJ-4W
	for git@vger.kernel.org; Fri, 06 Sep 2013 08:25:11 -0500
In-Reply-To: <CALUzUxoa7Lw-_sj3LRj-9=hSh17hi+j4JhfAPKaDfhuE8PnKCA@mail.gmail.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234048>

On 2013-09-06 12:39, Tay Ray Chuan wrote:
> First: recognize Mercurial's branches are entirely different beasts
> from Git's. They just happen to be given a same sequence of
> characters, b-r-a-n-c-h. The similarities end there!

Yeah, I'm trying to create a mental map between what Git means by
branching, and what Mercurial means by branching.  As you say, they
seem to be entirely different beasts.

> > often the docs suggest cloning instead of branching;
> 
> Are you referring to this?
> 
>   $ hg clone https://... master
>   $ cd master
>   # hack...
> 
>   $ cd ..
>   $ hg clone https://... fix1

Usually I see this written as

  $ cd ..
  $ hg clone master fix1

but otherwise, yes.

>   $ cd fix1
>   # hack...
> 
>   $ cd../master
>   $ hg pull ../fix1
>   $ hg merge ...
> 
> In git, you would have your master branch, checkout -b fix1, then
> merge them back to master when you're done. The above describes how
> one would do this in mercurial.

Mercurial has this cloning-branch thing, a "branch" command, and
something called "bookmarks" which all seem to have different
behaviors (and corresponding reasons to choose them) and yet all be
loosely referred to as "branching".  Cloning litters the drive with
duplicate checkouts (even if they use hard-linking for the repo
behind the scenes, there's still a lot of time spent writing.  The
git equiv of this hg suite would be almost identical, cloning a
local checkout); the 2nd and 3rd are more branch-related and what I'm
trying to grok.

-tkc
