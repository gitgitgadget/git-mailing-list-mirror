From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add testcase for 'git cvsexportcommit -w $cvsdir ...'
 with relative $GIT_DIR
Date: Tue, 12 Feb 2008 23:58:23 -0800
Message-ID: <7vabm5s2xs.fsf@gitster.siamese.dyndns.org>
References: <200802110228.05233.johan@herland.net>
 <200802120043.41610.johan@herland.net>
 <200802122141.35594.robin.rosenberg.lists@dewire.com>
 <200802130411.22093.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 08:59:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCWR-0007wp-QQ
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 08:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYBMH6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 02:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYBMH6k
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 02:58:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYBMH6j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 02:58:39 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EF4822B13;
	Wed, 13 Feb 2008 02:58:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 F279E2B12; Wed, 13 Feb 2008 02:58:25 -0500 (EST)
In-Reply-To: <200802130411.22093.johan@herland.net> (Johan Herland's message
 of "Wed, 13 Feb 2008 04:11:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73749>

Johan Herland <johan@herland.net> writes:

> The testcase verifies that 'git cvsexportcommit' functions correctly when
> the '-w' option is used, and GIT_DIR is set to a relative path (e.g. '.').
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>
> On Tuesday 12 February 2008, Robin Rosenberg wrote:
>> Looks ok. Something for the test suite?
>
> Like this?

Yeah, looks good.

Except that I'll reorder the patches so that

 (1) this test comes first, but with test_expect_failure instead;

 (2) then your earlier fix patch, but with a change that changes
     the test_expect_failure to test_expect_success.

Thanks.

Perhaps it would be a good idea to require fix-up patches to
always come with a test case to prevent future regression.
