From: Peter Krefting <peter@softwolves.pp.se>
Subject: RE: Use "git pull --ff-only" by default?
Date: Fri, 21 May 2010 18:49:52 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1005211848160.9961@perkele.intern.softwolves.pp.se>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
 <4BF68F5F.9010309@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Fri May 21 19:50:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFWMB-0003L3-Md
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 19:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758576Ab0EURtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 13:49:55 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49557 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509Ab0EURty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 13:49:54 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L2S00C8A6V4ER50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 21 May 2010 19:49:52 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9C3591EA583E_BF6C7C0B	for <git@vger.kernel.org>; Fri,
 21 May 2010 17:49:52 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 834731EA36C2_BF6C7C0F	for <git@vger.kernel.org>; Fri,
 21 May 2010 17:49:52 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L2S00JQC6V4LQ20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 21 May 2010 19:49:52 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id 633F72FC00; Fri,
 21 May 2010 19:49:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 604532FBFF; Fri, 21 May 2010 18:49:52 +0100 (CET)
In-reply-to: <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147489>

Peter Kjellerstedt:

> Can you differentiate between an automatic merge which happened because 
> the user had made some local changes before pulling (which I do not want 
> to appear in the central repo), and a real merge of a topic branch (which 
> I do want)?

Sort of, by looking at the commit message. An auto-generated pull-merge will 
contain the branch name twice, once with the remote repository path, and 
once with the local repository path. You could walk the history that the 
user tries to push, looking for this kind of auto-generated merge messages.

This may of course teach your users to re-write the commit message into 
something more sensible, but that can only be a good thing :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
