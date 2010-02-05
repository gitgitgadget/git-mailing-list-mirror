From: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
Subject: reverting vs resetting
Date: Fri, 5 Feb 2010 09:12:23 +0300
Organization: Gulfsat
Message-ID: <20100205091223.6b4cffb1@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:06:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL3W-0003Bj-Du
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067Ab0BEGn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 01:43:27 -0500
Received: from static-104-36.blueline.mg ([41.204.104.36]:59726 "EHLO
	mail.blueline.mg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933097Ab0BEGn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 01:43:26 -0500
X-Greylist: delayed 1850 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2010 01:43:25 EST
Received: from localhost (spamassassin.malagasy.com [41.204.104.47])
	by mail.blueline.mg (Postfix) with ESMTP id EA030F83E
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 09:16:18 +0300 (EAT)
X-Virus-Scanned: par antivirus.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.692
X-Spam-Level: 
X-Spam-Status: No, score=-2.692 required=7 tests=[AWL=-0.093, BAYES_00=-2.599]
Received: from mail.blueline.mg ([41.204.104.38])
	by localhost (spamassassin.malagasy.com [41.204.104.47]) (amavisd-new, port 10024)
	with ESMTP id VLjWjGkajtLJ for <git@vger.kernel.org>;
	Fri,  5 Feb 2010 09:17:15 +0300 (EAT)
Received: from pbmiha.malagasy.com (sysadmin-cnc.malagasy.com [41.204.104.9])
	by mail.blueline.mg (Postfix) with ESMTP id 26FC6F83A
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 09:16:13 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=pbmiha.malagasy.com)
	by pbmiha.malagasy.com with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1NdHQV-0000hv-TR
	for git@vger.kernel.org; Fri, 05 Feb 2010 09:12:23 +0300
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139031>

Manao ahoana, Hello, Bonjour,

We put a gateway iptables script (SNAT, DNAT,...) under GIT.

Someone (Bob) made a mistake on it, but he did not know. That broke the
gateway.

Another one (Andy), did not try to undo Bob's mistake but tried (and
tried, and tried... always committing) to solve the problem. Andy made
about 50 commits.

When we decided to giveup, we decided to get back to the configuration
before Bob broke it. But it would be interesting to see Andy's history.

Reverting or resetting?

As far as I know: 
- Reverting Bob's commit will only cancel Bob's mistake but not Andy's
  tries to solve it.
- Resetting will forget the history.

Any suggestion?

Misaotra, Thanks, Merci.

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                +261 34 29 155 34 / +261 33 11 207 36
