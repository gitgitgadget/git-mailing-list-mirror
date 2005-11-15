From: Mike McCormack <mike@codeweavers.com>
Subject: Re: pushing patches to an imap folder
Date: Tue, 15 Nov 2005 19:35:34 +0900
Organization: CodeWeavers
Message-ID: <4379B9F6.5020402@codeweavers.com>
References: <43799A67.9030705@codeweavers.com> <7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 11:40:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbyD3-0004CP-Q3
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 11:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVKOKie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVKOKie
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 05:38:34 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:38347 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751419AbVKOKie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 05:38:34 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1EbyCn-0002GQ-87; Tue, 15 Nov 2005 04:38:33 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11895>


Junio C Hamano wrote:

> Hmph.  How well does the rest of git help your workflow, working
> with the Wine community?  Especially, how are you keeping track
> of and interoperating with their main CVS repository? 

We have a (semi-experimental) wine.git tree, which is updated at the 
same time as the Wine CVS, by the project maintainer:

http://source.winehq.org/git/wine.git

It will probably be maintained in parallel with the Wine CVS for a 
while, unless somebody writes a GIT->CVS gateway.

I find git-rebase to be particularly useful.  When I used CVS, sending a 
series of patches was a pain. I'd contemplated using quilt, but never 
got round to trying it.

Pushing patches from git into a drafts folder means I don't have to 
manually generate a diff, open a mail, type the mailing list address, 
attach the patch and write/copy-paste a ChangeLog entry.

> Do you
> have to do anything special when your patches are accepted by
> the upstream and echoed back to you when you 'cvs update' from
> them next time?

"git pull" is usually sufficient.

Mike
