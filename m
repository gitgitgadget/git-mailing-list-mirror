From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Understanding When to Use Branches
Date: Tue, 8 Jan 2013 21:08:00 +0400
Message-ID: <20130108210800.c10104667727c8c9c4d2324d@domain007.com>
References: <50EC232D.90009@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: gw1500 <wtriker.ffe@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:24:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tscu7-00080k-2D
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab3AHRXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:23:39 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:41769 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3AHRXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:23:39 -0500
X-Greylist: delayed 934 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2013 12:23:38 EST
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r08H80GE029009;
	Tue, 8 Jan 2013 21:08:01 +0400
In-Reply-To: <50EC232D.90009@yahoo.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212978>

On Tue, 08 Jan 2013 08:46:21 -0500
gw1500 <wtriker.ffe@gmail.com> wrote:

> As a git noobie I am beginning get get my head around git's version
> control philosophy. I am now trying to understand the purposes of
> branches or rather when to use them. In my case I have a Java
> application under version control with git. I am planning to port it
> into a mobile app. Is that an appropriate use of branches or should it
> be created as a new repository? What is the relationship between the
> same source code in different branches? Do changes to code in one
> branch get ported to another branch somehow or do all changes then
> have to be made twice? The documentation tells how to branch but not
> the general philosophy behind it from a best practices standpoint.
> Thanks in advance for any insight.

Supposedly you should start with the chapter on branching in
The Book [1] and then read two classic blog posts [2, 3] describing two
different branching models.  The branching models described there are
not the only two possible models to use with Git, but they are different
enough to give you a good overview of possibilities.
Note that mere googling for "git branching model" would yield a fair
number of blog posts on people's pet branching models; these two
documents just appear to be more "classic" than others.

If you have difficulty to even grasping the concept of branches and [1]
feeld hard to digest, try first reading "The Git Parable" [4] which, I
think, is the friendliest possible introduction to the basics of DVCS,
branching included.

1. http://git-scm.com/book/en/Git-Branching
2. http://nvie.com/posts/a-successful-git-branching-model/
3. http://scottchacon.com/2011/08/31/github-flow.html
4. http://tom.preston-werner.com/2009/05/19/the-git-parable.html
