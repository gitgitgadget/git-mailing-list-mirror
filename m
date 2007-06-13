From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 12:32:35 -0700
Message-ID: <86645r1wh8.fsf@blue.stonehenge.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<86zm33291h.fsf@blue.stonehenge.com>
	<20070613192828.GB3412@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 21:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyYcM-0007KB-P3
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 21:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbXFMTci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 15:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbXFMTci
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 15:32:38 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:24794 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbXFMTch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 15:32:37 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3539F1DE4FA; Wed, 13 Jun 2007 12:32:35 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.7.2; tzolkin = 1 Ik; haab = 10 Zotz
In-Reply-To: <20070613192828.GB3412@steel.home> (Alex Riesen's message of "Wed, 13 Jun 2007 21:28:28 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50121>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> Wont work for new files (not yet known to git) which conflict with the
Alex> same names from origin. Your method will not put them anywhere and
Alex> their presence will break git-rebase. You _must_ do a merge.

So I missed git-add for those.  Then it'll work.  I guess I implied that the
git-commit initial step should capture all of the "interesting" state.

git-rebase *will* do the merge.  It must. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
