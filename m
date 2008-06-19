From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Documentation: Simplify git-rev-parse's example
Date: Fri, 20 Jun 2008 01:02:07 +0200
Message-ID: <D6812FD2-F61D-4813-95B4-4FCCDE35C418@ai.rug.nl>
References: <1213873976-4192-1-git-send-email-pdebie@ai.rug.nl> <485AAF82.3030209@freescale.com> <7v8wx1te20.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jon Loeliger <jdl@freescale.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9T9m-0001fK-EV
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYFSXCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYFSXCK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:02:10 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:62627 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbYFSXCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:02:09 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6012.online.nl (SMTP Server) with ESMTP id 23B7D1C0008C;
	Fri, 20 Jun 2008 01:02:08 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6012.online.nl (SMTP Server) with ESMTP id BE12B1C00083;
	Fri, 20 Jun 2008 01:02:07 +0200 (CEST)
X-ME-UUID: 20080619230207778.BE12B1C00083@mwinf6012.online.nl
In-Reply-To: <7v8wx1te20.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85559>


On 19 jun 2008, at 21:33, Junio C Hamano wrote:

>> How is this a vast improvement?
>>
>> I could see that inverting it top-to-bottom would
>> be more consistent with gitk or show-branch output.
>> Your example doesn't have a 3-parent commit, though,
>> and it isn't _that_ much simpler otherwise...
>>
>> So this is really better _how_?
>>
>> Oh, right, of course.  It removes my name.  Got it. :-)
>
> I agree that the patch should have just flipped the tree upside down
> without changing the shape of the history the section talks about.

I tried to make it less of a monster while still keeping examples of
all possibilities, which is why I removed two of the nodes.

> Yet another improvement would have been turning it sideways, not  
> upside
> down, because that is how we typically write history in our  
> documentation
> (time flows from left to right -- see e.g. git-rebase.txt).

I tried to do that, but wasn't able to create a nice-looking graph,  
which
is why I settled on this version.

> I happen to think the last point you raise is an improvement.  It will
> quickly become unreadble after a while if we credit individual  
> authors for
> every paragraph in-text, and it always bothered me to see somebody's  
> name
> (don't get me wrong -- this is not because it is your name nor  
> because it
> is not my name, but because it _is_ a name), there but I wasn't bold
> enough to remove it without discussion.

I did not want to keep a name with something that was modified, since it
might not get the author's approval. That's why I removed it. I also  
agree
that it reads better.
