From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Sun, 18 Nov 2007 10:52:37 -0800
Message-ID: <7vmytbv11m.fsf@gitster.siamese.dyndns.org>
References: <1195407366-1610-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 19:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItpGU-0004je-IP
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbXKRSwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXKRSwq
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:52:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40582 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbXKRSwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:52:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B4D6D2F0;
	Sun, 18 Nov 2007 13:53:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D0E597219;
	Sun, 18 Nov 2007 13:53:03 -0500 (EST)
In-Reply-To: <1195407366-1610-1-git-send-email-pkufranky@gmail.com> (Ping
	Yin's message of "Mon, 19 Nov 2007 01:36:06 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65385>

Ping Yin <pkufranky@gmail.com> writes:

> When 'FILE *fp' is assigned to child_process.out and then start_command or
> run_command is run, the standard output of the child process is expected to
> be outputed to fp. However, sometimes fp is not expected to be closed since
> further IO may be still performmed on fp.

Could you clarify "However, sometimes" with a concrete codepath
that has this problem in the proposed commit log message, and
Sign-off your patch please?
