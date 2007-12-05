From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to jump between two repositories ...
Date: Wed, 05 Dec 2007 17:19:09 +0100
Message-ID: <4756CF7D.6090500@op5.se>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com> <20071205061425.GE11098@fieldses.org> <47566526.9010900@op5.se> <9F403ACE-62C0-4A6D-945C-3DA6DF0316B8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: g2 <gerald.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzwyR-0003Ow-Oh
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 17:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXLEQTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 11:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbXLEQTR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 11:19:17 -0500
Received: from mail.op5.se ([193.201.96.20]:47329 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbXLEQTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 11:19:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4BC261F08082;
	Wed,  5 Dec 2007 17:19:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fO88Ny14jqX7; Wed,  5 Dec 2007 17:19:14 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id A5EA81F0805B;
	Wed,  5 Dec 2007 17:19:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <9F403ACE-62C0-4A6D-945C-3DA6DF0316B8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67164>

post
top-
don't
Please

g2 wrote:
> 
> How do you safely push to the repository? Even if my receiving 
> repository is pristine (the last command I do is a commit), after I push 
> into it, some files in the work-tree are effectively out of date and git 
> says so by thinking they are modified and staged for commit. My original 
> set of example commands illustrates this. What set of commands do you 
> use to avoid the problem?
> 

Vanilla git-push, ofcourse. I just make sure to run "git reset --hard" in
the receiving repo before using anything in it. Granted, it's "safe"
because I know I never want to use any changes from those repos and not.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
