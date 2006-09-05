From: Junio C Hamano <junkio@cox.net>
Subject: Re: Test names
Date: Tue, 05 Sep 2006 01:28:13 -0700
Message-ID: <7vd5aaiuoy.fsf@assigned-by-dhcp.cox.net>
References: <edifa7$h29$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 10:28:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKWHq-0007W6-Tc
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 10:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWIEI1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 04:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWIEI1q
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 04:27:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42178 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964992AbWIEI1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 04:27:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905082745.EMT12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 04:27:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JYTl1V00j1kojtg0000000
	Tue, 05 Sep 2006 04:27:46 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edifa7$h29$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	05 Sep 2006 02:10:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26467>

Jakub Narebski <jnareb@gmail.com> writes:

> In t/README it is written:
>...
> Is there any naming rule, or just increment it by one when adding new test
> in the same family?
>
>> Third digit (optionally) tells the particular switch or group of switches
>>  we are testing.
>
> What tells the fourth digit?

Nothing other than just to make them aline up and ordered
nicely.

The rule was outlined long time ago but not strictly followed
(primarily because was done when git was mostly core, and it did
not anticipate the proliferation of Porcelain-ish wrappers, so
it was rather hard to follow).  I'd suggest you to declare that
t92xx- series are for gitweb, and organize the tests in that
namespace nicely.  Also you might want to see what Eric did for
the subversion interface tests (60d02cc declares that t91xx-
series are SVN tests and gives an easy way to skip heavier tests
on git-svn).
