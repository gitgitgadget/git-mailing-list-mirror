From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] fork/exec removal series
Date: Sun, 30 Sep 2007 13:20:24 -0700
Message-ID: <7vbqbjhpmf.fsf@gitster.siamese.dyndns.org>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 30 22:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic5HM-0005KU-El
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXI3UUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXI3UUb
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:20:31 -0400
Received: from rune.pobox.com ([208.210.124.79]:60535 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbXI3UUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:20:31 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 0F13E13F075;
	Sun, 30 Sep 2007 16:20:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A14613F060;
	Sun, 30 Sep 2007 16:20:48 -0400 (EDT)
In-Reply-To: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
	(Johannes Sixt's message of "Sun, 30 Sep 2007 22:09:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59559>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Here is a series of patches that removes a number fork/exec pairs.
> They are replaced by delegating to start_command/finish_command/run_command.
> You can regard this as the beginning of the MinGW port integration.

Yay!

> Patch 2 depends on Patch 1; otherwise, there are no dependencies.
> The series goes on top of next (it touches str_buf stuff in connect.c).

Thanks for an advance warning.

I'll keep the series in my mailbox (promise) and queue it for
'pu' for now (but only if I have time), as I intend to merge the
strbuf stuff to 'master' soon.
