From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: Add simplified merge sort implementation from glibc
Date: Tue, 05 Feb 2008 12:02:09 -0800
Message-ID: <7v3as7b29q.fsf@gitster.siamese.dyndns.org>
References: <20080204024644.GM26392@lavos.net>
	<1202209509-13760-1-git-send-email-bdowning@lavos.net>
	<20080205141139.GN26392@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Edgar Toernig <froese@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Tue Feb 05 21:03:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMU0T-0006CV-2m
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759074AbYBEUCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759762AbYBEUCW
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:02:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759731AbYBEUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:02:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A712B6403;
	Tue,  5 Feb 2008 15:02:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0385D63FC;
	Tue,  5 Feb 2008 15:02:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72684>

bdowning@lavos.net (Brian Downing) writes:

> I didn't notice that the previous patch made it into pu.

Well, 'pu' is not something to "make into".  Being there is to
serve merely as a reminder that such a topic existed and as an
encouragement for a resend of an improved version.

If you have more polished one, please send it in.  I'll discard
the one in 'pu' and replace.
