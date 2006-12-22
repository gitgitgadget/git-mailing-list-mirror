From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Change in git-svn dcommit semantics?
Date: Fri, 22 Dec 2006 09:09:01 -0500
Message-ID: <3EB63EEE-0F78-47CE-B94E-325A9F6817C5@silverinsanity.com>
References: <m2mz5jegka.fsf@ziti.local> <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com> <Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de> <C2881A17-27F7-467C-B353-189BB7DBFD1E@silverinsanity.com> <7v3b7bnz6q.fsf@assigned-by-dhcp.cox.net> <emb77h$cf2$1@sea.gmane.org> <360A3F7A-0849-4BCE-8550-1F05BB9821C5@silverinsanity.com> <20061220115731.GA29786@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 22 15:09:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxl59-0007Y6-8S
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 15:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbWLVOJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 09:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbWLVOJE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 09:09:04 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:57780 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423039AbWLVOJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 09:09:03 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 77B431FFC02B;
	Fri, 22 Dec 2006 14:09:02 +0000 (UTC)
In-Reply-To: <20061220115731.GA29786@coredump.intra.peff.net>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35177>

On Dec 20, 2006, at 6:57 AM, Jeff King wrote:

> On Wed, Dec 20, 2006 at 06:47:45AM -0500, Brian Gernhardt wrote:
>
>>>> The --full-diff option helps because it shows the diff for other
>>>> files (that do not have different number of substring COLLISION
>>>> in the pre and postimage) in the same commit as well.
>>>
>>> Yet another undocumented option. Sigh...
>>
>> I'd send in a patch to fix that (little gnome work is what I do in
>> Wikipedia, and seems to be what I do here), but the option seems to
>> be in setup_revision.c:setup_revisions, which is used in several
>> places.  Is there a central place to put that in the documentation?
>> Should there be?
>
> Please read the rest of the thread for some explanation from Junio on
> how this option works.

I was trying to write quick documentation for this option, placing it  
in Documentation/diff-options.txt (is that the right place for it?),  
when I ran across --pickaxe-all.  How do the two options differ?

~~ Brian
