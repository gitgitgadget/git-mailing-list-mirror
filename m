From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Fri, 3 Aug 2007 07:08:44 +0200
Message-ID: <B14C42A6-F4BD-40D7-AEAF-66FFF492AB9B@zib.de>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <107BD473-E055-47D0-9720-9D878BDAB954@zib.de> <20070802223132.GA15212@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 07:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGpOK-0007Zv-Og
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 07:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbXHCFH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 01:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbXHCFH5
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 01:07:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:49164 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbXHCFH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 01:07:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7357rIX007974;
	Fri, 3 Aug 2007 07:07:53 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db15b99.pool.einsundeins.de [77.177.91.153])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7357qjp017690
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 3 Aug 2007 07:07:52 +0200 (MEST)
In-Reply-To: <20070802223132.GA15212@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54667>


On Aug 3, 2007, at 12:31 AM, J. Bruce Fields wrote:

>>> Also, I like the verb "stage" as a way to explain the part of the  
>>> index
>>> file in creating commits, but I've been consistently using the word
>>> "index" throughout the user manual, and I think that's consistent  
>>> with
>>> the rest of the documentation--so don't avoid it here.
>>
>> "staging/unstaging" is how git gui calls adding/removing files to and
>> from the index.
>
> I understand what you meant, but a reader of the user manual at this
> point might not, since it's been consistently saying things like  
> "to add
> the contents of a new file to the index, use git add".  So we  
> should use
> the same language here.  Unless we want to update the whole thing  
> to use
> "stage" and "unstage".  I'd rather not.

Agree. But we could briefly introduce git gui's dialect, something like

"git gui lets you select files (use menu 'Commit > Stage to Commit') or
individually diff hunks (use 'Stage Hunk For Commit' in context menu of
diff view) for inclusion in the index."

	Steffen
