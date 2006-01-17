From: Mike McCormack <mike@codeweavers.com>
Subject: Re: git rebase behaviour changed?
Date: Tue, 17 Jan 2006 15:08:28 +0900
Organization: CodeWeavers
Message-ID: <43CC89DC.5060201@codeweavers.com>
References: <43CC695E.2020506@codeweavers.com> <7vslrnh080.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 07:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyk4q-00007G-0c
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 07:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWAQGMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 01:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWAQGMR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 01:12:17 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:32896 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751161AbWAQGMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 01:12:16 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1Eyk4k-0004QV-4y; Tue, 17 Jan 2006 00:12:16 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslrnh080.fsf@assigned-by-dhcp.cox.net>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14780>


Junio C Hamano wrote:

> Rebase changes the "master" branch when the development track
> between you (master) and upstream (origin) have forked:
> 
>                   1---2---3---4 master
>                  /
>         origin' 0---5---6 origin

Well, I thought I was in the above situation, but it seems that "origin" 
has been merged into "master" :/

The "pull, rebase, commit, commit, send patches, pull, ..." strategy 
used to work for me, but now it doesn't.

 > summary was: "if you do a merge, do not rebase; if you are going
 > to rebase, do not merge".  The thread is this one:

I want to do rebases.  So is it that behaviour of "git pull" that has 
been changed to do merges, and I should be using "fetch" instead of 
"pull" or something similar?

Mike


btw. I'm not the only person having this problem.  Others using the same 
commands, and upgrading GIT have run into it too, so something has 
changed...
