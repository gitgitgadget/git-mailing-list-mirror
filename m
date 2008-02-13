From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git add -i fails in multiple ways prior to first commit.
Date: Wed, 13 Feb 2008 03:30:44 -0800
Message-ID: <7v63wtqejf.fsf@gitster.siamese.dyndns.org>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com>
 <20080213101649.GA18444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 12:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFq3-0001g6-E9
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 12:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbYBMLbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 06:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbYBMLbG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 06:31:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbYBMLbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 06:31:06 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC9C2F89;
	Wed, 13 Feb 2008 06:31:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 A78972F29; Wed, 13 Feb 2008 06:30:53 -0500 (EST)
In-Reply-To: <20080213101649.GA18444@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 13 Feb 2008 05:16:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73776>

Jeff King <peff@peff.net> writes:

> However, I wonder if this is the best approach. It would be nice if
> there were a shorthand for "the empty tree" for diffing, so you could
> just diff against that rather than HEAD, and have the regular plumbing
> generate.

I guess you can set your worktree to an empty directory and run
diff-files backwards, like perhaps:

	mkdir /var/tmp/empty
        (cd .git && GIT_WORK_TREE=/var/tmp/empty git diff -R)

Have I tried it?  No --- I am not sick enough to be motivated.
