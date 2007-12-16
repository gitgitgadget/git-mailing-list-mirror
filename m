From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 13:00:01 -0800
Message-ID: <7vk5nejqy6.fsf@gitster.siamese.dyndns.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
	<25FDB05F-3E85-4E08-90BE-1BE468C07805@wincent.com>
	<20071216162637.GA3934@fieldses.org>
	<200712161916.44715.jnareb@gmail.com>
	<20071216195956.GA14676@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 22:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J40bN-0004tW-La
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 22:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbXLPVAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 16:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbXLPVAU
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 16:00:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbXLPVAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 16:00:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AFC584450;
	Sun, 16 Dec 2007 16:00:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DA2B444A;
	Sun, 16 Dec 2007 16:00:08 -0500 (EST)
In-Reply-To: <20071216195956.GA14676@fieldses.org> (J. Bruce Fields's message
	of "Sun, 16 Dec 2007 14:59:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68487>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Which is: I do get the occasional kernel patch with whitespace problems
> uncaught by git's existing checks.  It's annoying to have to fix them up
> manually (but wastes Andrew Morton's time if I don't).  This shouldn't
> be necessary, because the kernel has a simple policy for initial
> whitespace that is completely automatable.
>
> If we've got to define a fourth whitespace policy for this, well, OK,
> I'll live--tell me what I need to do.  I haven't seen a convincing
> argument for that yet, though.

There is one "fix" you earlier implemented but there is no way to check
in the current infrastructure of checking one line at a time.  A run of
blank lines at the end of file.

I personallyy find it much more interesting and useful than the "align
with space" discussion.
