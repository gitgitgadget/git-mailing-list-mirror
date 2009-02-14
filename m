From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 13:10:03 -0800
Message-ID: <7vtz6wrahg.fsf@gitster.siamese.dyndns.org>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
 <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:11:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRnZ-0002Py-E9
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbZBNVKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZBNVKN
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:10:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZBNVKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:10:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78C1099796;
	Sat, 14 Feb 2009 16:10:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 101B399795; Sat,
 14 Feb 2009 16:10:04 -0500 (EST)
In-Reply-To: <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
 (Felipe Contreras's message of "Sat, 14 Feb 2009 22:09:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC78B918-FADB-11DD-8669-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109928>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Unfortunately, not many patch authors write such a summary.  Sometimes we
>> see summaries on things that were discussed but nobody has followed
>> through posted by third parties (including myself), but we do not seem to
>> have enough helpers to do that either.  This does not take much technical
>> skills but is a good "trust point" earner.
>
> For me it's easier, and more fun to write a separate patch that fixes
> the issues than writing a summary,...

That certainly is something we should take into consideration.

I however think an unwritten assumption around here so far has been that
the patch author who gets review comments is expected to keep track of the
issues raised, both about the patch itself and about the similar breakages
in the existing code pointed out during the review process, if only
because the patch author is the focal point of the discussion.

We probably need to break that.

Because it is very likely that the reviewer does not even realize that
such similar breakages in the existing code when a review is made, we
cannot ask reviewers to always start a separate discussion.  Some reviews
do say "Admittedly, we already have the same pattern in here and there,
but this in your patch is wrong," but the way how we collectively realize
an existing breakage is often by hearing the patch author respond with
"but there already are this and that breakages in the existing code."

We do not want such knowledge of existing breakages go to waste in either
case.  Perhaps it would be a good start to make it the responsibility of
the first person who mentions an existing breakage (either the reviewer's
"Admittedly", or the patch author's "but there already are") to begin a
separate thread, so that mail archive would remember it.  It shouldn't
take more than 3 minutes.
