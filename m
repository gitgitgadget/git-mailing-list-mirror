From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 13:52:35 -0700
Message-ID: <86odjjziek.fsf@blue.stonehenge.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<86zm33291h.fsf@blue.stonehenge.com>
	<20070613192828.GB3412@steel.home>
	<86645r1wh8.fsf@blue.stonehenge.com>
	<20070613204711.GC3412@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZpZ-0001Ze-2l
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbXFMUwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 16:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbXFMUwi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:52:38 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:44591 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbXFMUwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 16:52:38 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id F35731DE99E; Wed, 13 Jun 2007 13:52:35 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.7.2; tzolkin = 1 Ik; haab = 10 Zotz
In-Reply-To: <20070613204711.GC3412@steel.home> (Alex Riesen's message of "Wed, 13 Jun 2007 22:47:11 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50130>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> No, it wont. What files are you going to add?

Whatever you are working on.  Whatever you want tracked.  It's a commit.
I'm not sure why you're having trouble following me.  What did I leave out?

>> git-rebase *will* do the merge.  It must. :)

Alex> It won't merge anything which isn't known to git.

And that's irrelevant, because my first step *did* a commit so they are
*known* to git.

Alex>  Now, I come to think
Alex> about it, no existing merge method will help you here (and very likely
Alex> it shouldn't).

Yes, it should.  You're merging your changes onto the upstream.  This
happens dozens of times a day with git repos all over the world. :)

Alex> It is actually much simplier doing things right: all this stashing
Alex> people keep talking about.

Yes, and that's what I said too.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
