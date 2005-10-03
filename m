From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after 0.99.8
Date: Sun, 02 Oct 2005 21:00:12 -0700
Message-ID: <7vfyrjw8qb.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<4340A01F.7040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 06:01:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMHV3-000459-NE
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 06:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVJCEAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 00:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVJCEAS
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 00:00:18 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20211 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932137AbVJCEAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 00:00:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051003040007.RRAX29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Oct 2005 00:00:07 -0400
To: gitzilla@gmail.com
In-Reply-To: <4340A01F.7040901@gmail.com> (A. Large Angry's message of "Sun,
	02 Oct 2005 20:06:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9629>

A Large Angry SCM <gitzilla@gmail.com> writes:

> If you were to publish the ToDo to the mailing list once a week it might 
> encourage more of those patches you want to accept.

Hmph.  I tend to dislike periodical posting that is more often
than once a month.

>> * Accept patches to finish missing docs.
>
> A list of missing, incomplete, and/or wrong docs in the ToDo file would 
> help focus effort when people (like me) have space cycles.

Well, the thing is, I am not good at documentation, especially
when I have other interests, and once I start writing a list of
missing or incomplete docs, my interests _will_ shift to fill in
those gaps and I will end up doing them myself, which means I
would not have a chance to place the list in the TODO file.

>> Technical (heavier)
>> -------------------
> ...
>> * Maybe a pack optimizer.
>
> Huh?

Given a set of objects and a set of refs (probably a handful
branch heads and point release tags), find a set of packs to
allow reasonably minimum download for all of these classes of
people: (1) somebody cloning the repository from scratch, (2)
somebody who tends to follow the master branch head reasonably
closely, (3) somebody who tends to follow only the point
releases.

>> * Internally split the project into non-doc and doc parts; add
>>   an extra root for the doc part and merge from it; move the
>>   internal doc source to a separate repository, like the +Meta
>>   repository; experiment if this results in a reasonable
>>   workflow, and document it in howto form if it does.
>
> I think this is a bad idea. The docs should be part of the project 
> (repository and head) as the code. Otherwise, they'll become even more 
> out-of-sync.

The point was to make it possible to fork that part off to
somebody else; then I do not have to maintain Documentation
directory myself anymore, just like I simply slurp the latest
gitk from Paul and not worry about it ;-).

>> Technical (trivial)
>> -------------------
>>
> ...
>> * 'git merge-projects'?
>
> Huh?

    Subject: Re: Merges without bases
    References: <1125004228.4110.20.camel@localhost.localdomain>
    Date: Thu, 25 Aug 2005 15:26:36 -0700
    Message-ID: <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
