From: Joel Dice <dicej@mailsnare.net>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 10:13:15 -0600 (MDT)
Message-ID: <Pine.LNX.4.62.0609200851450.9752@joeldicepc.ecovate.com>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <Pine.LNX.4.64.0609191416500.4388@g5.osdl.org> <20060919220604.GE8259@pasky.or.cz>
 <Pine.LNX.4.64.0609191519090.4388@g5.osdl.org>
 <Pine.LNX.4.62.0609191709160.9752@joeldicepc.ecovate.com> <eeq14e$isu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Wed Sep 20 18:13:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4hZ-0001u4-Pa
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWITQNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWITQNY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:13:24 -0400
Received: from v187.mailsnare.net ([206.246.200.187]:40124 "EHLO
	mail.mailsnare.net") by vger.kernel.org with ESMTP id S1751723AbWITQNX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:13:23 -0400
Received: from joeldicepc.ecovate.com (unknown [208.50.222.162])
	by mail.mailsnare.net (Postfix) with ESMTP id 8068D2BF03
	for <git@vger.kernel.org>; Wed, 20 Sep 2006 16:13:16 +0000 (UTC)
To: git@vger.kernel.org
In-Reply-To: <eeq14e$isu$1@sea.gmane.org>
X-Virus-Scanned: by ClamAV at mailsnare.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27360>

On Wed, 20 Sep 2006, Jakub Narebski wrote:
> Joel Dice wrote:
>> Well, what it means is "this is the order in which commits were applied to
>> this repository".  I suggest that this information is useful for the most
>> common development style - the kind which relies on a central repository
>> as the canonical source for a project's code.  "gcc-trunk-r117064" means a
>> lot more to me than "39282037d7cc39829f1d56bf8307b8e5430d585f", and is no
>> less precise.
>
> What about "v1.4.2.1-gf7f93e7", or "tags/v1.4.2-rc4^0~19", or just
> "39282037"? Or "next@{2006-09-19 22:44:33 +0000}"?

The last one is closest to what I want in that it gives me some sense of 
the order in which commits appeared in the repository.

Anyway, after some reflection, I've come to the following conclusions:

  1. Although the IRN feature would be useful to people like me, it doesn't 
fit _naturally_ into Git in particular or DVCSs in general due to the 
fact that IRNs are tied to repositories.

  2. There are easier, more elegant ways to solve the problem of tying 
commits to bug numbers, as Shawn and Johannes pointed out.

So, I'm shelving the IRN idea until and unless I can reconcile it with the 
spirit of distributed version control.  In the meantime, I plan to pursue 
a solution along the lines of Shawn's update hook strategy for bug 
tracking, perhaps with the additional step of automatically tagging each 
such update.

Thanks for everyone's comments.

  - Joel
