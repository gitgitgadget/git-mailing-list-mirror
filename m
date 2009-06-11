From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RF sanity check] send-email threading fixes
Date: Thu, 11 Jun 2009 13:38:51 -0700
Message-ID: <7vprdah5es.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
	<7v63f4v9sl.fsf@alter.siamese.dyndns.org>
	<200906111849.40232.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Thu Jun 11 23:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MErVe-0004GL-Hv
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 23:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760313AbZFKVIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 17:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760198AbZFKVIR
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 17:08:17 -0400
Received: from fed1rmpop110.cox.net ([68.230.241.14]:59852 "EHLO
	fed1rmpop110.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760196AbZFKVIP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 17:08:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611203851.OQEH2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 11 Jun 2009 16:38:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2ker1c00G4aMwMQ04kervo; Thu, 11 Jun 2009 16:38:51 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=rGcsWzy2ZY0A:10 a=aX3-ONhlG_4A:10
 a=fxchsGdqp5f7PtMXZ18A:9 a=9_qCaboM3YTe2nlhA7GrpxKQtJ8A:4 a=5KVauyKsRKMA:10
X-CM-Score: 0.00
In-Reply-To: <200906111849.40232.markus.heidelberg@web.de> (Markus Heidelberg's message of "Thu\, 11 Jun 2009 18\:49\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121361>

Markus Heidelberg <markus.heidelberg@web.de> writes:

>> [PATCH 4/6] send-email: fix threaded mails without chain-reply-to
>> [PATCH 5/6] add a test for git-send-email for threaded mails without chain-reply-to
>> [PATCH 6/6] send-email: fix a typo in a comment
>> 
>> Patch 4/6 applies on top of 15da108 to fix a breakage introduced by that
>> commit.  Together with the result of applying the first three patches to
>> maint, they fix --no-thread and --thread (without --chain-reply-to) cases.
>> The result can be verified by applying Patch 5/6 on top of them.
>
> Out of curiosity: why are 4/6 and 5/6 applied on different branches
> without the usual commits first "test with test_expect_fail" then "fix +
> test changed to test_expect_success"?

Maybe I misunderstood your problem description, but my impression from it
was that 4/6 is a fix to a latent bug in 15da108 that later affected what
was done by new code that appeard somewhere between 15da108 and 'master',
and the test 5/6 was about that breakage.  IOW, root cause was older than
the symptom.
