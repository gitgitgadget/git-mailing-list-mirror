From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 10:24:37 -0400
Message-ID: <95E642DA-F848-4398-9D9D-52B03A235887@silverinsanity.com>
References: <11848281302504-git-send-email-aroben@apple.com> <200707190848.54655.andyparkins@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 16:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBWwC-00088M-Bn
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 16:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760996AbXGSOYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 10:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbXGSOYj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 10:24:39 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:55248 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798AbXGSOYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 10:24:38 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 18C421FFC244;
	Thu, 19 Jul 2007 14:24:36 +0000 (UTC)
In-Reply-To: <200707190848.54655.andyparkins@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52992>


On Jul 19, 2007, at 3:48 AM, Andy Parkins wrote:

> On Thursday 2007 July 19, Adam Roben wrote:
>
>>    Well, it turns out we already do launch an editor in other places,
>> namely "git am -i" and "git send-email --compose". So, this patch  
>> takes
>> care of those cases as well.
>
> Perhaps I'm being overly pedantic, but it seems odd to put options  
> that are
> relevant only to porcelain under the "core" section.
>
> core.pager is in the same category - but that's already in.

Since I'm the one who added that, I feel compelled to add in my $0.02.

First, there wasn't much argument on the list when core.pager was  
added...  But that's not my major point.

To many git users (myself included), claiming that commands like git- 
commit, git-log, and other "porcelain" isn't part of "core" git is  
ridiculous.  These are the commands that I use every day, and are a  
part of the main git package, source, and repository.  If the  
porcelain was maintained separately from the pluming, like cognito  
was, perhaps that would be a more compelling argument to me.

For many people commit is more "core" to their git usage than write- 
tree and commit-tree.  At this point, it's less an extra layer  
porcelain and more the standard interface.  It's a result of the  
wonderful attempts to make git more user friendly.

As far as [core] being only for plumbing, I disagree with that  
premise as well.  Any option that is used across many of the git  
commands is a core (meaning central) option.

~~ Brian
