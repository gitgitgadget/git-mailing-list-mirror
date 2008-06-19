From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-push: add a --delete flag to allow branch deletion
Date: Fri, 20 Jun 2008 00:30:40 +0200
Message-ID: <485ADE10.7070404@op5.se>
References: <1213884787-24692-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:31:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9SfM-0002MJ-O8
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYFSWao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYFSWao
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:30:44 -0400
Received: from mail.op5.se ([193.201.96.20]:39855 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970AbYFSWan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:30:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0F6811B8004E;
	Fri, 20 Jun 2008 00:28:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D4em28OErkoj; Fri, 20 Jun 2008 00:28:01 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 213191B80046;
	Fri, 20 Jun 2008 00:28:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <1213884787-24692-1-git-send-email-pdebie@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85550>

Pieter de Bie wrote:
> While this is already possible with the :<dst> refspec syntax,
> a flag specifically for this action is more userfriendly.
> 

I like it. I always have to tell my co-workers which side of
the colon the branch-name to delete should be on. Since they
want the remote to lose the branch, it seems logical to some
of them to make that side empty. This would make one (very
small) headache of mine go away.

Question though; does it delete the currently checked out
branch if no branch-name is given? I'd prefer if one has
to explicitly name the branch to delete.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
