From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] filter-branch: provide the convenience functions also for commit filters
Date: Fri, 31 Aug 2007 13:59:49 -0700
Message-ID: <7vzm07xvwa.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0708312005070.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDbc-0005N6-MJ
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204AbXHaU7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933205AbXHaU7z
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 16:59:55 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933204AbXHaU7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 16:59:54 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 39913128E6A;
	Fri, 31 Aug 2007 17:00:13 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708312005070.28586@racer.site> (Johannes
	Schindelin's message of "Fri, 31 Aug 2007 20:05:36 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57206>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Obviously, I think that these two changes are simple enough to be
> 	included even this late in the game for 1.5.3.  But I understand
> 	completely when people shout at me: "What exactly does deep
> 	feature freeze mean to you *knocks on Dscho's head*?"

My response to those people who might shout is that this is
merely a step to complete a _new_ program that was not in _any_
released version to make it feature complete.  You do not have
to even pretend that filter-branch did not exist before -- it
actually didn't.  The new part might be buggier than other
parts, but that's the same way as any other software development
process.  If the new 'map' does not work as advertised there is
always 1.5.3.1.

Thanks.
