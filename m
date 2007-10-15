From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH 2/3] Quoting paths in tests
Date: Mon, 15 Oct 2007 15:00:38 +0100
Message-ID: <8977E4C2-2C13-4C52-8FD9-CEEB5AA85B70@steelskies.com>
References: <4711486B.1050301@op5.se> <11924540291536-git-send-email-maillist@steelskies.com> <47136F71.1050107@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 16:01:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQV5-00068U-NM
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099AbXJOOAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 10:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756750AbXJOOAp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:00:45 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:53690 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbXJOOAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:00:44 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:62398)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IhQUt-0005wJ-62; Mon, 15 Oct 2007 10:00:43 -0400
In-Reply-To: <47136F71.1050107@viscovery.net>
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60997>

On 15 Oct 2007, at 14:47, Johannes Sixt wrote:

> Jonathan del Strother schrieb:
>> -	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
>> +	svn import -m 'import for git-svn' . '$svnrepo' >/dev/null &&
>> 	cd .. &&
>> 	rm -rf import &&
>> -	git-svn init $svnrepo"
>> +	git-svn init '$svnrepo'"
>
> I don't see the point in changing an incorrect quoting to a  
> different incorrect quoting that you fix up in a follow-up patch.  
> It's *two* large patches to review instead of just one. I'm stopping  
> the review here.

If we want to support apostrophed paths in tests, I'll flatten 2 & 3  
into a single patch.  I thought I'd make the apostrophe part optional  
since there seemed to be some resistance to having to bother about  
quoting & escaping in tests..
