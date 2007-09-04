From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add post-merge hook.
Date: Tue, 04 Sep 2007 10:25:46 -0700
Message-ID: <7vmyw2ny05.fsf@gitster.siamese.dyndns.org>
References: <11885136172952-git-send-email-jjengla@sandia.gov>
	<7v7inc7hao.fsf@gitster.siamese.dyndns.org>
	<1188923110.6192.15.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:25:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISc9w-0008Rq-7V
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbXIDRZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbXIDRZr
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:25:47 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62324 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbXIDRZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:25:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070904172545.VEYE11280.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 4 Sep 2007 13:25:45 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id kHRm1X00K1gtr5g0000000; Tue, 04 Sep 2007 13:25:46 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57622>

"Josh England" <jjengla@sandia.gov> writes:

>> Two questions.
>> 
>>  * Do you want to run the post-merge hook even for a squash
>>    merge?
>
> Yes.  I'd like to run it at any time that the working tree might be
> updated.

If that is the case, perhaps your hook may want to get a
parameter to tell it what kind of "git-merge" invocation it was?
Squash merge does not even advance the HEAD and is of a very
different nature from a normal merge.

>>  - We would want a new test in the test suite for this, to make
>>    sure that later changes by others would not break this new
>>    feature you would depend upon.
>
> Can do.  You want me to resubmit the original patch along with tests or
> submit the tests as a new patch?

I'd like a full resend whenever I reject a patch with a
comment.  That way the patch will be easier to review with
context by other people.

Thanks.
