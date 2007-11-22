From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: move help to end of todo file
Date: Thu, 22 Nov 2007 03:46:57 -0800
Message-ID: <7vbq9m5wpa.fsf@gitster.siamese.dyndns.org>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711221113360.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAWj-0007Ps-4m
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXKVLrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXKVLrG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:47:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40273 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbXKVLrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:47:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D41CF2EF;
	Thu, 22 Nov 2007 06:47:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 70716979B9;
	Thu, 22 Nov 2007 06:47:21 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711221113360.27959@racer.site> (Johannes
	Schindelin's message of "Thu, 22 Nov 2007 11:15:51 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65808>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	How about this?  I am hesitant to remove _everything_, since quite 
> 	a few people seem to be allergic to man pages, so they fire up 
> 	rebase -i without any clue.

Oh, I wouldn't dream of suggesting complete removal of the help
text, but leaving the single line at the beginning is not an
improvement.  What's on that single line is not particularly
useful but that is a separate issue.

Moving everything down will hurt ONLY when (1) the rebase is
about a large series (more than 24 commits in vt100) AND (2) the
user hasn't run "rebase -i" before and does not know that there
is a reminder insn at the end.  Now is it likely for a newbie to
run "rebase -i" with 20-30 commits and that invocation is his
first "rebase -i" invocation in his life?

The new help line at the end is helpful, by the way.  I always
had "Huh?"  moment, and did ^Z followed by kill %% instead.
