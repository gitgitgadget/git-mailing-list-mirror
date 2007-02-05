From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sun, 4 Feb 2007 20:55:02 -0500
Message-ID: <EF3945DB-1CCB-4D8A-8300-FD4EB31CD583@silverinsanity.com>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <20070203181329.GA10192@179.242.249.10.in-addr.arpa> <7v4pq358q4.fsf@assigned-by-dhcp.cox.net> <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com> <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net> <A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com> <7vlkje243u.fsf@assigned-by-dhcp.cox.net> <155A5E6A-9EC5-424B-A231-02EF1FE0FD2B@silverinsanity.com> <D7716B9E-0F00-4AEF-95BC-699933B7FFD8@silverinsanity.com> <7vwt2xpezx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 02:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDt4m-0006JI-Ix
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 02:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbXBEBzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 20:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbXBEBzJ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 20:55:09 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38156 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbXBEBzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 20:55:08 -0500
Received: from [192.168.1.3] (cpe-66-66-74-194.rochester.res.rr.com [66.66.74.194])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 5D03F1FFC02B;
	Mon,  5 Feb 2007 01:55:07 +0000 (UTC)
In-Reply-To: <7vwt2xpezx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38718>


On Feb 4, 2007, at 8:30 PM, Junio C Hamano wrote:

> In reality, I find highly valuable that our tests find new bugs
> introduced in unexpected places.  I agree that the person who
> wrote t9200 did not _mean_ to test "git add", but it ended up
> helping us identify the problematic behaviour between creat()
> and readdir() on HFS+ affects "git add".

Alright, I understand that.  I just meant that since we've identified  
it, the workaround didn't matter much.

> So how about doing this instead?  It tests if the filesystem has
> that particular issue we know "git add" has a problem with, and
> skips the test in such an environment.

Yes, something like this is fine.  The patch looks good, but I  
couldn't get it to apply and don't have the time to fix it at the  
moment.  If you *need* me to test it, I'll do so tomorrow or Tuesday.

~~ Brian
