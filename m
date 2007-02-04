From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sun, 4 Feb 2007 11:50:33 -0500
Message-ID: <D7716B9E-0F00-4AEF-95BC-699933B7FFD8@silverinsanity.com>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <20070203181329.GA10192@179.242.249.10.in-addr.arpa> <7v4pq358q4.fsf@assigned-by-dhcp.cox.net> <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com> <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net> <A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com> <7vlkje243u.fsf@assigned-by-dhcp.cox.net> <155A5E6A-9EC5-424B-A231-02EF1FE0FD2B@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 17:51:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDkZu-0006Pw-F9
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 17:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbXBDQuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 11:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbXBDQuh
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 11:50:37 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:48401 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbXBDQug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 11:50:36 -0500
Received: from [192.168.1.3] (cpe-66-66-74-194.rochester.res.rr.com [66.66.74.194])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 5601D1FFC02B;
	Sun,  4 Feb 2007 16:50:35 +0000 (UTC)
In-Reply-To: <155A5E6A-9EC5-424B-A231-02EF1FE0FD2B@silverinsanity.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38696>

And I forgot to re-iterate that the "-f" in the test only bypasses  
the .gitignore machinery which is perfectly safe in a test  
environment where the ignore files are empty, and makes the git- 
cvsexportcommit test only git-cvsexportcommit.  If you wish to add a  
test for filesystem stupidity separately, that's a different issue.

I really think the patch is useful and allows the test to pass even  
on systems with idiotic filesystems and doesn't make it vulnerable to  
any bugs in cvsexportcommit.  (Bugs in git-add, maybe, but that's not  
what it's testing.)

~~ Brian
