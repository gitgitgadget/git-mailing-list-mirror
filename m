From: Avi Kivity <avi@qumranet.com>
Subject: Re: git merge and merge message
Date: Mon, 12 Mar 2007 19:31:11 +0200
Message-ID: <45F58E5F.5070000@qumranet.com>
References: <200703111505.l2BF54Kq006625@localhost.localdomain> <20070311160424.GA629@fieldses.org> <200703111815.l2BIFHbq010315@localhost.localdomain> <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org> <45F46713.6030702@qumranet.com> <Pine.LNX.4.63.0703112241040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQoMf-00037s-9c
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXCLRbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbXCLRbO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:31:14 -0400
Received: from il.qumranet.com ([82.166.9.18]:34826 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbXCLRbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 13:31:13 -0400
Received: from [10.0.1.228] (blast.qumranet.com [10.0.1.228])
	by il.qumranet.com (Postfix) with ESMTP id A189BA008C;
	Mon, 12 Mar 2007 19:31:11 +0200 (IST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <Pine.LNX.4.63.0703112241040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42043>

Johannes Schindelin wrote:
>>>   
>>>       
>> Actually there's at least one tree where this should be activated -- 
>> yours. If you perform a fast-forward merge, there's no record of the 
>> merge, no record of which tree was pulled, and no sign-off from you.  
>> The commits just appear there.  It partially defeats the sign-off 
>> system.
>>
>> This feature would be good for top-level trees and for major subsystem 
>> trees IMO.
>>     
>
> What? You should sign-off on stuff you did not review? Or do you review 
> the stuff _before_ merging? I don't.
>   

Obviously one signs off only after some sort of review.  Some merges 
might be reviewed line-by-line, and some might be reviewed by looking at 
the maintainer's name and shortlog for a sanity check, but obviously you 
don't pull blind.

Anyway currently whether a merge record and a sign-off appear is a 
fairly random decision, based on the time of the last rebase the pullee 
did.  Whichever way is chosen (record/no record) I don't think it should 
be based on that.


-- 
error compiling committee.c: too many arguments to function
