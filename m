From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 09:06:28 -0700
Message-ID: <867ilb6uwr.fsf@blue.stonehenge.com>
References: <86oden6z97.fsf@blue.stonehenge.com>
	<20071025155142.GB19655@coredump.intra.peff.net>
	<86fxzz6vfh.fsf@blue.stonehenge.com>
	<20071025155712.GA21446@coredump.intra.peff.net>
	<86bqan6v9f.fsf@blue.stonehenge.com>
	<20071025160159.GA21505@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il5EQ-0000aX-FR
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 18:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbXJYQGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 12:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbXJYQGa
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 12:06:30 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:18995 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbXJYQGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 12:06:30 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B6B4B1DE552; Thu, 25 Oct 2007 09:06:28 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.13.16; tzolkin = 5 Cib; haab = 4 Zac
In-Reply-To: <20071025160159.GA21505@coredump.intra.peff.net> (Jeff King's message of "Thu, 25 Oct 2007 12:01:59 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62332>

>>>>> "Jeff" == Jeff King <peff@peff.net> writes:

Jeff> On Thu, Oct 25, 2007 at 08:58:52AM -0700, Randal L. Schwartz wrote:
Jeff> So that should take the remote's refs/heads/* and put them in your
Jeff> refs/remotes/origin/*. I don't see how that would have anything to do
Jeff> with your 'refs/heads/upstream' branch.
>> 
>> Agreed, but that's the place where fetch might look at refs/heads/upstream,
>> and the behavior is definitely different between yesterday and today.

Jeff> Fair enough. How about my other questions. Can you 'git-show upstream'?
Jeff> Can you 'git-show origin/master'?

yes, and they show the same thing.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
