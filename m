From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Setting up a bug tracking system where users can file bug
 reports and feature requests for Git
Date: Sun, 15 Feb 2009 19:52:05 -0800
Message-ID: <7vab8nf38a.fsf@gitster.siamese.dyndns.org>
References: <loom.20090216T025046-863@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Spiro <jasonspiro4@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuY7-0002pa-Fw
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbZBPDwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755965AbZBPDwM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:52:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbZBPDwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:52:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DBDEC2B392;
	Sun, 15 Feb 2009 22:52:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0406C2B390; Sun,
 15 Feb 2009 22:52:06 -0500 (EST)
In-Reply-To: <loom.20090216T025046-863@post.gmane.org> (Jason Spiro's message
 of "Mon, 16 Feb 2009 02:55:33 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2FC5E422-FBDD-11DD-96F1-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110129>

Jason Spiro <jasonspiro4@gmail.com> writes:

> Is there a bug tracking system where I can file bug reports and feature
> requests for Git?  If not, could you please set up such a system?  I am
> more likely to send bug reports and feature requests to a bug tracking
> system than a mailing list, since I know that they can't be lost in the
> mists of time and forgotten forever.  :)

This come up on the list from time to time.

I am not fundamentally opposed to using an automated way to help tracking
issues, but a tracking system is not a panacea.

A tracking system is just a tool.  You need to have a competent and stable
project secretary whose job is to look after the issues database.  The
tasks involved are to expire the stale ones, to reject invalid entries, to
prod the bug reporter for additional information, to find a volunteer to
take up on an individual issue, to prod the bug reporter for confirmation
on the fix once it is ready, and to close completed issues.

And do not tell me that debbugs can route messages.  People do not respond
to automated messages the same way as they would to messages from a warm
and respected body.

We handle the "to expire the stale ones and to reject the invalid ones"
part by losing the ones that even the original complainer does not feel
motivated enough to be persistent in the mists of time (yes, it is a
*feature* of mailing list based community, not a deficiency).

A mailing list based workflow lacks support for other tasks a competent
project secratary performs: finding a taker for a task and prodding the
party whose court the ball currently is in.  That is currently done purely
on voluntary basis.  Often the person who introduced the bug originally
feels ashamed enough to look into the issue.  A diligent bug reporter asks
if the issue previously reported has a resolution when a certain period of
silence passes, and such a "prodding" raises the awareness of the issue in
the group of volunteer developers and gives the issue a higher priority.

I would agree 100% with you if you said relying on such a purely volunteer
based system would not be ideal.  It is not.  But given that the ratio
between gimme-whiners and can-do-contributors is not so great, that's the
best we can currently do.

It would be great to have a competent and stable project secretary to fill
the gap.  From time to time, we do see some people playing that role,
summarizing the issues raised, discussed and then left unresolved, but
that too is purely on voluntary basis.  I do that as a part of the task
for the maintainer, but obviously I have to do other things as well.

If you are volunteering to be the lead for the project secretaries group,
that would be great.  

Such a person may choose a tracking system he or she is the most familiar
with, and if that helps the progress of the project, that would be even
better.
