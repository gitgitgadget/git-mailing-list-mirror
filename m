From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2012 application process
Date: Fri, 02 Mar 2012 13:48:31 -0800
Message-ID: <7vipimbro0.fsf@alter.siamese.dyndns.org>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 22:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3aLA-0007J3-CR
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 22:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757830Ab2CBVsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 16:48:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab2CBVse (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 16:48:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68BA76C6F;
	Fri,  2 Mar 2012 16:48:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p0X7pBH+vXnn5faSqqxyPe4iPnQ=; b=CwQSYB
	xEq7WyuftcWtcpcxRpJe+3V4q8DDKG02rlhURH6KZhxVwM6zxXejr6dKEI4U+lkI
	jTXrNz9l170oy1Eza3VIRIJL1xhpCxc3maBYTyNSHCBwm2DRqUqkmBJ4638dK3Lb
	56oYFHhwSbHbIISfK0ZvaOKain8aC9BqKkWT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SN4z+dMsgqgYtDPhfHYR+bpvcjAeY8YH
	yRfLgMq3HDzbyhd8VV50B9KI/48q6qm/RCMMDa4G0aEdtZQiL+bQhguAq0chOLsV
	LScHoiEwqrTQ3DfO4n1jXHqQA0HPDeYy1zk/VBSnot75yAJ9fGugHhWP/21T4hsp
	iLndgZDMCVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58FE46C6E;
	Fri,  2 Mar 2012 16:48:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABBA96C6D; Fri,  2 Mar 2012
 16:48:32 -0500 (EST)
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 Mar 2012 04:11:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74AA7A54-64B1-11E1-9FDF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192068>

Jeff King <peff@peff.net> writes:

> ... a wiki page for
> project ideas:
>
>   https://github.com/peff/git/wiki/SoC-2012-Application
>   https://github.com/peff/git/wiki/SoC-2012-Ideas
>
> The application is due March 9th (next Friday).

Thanks for getting the ball rolling.

One thing unrelated to the proposal I have been wondering about was how
well our release cycles mesh with the GSoC timeline.

Comparing the GSoC timeline and the Git Calendar:

    http://www.google-melange.com/gsoc/events/google/gsoc2012
    http://tinyurl.com/gitcal

Some basics to consider:

 - Typically one cycle of our development lasts for 8 to 10 weeks, and at
   around its 5th or 6th week, the major changes for the next release are
   expected to be more or less ready.

 - As we have about 20 weeks between the beginning of post-1.7.10 cycle
   and pencils-down time for GSoC, and also people tend to slow down or
   stop late June to early July for summer holidays, I am planning to make
   these cycles last a bit longer for 10 weeks.

The way I envision the experience for this year's students would go are
like this:

 * GSoC student proposal acceptance (April 23rd)
   The students are expected to start "bonding" with the community.

   This is at the beginning of week #4 of the post-1.7.10 cycle.  Students
   have a chance to observe and learn how a change is proposed, its design
   debated and patchset polished from beginning to end, even if they wait
   before joining the mailing list until this date.

 * GSoC student first day of business (May 21st)
   The students are expected to start coding.

   This is at the beginning of week #8 of the post-1.7.10 cycle,
   1.7.11-rc0 should have been tagged several days before, and 1.7.11-rc1
   is scheduled to be tagged in a few days.  Once we hit this point, we
   usually do not queue anything large even to 'pu' until the final
   release to encourage people to concentrate on the upcoming release,
   which may be OK for the first couple of weeks for GSoC students (they
   won't have anything to show that early).

   The final batches of large changes that were previously discussed and
   polished would still be graduating to 'master', whose earlier parts of
   lifecycle the students may not have seen, but smaller and more obvious
   changes proposed after they joined the community would go their full
   lifecycle from 'pu' thru 'next' down to 'master', and the students can
   learn from these topics how the development process works.

 * Beginning of post 1.7.11 cycle (June 11th)
   The students would be working furiously for midterm.

   At this point, the students have worked for 3 weeks with their mentors.
   Good students may at least have design sketches ready to be presented
   at this point, if not a working code.

 * GSoC midterm evaluation (July 9th)

   This is at the beginning of week #5 of the post-1.7.11 cycle.  The
   student's changes should at be ready for 'pu' by this time, or there is
   no chance of them being in the upcoming release.

   The students would have had 7 weeks to work up to this point, and they
   have 4 more weeks to polish their work to 'next' and to 'master' until
   1.7.12-rc1, and another 2 weeks to further fix late bugs in 'master'.

 * GSoC pencils down (Aug 20th)

   This is at the end of week #10 of the post-1.7.11 cycle, and 1.7.12
   should be already out the day before.


Our release cycle was never scheduled around GSoC timeline for the past
GSoC students, so I do not know what effect, if any, our pre-release
freeze period had on our past students' work (I would appreciate hearing
from past student about their experiences).

In any case, it seems that they coincide fairly well for this year's
students.

By the way, I also considered splitting the 20-week period into two and a
half cycles, coinciding -rc1 of the third cycle after the upcoming 1.7.10
release and GSoC pencils down date. It would make the student success
criteria "Is it in 'master'?" instead of "Is it in a release?", but the
overall schedule did not work as well as the above.
