From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 17:31:40 +0900
Message-ID: <20090114173140.6117@nanako3.lavabit.com>
References: <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
 <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 09:34:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN1Cl-0006hT-RA
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 09:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158AbZANIdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 03:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757090AbZANIdG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 03:33:06 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36969 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757071AbZANIdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 03:33:04 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 30E3DC7B34;
	Wed, 14 Jan 2009 02:33:02 -0600 (CST)
Received: from 9863.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id GDOLG4REWXS0; Wed, 14 Jan 2009 02:33:02 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=2nlS9YIdDhCBZNC7NT0SQBwTEWm/46iZ3vnyyK3UVwdfyDOIgOYShQm98q0B6WtANBgF04yalDXdvgnQjk10ki8U4YxvQlx3mlXlMzRZRKzKr+kCFft+ggkFocjnkZQzZubuaMetIf5aJeP9jWjDk2T1m37qbV/0cJwXcEtJOGY=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105601>

Quoting skillzero@gmail.com:

> The problem is, by the time I wanted to do the cherry-pick, I had
> already committed other stuff to the branch. I tried doing 'git rebase
> master branch' when on master and it just applied all the stuff from
> master to branch.
>
> Is there any way to apply a commit to 2 different branches (which have
> diverged) in a way that git will remember so that when the 2 branches
> merge later, it won't result in duplicate commits? I find that I often
> make changes that days or weeks later find out that some other branch
> needs that change and by then, there have been lots of commits to both
> branches after the commit I want.

Johennes Sixt gave a good answer. You need to think before making your commits while you are developing to separate what change belongs to common code base and what change belongs to a specific feature.

I was reading gitster's blog (he has several "git tutorial" articles recently) and he talks about how to commit a change to a branch different from what you originally developed it on in today's entry. You may find it instructive, but the procedure is after you think about it and decide what change goes where.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
