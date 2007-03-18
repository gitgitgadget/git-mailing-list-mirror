From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFH] straightening out "read-tree -m"
Date: Sun, 18 Mar 2007 12:06:12 -0400
Message-ID: <16CD10D5-3BDA-4DFE-A8C6-96D48F511824@silverinsanity.com>
References: <7vtzwjnhcb.fsf@assigned-by-dhcp.cox.net> <20070318121810.GA17807@moooo.ath.cx>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 17:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSxtv-0007n6-EH
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 17:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXCRQGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 12:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbXCRQGS
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 12:06:18 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42519 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbXCRQGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 12:06:17 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A74B41FFC132;
	Sun, 18 Mar 2007 16:06:15 +0000 (UTC)
In-Reply-To: <20070318121810.GA17807@moooo.ath.cx>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42502>


On Mar 18, 2007, at 8:18 AM, Matthias Lederhofer wrote:

> Junio C Hamano <junkio@cox.net> wrote:
>> A	B	Outcome
>> ----------------------------------------------------------------
>> D	D	No problem.
>>
>> D	F	This should result in refusal when there are
>>                 local modification to paths in "foo" directory,
>> 		or there are untracked (but unignored) paths in
>>                 "foo/".
>
> What about ignored configuration files like config.mak?
> Let's say there is an ignored configuration file in a subdirectory.
> If this subdirectory is replaced by a file git would delete the
> ignored configuration file?

I would sincerely hope that a file not being tracked by git would  
count as "local modifications" in that case.  "Ignored" does not mean  
"unimportant".

My $0.02,
~~ Brian
