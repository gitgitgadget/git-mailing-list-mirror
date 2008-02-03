From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Sat, 02 Feb 2008 22:24:17 -0800
Message-ID: <7vwspmzhf2.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 07:25:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLYHk-00087F-Pu
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 07:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759699AbYBCGY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 01:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759562AbYBCGY3
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 01:24:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178AbYBCGY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 01:24:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 82EDC6105;
	Sun,  3 Feb 2008 01:24:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B4C56104;
	Sun,  3 Feb 2008 01:24:23 -0500 (EST)
In-Reply-To: <20080203043310.GA5984@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Feb 2008 23:33:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72330>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 02, 2008 at 10:00:54PM -0500, Jeff King wrote:
>
>> That being said, the commit in your 'master' branch _is_ part of
>> 1dd567d5, and should be culled. So I'm not clear on why it shows up only
>> when you ask to see both branches, and that may be a bug.
>
> OK, there is definitely a bug here, but I'm having some trouble figuring
> out the correct fix. It's in the revision walker, so I have cc'd those
> who are more clueful than I.

I am officially in semi-vacation-post-release mode, but I
noticed this is reproducible even with a prehistoric git
(v1.0.0).
