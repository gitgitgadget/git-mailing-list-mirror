From: Dave Jones <davej@redhat.com>
Subject: Re: FUNKY tags.
Date: Tue, 16 Aug 2005 22:47:18 -0400
Message-ID: <20050817024718.GA11734@redhat.com>
References: <20050816224332.GE26455@redhat.com> <46a038f90508161755b43735c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 04:47:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Dxq-0001N1-TI
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 04:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVHQCrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 22:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHQCrV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 22:47:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750791AbVHQCrU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 22:47:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j7H2lJaG030530;
	Tue, 16 Aug 2005 22:47:19 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j7H2lJV19130;
	Tue, 16 Aug 2005 22:47:19 -0400
Received: from nwo.kernelslacker.org (vpn50-3.rdu.redhat.com [172.16.50.3])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j7H2lIhv010668;
	Tue, 16 Aug 2005 22:47:19 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.4/8.13.4) with ESMTP id j7H2lIXe020873;
	Tue, 16 Aug 2005 22:47:18 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.4/8.13.4/Submit) id j7H2lIq0020872;
	Tue, 16 Aug 2005 22:47:18 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90508161755b43735c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2005 at 12:55:18PM +1200, Martin Langhoff wrote:
 > On 8/17/05, Dave Jones <davej@redhat.com> wrote:
 > > I've no idea what I did when I tagged those trees, but according
 > > to a google search, cvsps does that when it find patchsets which
 > > are chronologically (and thus by patchset id) earlier than the tag,
 > > but are tagwise after.  Spooky.
 > 
 > It's probably tags that were moved around with "cvs tag -F footag".
 > When using cvs in with a dovetail strategy, people tend to merge
 > BRANCH->HEAD and use a floating tag to mark how far it's been merged
 > in.

In my case, at least the most recent of those cvs tag operations
was just a 'cvs tag x86info-1_14'. Nothing fancy.  I'm fairly sure
there was nothing fancy about the earlier instance either.
So sure in fact, I had to look up that -F flag in the man page to find
out what it did.

x86info cvs shouldn't even have any branches, so theres no strange
head merging going on.

 > I am somewhat worried about cvsps getting confused by these floating
 > tags. Any help in teaching cvsps to ignore tags is welcome ;)

If you're curious, its a sourceforge project at cvs.sourceforge.net:/cvsroot/x86info
module is 'x86info'.  Both x86info-1_14 and x86info-1_6 are marked as funky
for reasons I'm unaware.

		Dave
