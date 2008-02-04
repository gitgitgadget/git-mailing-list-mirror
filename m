From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sun, 03 Feb 2008 16:07:48 -0800
Message-ID: <7vwsplporv.fsf@gitster.siamese.dyndns.org>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
	<1201975757-13771-1-git-send-email-hjemli@gmail.com>
	<alpine.LSU.1.00.0802021815510.7372@racer.site>
	<8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:08:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLot2-0001rN-VJ
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYBDAIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbYBDAIB
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:08:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbYBDAIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:08:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F2267E1B;
	Sun,  3 Feb 2008 19:07:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DE1A27E06;
	Sun,  3 Feb 2008 19:07:54 -0500 (EST)
In-Reply-To: <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
	(Lars Hjemli's message of "Sat, 2 Feb 2008 19:47:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72428>

"Lars Hjemli" <hjemli@gmail.com> writes:

> Maybe this as a compromise?
>
> 	static char buf[PATH_MAX + 9];  /* "GITDIR: " + "\n"  */
> ...
> 	if (!len || buf[len - 1] != '\n')
> 		return NULL;
> 	buf[len - 1] = '\0';
> 	if (prefixcmp(buf, "GITDIR: "))
> 		return NULL;

Perhaps that is easier to read.

For now I haven't picked up any of the "how about this way"
revisions.
