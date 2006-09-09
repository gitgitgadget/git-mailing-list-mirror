From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Sat, 09 Sep 2006 02:10:23 -0700
Message-ID: <7vvenxwglc.fsf@assigned-by-dhcp.cox.net>
References: <200609061504.40725.jnareb@gmail.com> <edtuot$p76$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 11:10:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLyqe-0003ib-0m
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 11:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWIIJJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 05:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIIJJ5
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 05:09:57 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64687 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751400AbWIIJJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 05:09:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060909090956.KLSS26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Sep 2006 05:09:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id L99l1V0031kojtg0000000
	Sat, 09 Sep 2006 05:09:47 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edtuot$p76$2@sea.gmane.org> (Jakub Narebski's message of "Sat,
	09 Sep 2006 10:42:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26740>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> Shortlog:
>>  [PATCH 1/7] gitweb: Make pickaxe search a feature
>>  [PATCH 2/7] gitweb: Paginate history output
>>  [PATCH 3/7] gitweb: Use @hist_opts as git-rev-list parameters
>>              in git_history
>>  [PATCH 4/7] gitweb: Add parse_rev_list for later use
>>  [PATCH 5/7] gitweb: Use parse_rev_list in git_shortlog and git_history
>>  [PATCH 6/7] gitweb: Assume parsed revision list in git_shortlog_body
>>              and git_history_body
>>  [PATCH 7/7] gitweb: Set page to 0 if it is not defined, in git_history
>
> Should I resend corrected patch 1 (Make pickaxe search a feature; but
> default to on), and patches 2 and 7 as one patch (Paginate history output)?

I looked at and understood 1 and 2+7, although I cannot claim I
looked at 2+7 deeply enough; cursory look told me they should be
Ok.  So is 3, but I suspect gitweb without --full-history might
surprise some users.

I do not know about 4, 5 and 6.  I didn't look at them at all
the first time you sent them out, since I got an impression that
you did not understand how git-rev-list was supposed to work
when you did them.

Now Linus explained it to you, I suspect they would probably
need to be rethought?
