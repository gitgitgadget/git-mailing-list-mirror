From: Andreas Ericsson <ae@op5.se>
Subject: Re: [man bug?] git rebase --preserve-merges
Date: Wed, 03 Dec 2008 08:43:24 +0100
Message-ID: <4936389C.9090904@op5.se>
References: <85647ef50812020845g7de701bbye4a43a4e992a264b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 08:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7mPn-0002PP-1Q
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 08:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbYLCHni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 02:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbYLCHni
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 02:43:38 -0500
Received: from mail.op5.se ([193.201.96.20]:39675 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbYLCHni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 02:43:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A906F1B8010D;
	Wed,  3 Dec 2008 08:40:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W4XpPb5leaDX; Wed,  3 Dec 2008 08:40:00 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 66EA61B80092;
	Wed,  3 Dec 2008 08:39:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <85647ef50812020845g7de701bbye4a43a4e992a264b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102221>

Constantine Plotnikov wrote:
> The man page for git rebase mentions "--preserve-merges" command line
> option but this option does not seems to be available.
> 
> Also if this option is specified, the following usage statement is printed:
> 
> Usage: git rebase [--interactive | -i] [-v] [--onto <newbase>]
> <upstream> [<branch>]
> 
> And this usage statement does not mention -m and -s options that seems
> to be available. I assume that the problem is the obsolete
> documentation.
> 

You're probably using an old git where merge-preserving rebase is only
available for interactive mode. Check the man-page again, and thoroughly
this time ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
