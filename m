From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: fix partial-commit support
Date: Sun, 18 Nov 2007 02:26:59 -0800
Message-ID: <7vy7cvx30s.fsf@gitster.siamese.dyndns.org>
References: <1195381287-26823-1-git-send-email-gitster@pobox.com>
	<1195381287-26823-2-git-send-email-gitster@pobox.com>
	<1195381287-26823-3-git-send-email-gitster@pobox.com>
	<1195381287-26823-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthN4-0000dl-Nj
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbXKRK1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbXKRK1F
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:27:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34653 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbXKRK1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:27:02 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5F3C02EF;
	Sun, 18 Nov 2007 05:27:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B4D296173;
	Sun, 18 Nov 2007 05:27:22 -0500 (EST)
In-Reply-To: <1195381287-26823-4-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Sun, 18 Nov 2007 02:21:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65362>

The above four are to be applied on top of kh/commit series,
(without the WIP I sent out last night) on top of Dscho's
"Replace "runstatus" with "status" in the tests" patch.

With these, all tests in t/ finally passes for me ;-)

But I am not a heavy user of partial commits nor commits from
subdirectories, so there may still be breakages.
