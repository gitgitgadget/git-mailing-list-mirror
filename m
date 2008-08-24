From: Junio C Hamano <gitster@pobox.com>
Subject: Maintaining "needswork" section of "What's (not) cooking"
Date: Sat, 23 Aug 2008 21:00:47 -0700
Message-ID: <7vej4frrio.fsf@gitster.siamese.dyndns.org>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 06:04:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX6pa-0002KK-W6
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 06:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbYHXEAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 00:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbYHXEAx
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 00:00:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYHXEAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 00:00:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A2E8F65F4B;
	Sun, 24 Aug 2008 00:00:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 08EF665F4A; Sun, 24 Aug 2008 00:00:49 -0400 (EDT)
In-Reply-To: <7v1w0ft750.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 23 Aug 2008 20:38:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3E127710-7191-11DD-B97A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93514>

Junio C Hamano <gitster@pobox.com> writes:

> Here is a list of issues/topics we saw on the mailing list but haven't
> resulted in anything queuable in 'pu' yet.  They need further work by
> interested parties:
> ...
> [Stalled -- Needs Action to Proceed (or to be dropped)]
> ...

I am still experimenting with my own workflow with these parts.

With more people on the list sending patches recently, I still have enough
mental bandwidth to reject the initial rounds with comments/suggestions
for improvements, but I do not think it is realistic to expect me to keep
track of all of their progress on re-submission of improvements anymore (I
used to prod people privately asking how much they are making progress
after not hearing from people who received review comments).

It is a large loss for all of us when people do not come back with updated
patches after receiving review comments.  Lost are their good idea based
on the real world needs.  Time other people have volunteered to review
their initial submissions are also wasted when that happens.

I however do not intend to lower the patch acceptance standards.  It is
not a workable approach to accept many new features implemented in a
substandard way or designed incoherently, expecting they will eventually
be cleaned up in-tree.  Nobody will clean anything up after it is merged,
and when we give something to the end users, it becomes harder to change
its behaviour.

If a few people can volunteer to maintain a list that looks like the above
(not-quite) quoted ones, we may be able to give people more incentive to
keep polishing their patches in response to the reviews they received.
Other people can also offer help in topics they are interested in, and we
may see more topics through their completion as the result.

Thoughts?
.
