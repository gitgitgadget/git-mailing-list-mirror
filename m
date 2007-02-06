From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Tue, 6 Feb 2007 10:17:00 -0500
Message-ID: <981DBEC8-99B6-4921-81DE-CE739EAB3196@silverinsanity.com>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <20070203181329.GA10192@179.242.249.10.in-addr.arpa> <7v4pq358q4.fsf@assigned-by-dhcp.cox.net> <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com> <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net> <A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com> <7vlkje243u.fsf@assigned-by-dhcp.cox.net> <155A5E6A-9EC5-424B-A231-02EF1FE0FD2B@silverinsanity.com> <D7716B9E-0F00-4AEF-95BC-699933B7FFD8@silverinsanity.com> <7vwt2xpezx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 16:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HES4T-0008SA-KQ
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 16:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbXBFPRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 10:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbXBFPRK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 10:17:10 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:57967 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477AbXBFPRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 10:17:09 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 1C9841FFC02B;
	Tue,  6 Feb 2007 15:17:07 +0000 (UTC)
In-Reply-To: <7vwt2xpezx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38848>


On Feb 4, 2007, at 8:30 PM, Junio C Hamano wrote:

> So how about doing this instead?  It tests if the filesystem has
> that particular issue we know "git add" has a problem with, and
> skips the test in such an environment.

I'd be tempted to add a "test_expect_success 'skipping UTF8 test on  
broken filesystem'", but I finally tested it (Sunday and Monday are  
my weekends) and it works as expected.  Thanks.

~~ Brian
