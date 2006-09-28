From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 21:07:50 -0700
Message-ID: <7vbqp063c9.fsf@assigned-by-dhcp.cox.net>
References: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
	<7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609272252041.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:07:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSnBj-0000Ye-S3
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031351AbWI1EHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031352AbWI1EHx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:07:53 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25541 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1031351AbWI1EHw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 00:07:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928040751.PQAL6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 00:07:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Tg7t1V00K1kojtg0000000
	Thu, 28 Sep 2006 00:07:53 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609272252041.9349@xanadu.home> (Nicolas Pitre's
	message of "Wed, 27 Sep 2006 23:07:35 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27983>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 27 Sep 2006, Junio C Hamano wrote:
>
>> ....  He tends to batch, so he would have many such pulls and
>> patch applications in his private repository, perhaps over a few
>> hour, but the result will be pushed out to kernel.org with one
>> push operation.  To show the "truthful" time, your gitweb would
>> give the timestamp of that push operation for hundreds of
>> commits pushed out during that operation.
>> 
>> I do not personally think that would be useful at all.  And I
>> happen to know how expensive to teach gitweb to produce such an
>> output, so I would not seriously suggest anybody to try it.
>
> I beg to differ.  Such information might be really useful.  I agree 
> though that this is an expensive operation and gitweb might not be the 
> best place for it at all.
>
> For example... some times I look at git-log output and finds about a 
> certain bug fix that was apparently committed a month ago.  And 
> incidentally I recall having been bitten by that bug not really long 
> ago, say last week.  Although the bug fix was committed _somewhere_ last 
> month, what I would really want to know is just when _i_ received that 
> bug fix in my own repository to determine if it was before or after last 
> week.  So if it was before last week then I could conclude that the bug 
> fix didn't actually fix my bug.  Knowing that it has been committed last 
> month is absolutely useless to me in this case.

I beg to agree ;-).  Being able to inspect a particular commit
to find out when it hit the branch is probably useful.  I do not
have much objection to have it on the commit page.

It is totally a separate matter to use that timestamp to order
the commits listed on the shortlog page, which Matthew seemed to
be after.  I would say that _is_ wasteful and loses more
interesting information by listing all several dozen commits
Linus pushed out the last time with the same timestamps.
