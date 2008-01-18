From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Fri, 18 Jan 2008 02:57:16 -0800
Message-ID: <7v8x2nflkj.fsf@gitster.siamese.dyndns.org>
References: <20080118032222.GX24004@spearce.org>
	<20080118035700.GA3458@spearce.org>
	<20080118092652.GA22052@hashpling.org>
	<7v8x2nh3uw.fsf@gitster.siamese.dyndns.org>
	<20080118094553.GB22052@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:58:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFovB-0000P2-C3
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbYARK53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 05:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755157AbYARK53
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:57:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbYARK52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:57:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B3306AC7;
	Fri, 18 Jan 2008 05:57:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C3DA6AC6;
	Fri, 18 Jan 2008 05:57:22 -0500 (EST)
In-Reply-To: <20080118094553.GB22052@hashpling.org> (Charles Bailey's message
	of "Fri, 18 Jan 2008 09:45:53 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70997>

Charles Bailey <charles@hashpling.org> writes:

> Sorry, I thought that Acked-by was an acceptable tag for people not
> involved in the development path of a patch.  I don't want to add a
> "Tested-by" as I am not a fast-import user and I am *only* reporting
> the success of the test suite, not any real-world testing.

It still counts as "Tested-by:".  Earlier you saw breakage and
now you see it fixed in your environment, to which neither I nor
Shawn have access to.  That's a good verification that the patch
fixed the issue for you and your feedback was very much
appreciated (your timely initial breakage report even more so).

Acked-by: is usually given by people who are the most familiar
with the code being affected (or at least by the ones more
familiar than the patch's author), in order to let me and the
world know that he thinks the contents of the patch makes sense.
IOW, the patch was checked by somebody who knows the existing
code well enough to catch any subtleties in the existing code
that might have been broken if the patch's author was not
careful.  It just felt slightly funny that anybody is giving an
Acked-by: to a patch Shawn made to fast-import.c, which is his
brainchild ;-).

Signed-off-by is about the kosherness from software license
point of view, while Acked-by and Tested-by are about the
correctness.
