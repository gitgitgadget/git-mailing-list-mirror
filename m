From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Tue, 05 Feb 2008 15:44:03 -0800
Message-ID: <7v1w7r7yv0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802041336030.13593@iabervon.org>
	<alpine.LSU.1.00.0802050139470.8543@racer.site>
	<alpine.LNX.1.00.0802042152560.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:35:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYFj-00019u-PS
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760894AbYBFAea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760959AbYBFAe3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:34:29 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:59231 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760415AbYBFAe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:34:27 -0500
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 93E8950A11B
	for <git@vger.kernel.org>; Tue,  5 Feb 2008 18:47:23 -0500 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A9BFF193B3B;
	Tue,  5 Feb 2008 18:45:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CECA9193C0F;
	Tue,  5 Feb 2008 18:44:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72728>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Well, it's something I tripped over when builtin-checkout wasn't passing 
> the tests and I couldn't figure out what it was doing wrong from the 
> output. Like [3/9], it's relevant to evaluating whether the series works, 
> even if it's not important for whether it actually does work.

Yeah, using "diff -u" instead of just "diff" is an improvement
for debuggability which matters a lot in the test scripts.
