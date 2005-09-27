From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix default pull not to do an unintended Octopus.
Date: Tue, 27 Sep 2005 15:24:26 -0700
Message-ID: <7vachyywrp.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<200509271152.42963.Josef.Weidendorfer@gmx.de>
	<20050927125434.GF30889@pasky.or.cz>
	<200509271635.12907.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 00:25:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKNsI-0003uw-BV
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 00:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVI0WY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 18:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVI0WY3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 18:24:29 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20902 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751121AbVI0WY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 18:24:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927222427.HAER19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 18:24:27 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9418>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Tuesday 27 September 2005 14:54, you wrote:
>> Yes. I'm actually inclined to keep this setup, simply because it is
>>
>>   * easy
>>   * simple
>>   * sufficient in most of the cases
>
> I would almost say: sufficient for all cases.
> The .git/remotes stuff is about providing a shortcut for remote
> repositories and about defaults for this repository.
> I am not really sure this is needed, and this second use of a name
> (additionally to head names) can be confusing.

I suspect you've never played with remote repositories with 47
different heads.
