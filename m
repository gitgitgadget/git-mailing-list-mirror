From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add case-challenged file system tests
Date: Fri, 08 Feb 2008 10:02:11 -0800
Message-ID: <7vlk5vjpi4.fsf@gitster.siamese.dyndns.org>
References: <12024545763364-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNXZB-0003wq-7a
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 19:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbYBHSCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 13:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbYBHSCX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 13:02:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934382AbYBHSCU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 13:02:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B575F2A;
	Fri,  8 Feb 2008 13:02:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A1F25F28;
	Fri,  8 Feb 2008 13:02:14 -0500 (EST)
In-Reply-To: <12024545763364-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Fri, 8 Feb 2008 08:09:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73118>

Steffen Prohaska <prohaska@zib.de> writes:

> Is anyone actively orking on these issues?
> What is the current status?

Not that I know of.

> The patch below adds two simple tests that currently fail on Mac
> and Windows.  I also collected Mitch's test on utf-8 and will
> send it as a reply to this mail.  These two patches contain test
> cases that should pass, but do currently fail.

Could you fold them into one?  They are about the same topic.

Also, mark them with test_expect_failure if these are meant to
be applied.
