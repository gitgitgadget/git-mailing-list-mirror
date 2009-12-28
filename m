From: david@lang.hm
Subject: Re: immutable tags?
Date: Mon, 28 Dec 2009 13:15:39 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0912281311030.24130@asgard.lang.hm>
References: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>  <alpine.DEB.2.00.0912281223440.24130@asgard.lang.hm> <92c9564e0912281239h49f9138ena8bbb3a63a337a55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-530462559-1262034939=:24130"
Cc: git@vger.kernel.org
To: Carlos Santana <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 22:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMwM-000073-2G
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 22:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbZL1VPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 16:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbZL1VPk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 16:15:40 -0500
Received: from mail.lang.hm ([64.81.33.126]:41933 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbZL1VPk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 16:15:40 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id nBSLFdMQ006853;
	Mon, 28 Dec 2009 13:15:39 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <92c9564e0912281239h49f9138ena8bbb3a63a337a55@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135763>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-530462559-1262034939=:24130
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 28 Dec 2009, Carlos Santana wrote:

> Thanks for the reply David.
> I think 'tagged directory' wasn't the appropriate phrase here.
>
> In Subversion like systems branches and tags are same, i.e., both are
> created using 'svn copy'. Branches are generally created for separate
> line of development and tags for releasing software. So developers
> follow convention of not checking in anything into tags. Otherwise
> they are same.
>
> I know that creating branches/tags doesn't involve copying files into
> new directory in case of git. It will act as a pointer and make note
> of changes thereafter. What I am not sure is difference between
> branches and tags. Is it left to developer to follow subversion like
> convention or git provides some mechanism to 'lock' tags?

git works very differently than subversion. All of git history is a 
branching tree of commits, all that a tag is is a pointer to a particular 
commit somewhere in this tree. it does not have the be the most recent 
commit on the branch.

all branches are (pretty much) equal, you can commit and do development on 
any branch.

as you say above, branches are seperate lines of development and tags can 
point at releases, but when you have a branch that you are doing 
development on, you don't have to stop doing development there when you do 
a release, anyone who checks out the tag will get the same thing no matter 
what additional development you do on that branch in the future.

does this help?

David Lang

> -
> CS.
>
>
>
> On Mon, Dec 28, 2009 at 2:25 PM,  <david@lang.hm> wrote:
>> On Mon, 28 Dec 2009, Carlos Santana wrote:
>>
>>> I would like to know if there is any difference between branches and
>>> tags. Is it only conceptual - convention to be followed by a developer
>>> or some technical difference?  e.g. : Is it possible to create
>>> immutable tags so that nothing can be checked in to that 'tagged
>>> directory'?
>>
>> tags are pointers into the tree. tags do not change.
>>
>> in git directories are not tagged, so I'm not sure what you are working
>> towards here.
>>
>> David Lang
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--680960-530462559-1262034939=:24130--
